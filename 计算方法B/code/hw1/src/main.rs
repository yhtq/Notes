extern crate nalgebra as na;
use std::{cell::OnceCell , usize};

use na::{zero, DefaultAllocator, OMatrix, OVector, Dim, Const};

type Matrix<T, R, C> = OMatrix<T, R, C>;
type Vector<T, R> = OVector<T, R>;

fn max<T: PartialOrd>(a: T, b: T) -> T {
    if a > b {
        a
    } else {
        b
    }
}

fn r_eq<T, R, C> (a: &Matrix<T, R, C>, b: &Matrix<T, R, C>) -> bool
where
    T: na::RealField + Copy,
    R: na::Dim,
    C: na::Dim,
    DefaultAllocator: na::allocator::Allocator<R, C>
{
    (a - b).norm() < T::from_f64(0.1).unwrap() * max(a.norm(), b.norm())
}
fn is_upper_triangular<T, R>(m: &Matrix<T, R, R>) -> bool
where
    T: na::RealField + Copy,
    R: na::Dim,
    DefaultAllocator: na::allocator::Allocator<R, R>
{
    for i in 0..(m.nrows() - 1) {
        for j in 0..i {
            if m[(i, j)].abs() > T::default_epsilon() {
                return false;
            }
        }
    }
    true
}
fn is_lower_triangle<T, R>(m: &Matrix<T, R, R>) -> bool
where
    T: na::RealField + Copy,
    R: na::Dim,
    DefaultAllocator: na::allocator::Allocator<R, R>
    {
    for i in 0..(m.nrows() - 1) {
        for j in (i + 1)..m.ncols() {
            if m[(i, j)].abs() > T::default_epsilon() {
                return false;
            }
        }
    }
    true
}

// 解线性方程 m x = b，其中 m 为上三角矩阵
fn solve_upper_linear_equation<T, R>
    (
        m: &Matrix<T, R, R>, 
        b: &Vector<T, R>
    ) -> Vector<T, R>
where
    T: na::RealField + Copy,
    R: Dim,
    DefaultAllocator: na::allocator::Allocator<R, R> + na::allocator::Allocator<R>,
{
    assert!(is_upper_triangular(m));
    let mut x: Vector<T, R> = Matrix::<T, R, Const<1>>::zeros_generic(Dim::from_usize(m.nrows()), Dim::from_usize(1));
    for i in (0..m.nrows()).rev() {
        let sum = (i + 1..m.nrows()).fold(zero(), |sum, j| sum + m[(i, j)] * x[j]); // sigma_(k = i + 1)^(m.nrows()) m(i, k) * x(k)
        x[i] = (b[i] - sum) / m[(i, i)];
    }
    x
}
// 解线性方程 m x = b，其中 m 为下三角矩阵
fn solve_lower_linear_equation<T, R>
    (
        m: &Matrix<T, R, R>, 
        b: &Vector<T, R>
    ) -> Vector<T, R>
where
    T: na::RealField + Copy,
    R: Dim,
    DefaultAllocator: na::allocator::Allocator<R, R> + na::allocator::Allocator<R>,
{
    assert!(is_lower_triangle(m));
    let mut x: Vector<T, R> = Vector::zeros_generic(Dim::from_usize(m.nrows()), Dim::from_usize(1));
    for i in 0..m.nrows() {
        let sum = (0..i).fold(zero(), |sum, j| sum + m[(i, j)] * x[j]); // sigma_(k = 0)^(i - 1) m(i, k) * x(k)
        x[i] = (b[i] - sum) / m[(i, i)];
    }
    x
}
fn solve_linear_equation_ensures<T, R>
    (
        m: &Matrix<T, R, R>,
        b: &Vector<T, R>,
        x: &Vector<T, R>
    ) -> ()
where
    T: na::RealField + Copy,
    R: Dim,
    DefaultAllocator: na::allocator::Allocator<R, R> + na::allocator::Allocator<R>,
{
    assert!(r_eq(&(m * x), b));
}
// LU 分解，求 a = l * u，其中 l 为单位下三角矩阵，u 为上三角矩阵。该函数会消耗掉 a 的所有权。
fn lu_decomposite<T, R>
    (
        mut a: Matrix<T, R, R>
    ) -> (Matrix<T, R, R>, Matrix<T, R, R>)
where
    T: na::RealField + Copy,
    R: Dim,
    DefaultAllocator: na::allocator::Allocator<R, R> + na::allocator::Allocator<R>,
{
    let mut l: Matrix<T, R, R> = Matrix::identity_generic(Dim::from_usize(a.nrows()), Dim::from_usize(a.ncols()));
    for i in 0..a.nrows() {
        for j in (i + 1)..a.nrows() {
            if a[(i, i)] == T::zero() {
                panic!("zero pivot");
            }
            l[(j, i)] = a[(j, i)] / a[(i, i)];
            for k in i..a.nrows() {
                a[(j, k)] = a[(j, k)] - l[(j, i)] * a[(i, k)];
            }
        }
    }
    (l, a)
}
fn lu_requires<T, R>
    (
        a: &Matrix<T, R, R>
    ) -> ()
where
    T: na::RealField + Copy,
    R: Dim,
    DefaultAllocator: na::allocator::Allocator<R, R> + na::allocator::Allocator<R>,
{
    assert!(a.nrows() == a.ncols());
}
fn lu_ensures<T, R>
    (
        a: &Matrix<T, R, R>,
        r: &(Matrix<T, R, R>, Matrix<T, R, R>)
    ) -> ()
where
    T: na::RealField + Copy,
    R: Dim,
    DefaultAllocator: na::allocator::Allocator<R, R> + na::allocator::Allocator<R>,
{
    let (l, u) = r;
    assert!(l.nrows() == u.nrows());
    assert!(l.ncols() == u.ncols());
    assert!(is_upper_triangular(u));
    assert!(is_lower_triangle(l));
    for i in 0..l.nrows() {
        assert_eq!(l[(i, i)], T::one());
    }
    assert!(r_eq(&(l * u), a));
}
// 列主元 LU 分解，返回值为 (l, u, p)，其中 l 为单位下三角矩阵，u 为上三角矩阵，p 为置换矩阵。该函数会消耗掉 a 的所有权。
fn lu_col_pivot<T, R>
(
    mut a: Matrix<T, R, R>
) -> (Matrix<T, R, R>, Matrix<T, R, R>, Matrix<T, R, R>)
where
T: na::RealField + Copy,
R: Dim,
DefaultAllocator: na::allocator::Allocator<R, R> + na::allocator::Allocator<R>,
{
    let mut l_temp: Matrix<T, R, R> = Matrix::identity_generic(Dim::from_usize(a.nrows()), Dim::from_usize(a.ncols()));
    let mut p: Matrix<T, R, R> = Matrix::identity_generic(Dim::from_usize(a.nrows()), Dim::from_usize(a.ncols()));
    for i in 0..a.nrows() {
        let pivot_index = a.column(i).rows_range(i..a.nrows()).iamax() + i; // 选取列 i 中绝对值最大的元素所在的行
        a.swap_rows(i, pivot_index);
        p.swap_rows(i, pivot_index);
        l_temp.swap_columns(i, pivot_index);    // 注意这里记录的是 P_i^(-1) L_i^(-1)，而不是 L_i
        for j in (i + 1)..a.nrows() {
            if a[(i, i)] == T::zero() {
                panic!("zero pivot in col pivot lu");
            }
            let ratio = a[(j, i)] / a[(i, i)];
            // for k in 0..l_temp.ncols() {
            //     l_temp[(j, k)] = l_temp[(j, k)] + ratio * l_temp[(i, k)];
            // }
            for k in 0..l_temp.nrows() {
                l_temp[(k, i)] = l_temp[(k, i)] + ratio * l_temp[(k, j)];
            }
            for k in i..a.ncols() {
                a[(j, k)] =  a[(j, k)] - ratio * a[(i, k)];
            }
        }
    }
    ((p.clone()) * l_temp, a, p)
}
fn lu_col_ensures<T, R>
    (
        a: &Matrix<T, R, R>,
        r: &(Matrix<T, R, R>, Matrix<T, R, R>, Matrix<T, R, R>)
    ) -> ()
where
    T: na::RealField + Copy,
    R: Dim,
    DefaultAllocator: na::allocator::Allocator<R, R> + na::allocator::Allocator<R>,
{
    let (l, u, p) = r;
    assert!(l.nrows() == u.nrows());
    assert!(l.ncols() == u.ncols());
    assert!(is_upper_triangular(u));
    assert!(is_lower_triangle(l));
    for i in 0..l.nrows() {
        assert_eq!(l[(i, i)], T::one());
    }
    assert!(r_eq(&(p * a), &(l * u)));
}

struct LU<'a, T, R>
where
    T: na::RealField + Copy,
    R: Dim,
    DefaultAllocator: na::allocator::Allocator<R, R> + na::allocator::Allocator<R>,
{
    a: &'a Matrix<T, R, R>,
    lu: OnceCell<(Matrix<T, R, R>, Matrix<T, R, R>)>,   // 惰性计算 LU 分解，使用时再计算
    lu_col: OnceCell<(Matrix<T, R, R>, Matrix<T, R, R>, Matrix<T, R, R>)>,   // 惰性计算列主元 LU 分解，使用时再计算
}
impl <'a, T, R> LU<'a, T, R>
where
    T: na::RealField + Copy,
    R: Dim,
    DefaultAllocator: na::allocator::Allocator<R, R> + na::allocator::Allocator<R>,
{
    fn new(a: &'a Matrix<T, R, R>) -> Self {
        Self {
            a,
            lu: OnceCell::new(),
            lu_col: OnceCell::new(),
        }
    }
    fn get_lu(&self) -> &(Matrix<T, R, R>, Matrix<T, R, R>) {
        self.lu.get_or_init(|| lu_decomposite(self.a.clone()))
    }
    fn get_lu_col(&self) -> &(Matrix<T, R, R>, Matrix<T, R, R>, Matrix<T, R, R>) {
        self.lu_col.get_or_init(|| lu_col_pivot(self.a.clone()))
    }
    fn solve_linear_equation_lu(&self, b: &Vector<T, R>) -> Vector<T, R> {
        // a x = b => l u x = b 
        let (l, u) = self.get_lu();
        let y = solve_lower_linear_equation(&l, b);
        let x = solve_upper_linear_equation(&u, &y);
        x

    }
    fn solve_linear_equation_lu_col(&self, b: &Vector<T, R>) -> Vector<T, R> {
        // a x = b => p a x = p b => l u x = p b 
        let (l, u, p) = self.get_lu_col();
        let y = solve_lower_linear_equation(&l, &(p * b));  // l y = p b
        solve_upper_linear_equation(&u, &y) // u x = y
    }
}

fn cholesky_decomposite<T, R>
    (
        a: &Matrix<T, R, R>
    ) -> Matrix<T, R, R>
where
    T: na::RealField + Copy,
    R: Dim,
    DefaultAllocator: na::allocator::Allocator<R, R> + na::allocator::Allocator<R>,
{
    let mut l: Matrix<T, R, R> = Matrix::zeros_generic(Dim::from_usize(a.nrows()), Dim::from_usize(a.ncols()));
    for i in 0..a.nrows() {
        l[(i, i)] = (a[(i, i)] - (0..i).fold(T::zero(), |sum, j| sum + l[(i, j)] * l[(i, j)])).sqrt();  // l(i, i) = sqrt(a(i, i) - sigma_(k = 0)^(i - 1) l(i, k) ^ 2)
        for j in 0..i {
            let sum = (0..j).fold(T::zero(), |sum, k| sum + l[(i, k)] * l[(j, k)]); // sigma_(k = 0)^(j - 1) l(i, k) * l(j, k)
            l[(i, j)] = (a[(i, j)] - sum) / l[(j, j)];
        }
    }
    l
}

fn cholesky_ensures<T, R>
    (
        a: &Matrix<T, R, R>,
        l: &Matrix<T, R, R>
    ) -> ()
where
    T: na::RealField + Copy,
    R: Dim,
    DefaultAllocator: na::allocator::Allocator<R, R> + na::allocator::Allocator<R>,
{
    assert!(l.nrows() == l.ncols());
    assert!(r_eq(&(l * l.transpose()), a));
}

fn improved_cholesky_decomposite<T, R>
    (
        a: &Matrix<T, R, R>
    ) -> (Matrix<T, R, R>, Matrix<T, R, R>)
where
    T: na::RealField + Copy,
    R: Dim,
    DefaultAllocator: na::allocator::Allocator<R, R> + na::allocator::Allocator<R>,
{
    let mut l: Matrix<T, R, R> = Matrix::zeros_generic(Dim::from_usize(a.nrows()), Dim::from_usize(a.ncols()));
    let mut d: Matrix<T, R, R> = Matrix::zeros_generic(Dim::from_usize(a.nrows()), Dim::from_usize(a.ncols()));
    for i in 0..a.nrows() {
        d[(i, i)] = a[(i, i)] - (0..i).fold(T::zero(), |sum, k| sum + l[(i, k)] * l[(i, k)] * d[(k, k)]);  // d(i, i) = a(i, i) - sigma_(k = 0)^(i - 1) l(i, k) ^ d(k, k)
        l[(i, i)] = T::one();
        for j in 0..i {
            let sum = (0..j).fold(T::zero(), |sum, k| sum + l[(i, k)] * l[(j, k)] * d[(k, k)]); // sigma_(k = 0)^(j - 1) l(i, k) * l(j, k) * d(k, k)
            l[(i, j)] = (a[(i, j)] - sum) / d[(j, j)];
        }
    }
    (l, d)
}

fn improved_cholesky_ensures<T, R>
    (
        a: &Matrix<T, R, R>,
        r: &(Matrix<T, R, R>, Matrix<T, R, R>)
    ) -> ()
where
    T: na::RealField + Copy,
    R: Dim,
    DefaultAllocator: na::allocator::Allocator<R, R> + na::allocator::Allocator<R>,
{
    let (l, d) = r;
    assert!(l.nrows() == l.ncols());
    assert!(d.nrows() == d.ncols());
    assert!(is_lower_triangle(l));
    assert!(r_eq(&(l * d * l.transpose()), a));
}

struct Cholesky<'a, T, R>
where
    T: na::RealField + Copy,
    R: Dim,
    DefaultAllocator: na::allocator::Allocator<R, R> + na::allocator::Allocator<R>,
{
    a: &'a Matrix<T, R, R>,
    cholesky: OnceCell<Matrix<T, R, R>>,   // 惰性计算 Cholesky 分解，使用时再计算
    improved_cholesky: OnceCell<(Matrix<T, R, R>, Matrix<T, R, R>)>,   // 惰性计算改进 Cholesky 分解，使用时再计算
}
impl <'a, T, R> Cholesky<'a, T, R>
where
    T: na::RealField + Copy,
    R: Dim,
    DefaultAllocator: na::allocator::Allocator<R, R> + na::allocator::Allocator<R>,
{
    fn new(a: &'a Matrix<T, R, R>) -> Self {
        Self {
            a,
            cholesky: OnceCell::new(),
            improved_cholesky: OnceCell::new(),
        }
    }
    fn get_cholesky(&self) -> &Matrix<T, R, R> {
        self.cholesky.get_or_init(|| cholesky_decomposite(self.a))
    }
    fn get_improved_cholesky(&self) -> &(Matrix<T, R, R>, Matrix<T, R, R>) {
        self.improved_cholesky.get_or_init(|| improved_cholesky_decomposite(self.a))
    }
    fn solve_linear_equation_cholesky(&self, b: &Vector<T, R>) -> Vector<T, R> {
        // a x = b => l l^T x = b
        let l = self.get_cholesky();
        let y = solve_lower_linear_equation(&l, b);
        let x = solve_upper_linear_equation(&l.transpose(), &y);
        x
    }
    fn solve_linear_equation_improved_cholesky(&self, b: &Vector<T, R>) -> Vector<T, R> {
        // a x = b => l d l^T x = b
        let (l, d) = self.get_improved_cholesky();
        let mut y = solve_lower_linear_equation(&l, b);
        for i in 0..d.nrows() {
            y[i] = y[i] / d[(i, i)];
        }
        let x = solve_upper_linear_equation(&l.transpose(), &y);
        x
    }
}

enum SubSign {
    NonNegative,
    Negative,
}

fn signed_sub_of_usize(a: usize, b: usize) -> (usize, SubSign) {
    if a > b {
        (a - b, SubSign::NonNegative)
    } else {
        (b - a, SubSign::Negative)
    }
}

fn main() {
    let matrix_in_exercise_1 = Matrix::<f64, Const<84>, Const<84>>::from_fn(
        |i, j| 
            match signed_sub_of_usize(i, j) {
                (1, SubSign::NonNegative) => 8.0,
                (0, _) => 6.0,
                (1, SubSign::Negative) => 1.0,
                _ => 0.0
            }
    );
    // let matrix_in_exercise_1 = Matrix2::new(
    //     1.0, 1.5,
    //     20.0, 1.0
    // );
    let b_in_exercise_1 = Vector::<f64, Const<84>>::from_fn(
        |i, _| 
            match i {
                0 => 7.0,
                83 => 14.0,
                _ => 15.0
            }
     );
    lu_requires(&matrix_in_exercise_1);
    let (l, u) = lu_decomposite(matrix_in_exercise_1.clone());
    lu_ensures(&matrix_in_exercise_1, &(l, u));
    let (lc, uc, pc) = lu_col_pivot(matrix_in_exercise_1.clone());
    lu_col_ensures(&matrix_in_exercise_1, &(lc, uc, pc));
    let lu = LU::new(&matrix_in_exercise_1);
    let x = lu.solve_linear_equation_lu(&b_in_exercise_1);
    println!("finish solving LU, x = {:?}\n m * x = {:?}\n b = {:?}\n L2 delta = {:?}", x, matrix_in_exercise_1 * x, b_in_exercise_1, (matrix_in_exercise_1 * x - b_in_exercise_1).norm());
    solve_linear_equation_ensures(&matrix_in_exercise_1, &b_in_exercise_1, &x);
    let x_col = lu.solve_linear_equation_lu_col(&b_in_exercise_1);
    solve_linear_equation_ensures(&matrix_in_exercise_1, &b_in_exercise_1, &x_col);
    println!("finish solving LU col, x = {:?}\n m * x = {:?}\n b = {:?}\n L2 delta = {:?}", x_col, matrix_in_exercise_1 * x_col, b_in_exercise_1, (matrix_in_exercise_1 * x_col - b_in_exercise_1).norm());

    let matrix_in_exercise_2 = Matrix::<f64, Const<100>, Const<100>>::from_fn(
        |i, j| 
            match signed_sub_of_usize(i, j) {
                (1, _) => 1.0,
                (0, _) => 10.0,
                _ => 0.0
            }
    );
    let b2 = Vector::<f64, Const<100>>::new_random();
    let cholesky = Cholesky::new(&matrix_in_exercise_2);
    cholesky_ensures(&matrix_in_exercise_2, cholesky.get_cholesky());
    improved_cholesky_ensures(&matrix_in_exercise_2, cholesky.get_improved_cholesky());
    let x_cholesky = cholesky.solve_linear_equation_cholesky(&b2);
    println!("finish solving Cholesky, x = {:?}\n m * x = {:?}\n b = {:?}\n L2 delta = {:?}", x_cholesky, matrix_in_exercise_2 * x_cholesky, b2, (matrix_in_exercise_2 * x_cholesky - b2).norm());
    solve_linear_equation_ensures(&matrix_in_exercise_2, &b2, &x_cholesky);
    let x_improved_cholesky = cholesky.solve_linear_equation_improved_cholesky(&b2);
    println!("finish solving improved Cholesky, x = {:?}\n m * x = {:?}\n b = {:?}\n L2 delta = {:?}", x_improved_cholesky, matrix_in_exercise_2 * x_improved_cholesky, b2, (matrix_in_exercise_2 * x_improved_cholesky - b2).norm());
    solve_linear_equation_ensures(&matrix_in_exercise_2, &b2, &x_improved_cholesky);
    
}
