extern crate nalgebra as na;
pub mod LUcode;
use std::{array::from_fn, cell::OnceCell, usize};
use na::{zero, Const, DefaultAllocator, Dim, Matrix, Vector, OMatrix, OVector, Unit};

fn max<T: PartialOrd>(a: T, b: T) -> T {
    if a > b {
        a
    } else {
        b
    }
}

fn r_eq<T, R, C, S1, S2> (a: &Matrix<T, R, C, S1>, b: &Matrix<T, R, C, S2>) -> bool
where
    T: na::RealField + Copy,
    R: na::Dim,
    C: na::Dim,
    S1: na::storage::Storage<T, R, C>,
    S2: na::storage::Storage<T, R, C>,
    DefaultAllocator: na::allocator::Allocator<R, C>
{
    (a - b).norm() < T::from_f64(0.1).unwrap() * max(a.norm(), b.norm())
}

fn is_upper_triangle<T, R, C, S>(m: &Matrix<T, R, C, S>) -> bool
where
    T: na::RealField + Copy,
    R: na::Dim,
    C: na::Dim,
    S: na::storage::Storage<T, R, C>,
{
    let (nrows, ncols) = m.shape();
    for i in 0..nrows {
        for j in 0..i {
            if m[(i, j)].abs() > T::from_f64(0.1).unwrap() {
                return false;
            }
        }
    }
    true
}

fn square<T> (a: T) -> T
where
    T: std::ops::Mul<Output = T> + Copy,
{
    a * a
}

// 做 Householder 变换，返回单位向量 v
fn HouseholderTransformation<T, R, S>(a: &Vector<T, R, S>) -> OVector<T, R>
where
    T: na::RealField + Copy,
    R: na::Dim,
    S: na::storage::Storage<T, R, na::U1>,
    DefaultAllocator: na::allocator::Allocator<R>,
{
    let n = a.nrows();
    let sigma = square(a.column(0).rows_range(1..n).norm());
    let alpha = T::sqrt(sigma + square(a[(0, 0)]));
    let mut v = a.clone_owned();
    if sigma.abs() < T::default_epsilon() {
        OVector::<T, R>::zeros_generic(Dim::from_usize(n), Dim::from_usize(1))
    } else {
        v[(0, 0)] = if a[(0, 0)] <= T::zero() {
            a[(0, 0)] - alpha
        } else {
            -sigma / (a[(0, 0)] + alpha)
        };
        v.normalize()
    }
}

fn get_Householder_matrix<T, R, S>(v: &Vector<T, R, S>) -> OMatrix<T, R, R>
where
    T: na::RealField + Copy,
    R: na::Dim,
    S: na::storage::Storage<T, R, na::U1>,
    DefaultAllocator: na::allocator::Allocator<R> + na::allocator::Allocator<R, R>,
{
    let n = v.nrows();
    let mut H = OMatrix::<T, R, R>::identity_generic(Dim::from_usize(n), Dim::from_usize(n));
    let two = T::from_i32(2).unwrap();
    for i in 0..n {
        for j in 0..n {
            H[(i, j)] -= two * v[(i, 0)] * v[(j, 0)];
        }
    }
    H
}

fn Householder_ensures<T, R, S1, S2>(a: &Vector<T, R, S1>, v: &Vector<T, R, S2>) -> ()
where
    T: na::RealField + Copy,
    R: na::Dim,
    S1: na::storage::Storage<T, R, na::U1>,
    S2: na::storage::Storage<T, R, na::U1>,
    DefaultAllocator: na::allocator::Allocator<R> + na::allocator::Allocator<R, R>,
{
    let hm = get_Householder_matrix(v) * a;
    for i in 1..a.nrows() {
        assert!(hm[(i, 0)].abs() < T::from_f64(0.1).unwrap());
    }
}
// 对矩阵 a 利用 Householder 变换进行 QR 分解，返回 Q 和 R
fn QR_Householder<T, R, C, S>(a: &Matrix<T, R, C, S>) -> (OMatrix<T, R, C>, OMatrix<T, R, R>)
where
    T: na::RealField + Copy,
    R: na::Dim,
    C: na::Dim,
    S: na::storage::Storage<T, R, C>,
    DefaultAllocator: na::allocator::Allocator<R> + na::allocator::Allocator<R, R> + na::allocator::Allocator<R, C>,
{
    let (m, n) = a.shape();
    let mut q = OMatrix::<T, R, R>::identity_generic(Dim::from_usize(m), Dim::from_usize(m));
    let mut r = a.clone_owned();
    for i in 0..n {
        //  归零第 i 列下三角元素
        let v = HouseholderTransformation::<_, na::Dyn, _>(&r.column(i).rows_range(i..m));
        let H = get_Householder_matrix::<_, na::Dyn, _>(&v);    // 注意这里 H 是 (m-i) x (m-i) 的矩阵
        Householder_ensures::<_, na::Dyn, _, _>(&r.column(i).rows_range(i..m), &v);
        let mut H_full = OMatrix::<T, R, R>::identity_generic(Dim::from_usize(m), Dim::from_usize(m));
        H_full.rows_range_mut(i..m).columns_range_mut(i..m).copy_from(&H);
        q *= H_full.as_view();
        r = H_full * r;
    }
    (r, q)
}

fn QR_Householder_ensures<T, R, C, S, S1>(a: &Matrix<T, R, C, S>, q: &Matrix<T, R, R, S1>, r: &Matrix<T, R, C, S>) -> ()
where
    T: na::RealField + Copy,
    R: na::Dim,
    C: na::Dim,
    S: na::storage::Storage<T, R, C>,
    S1: na::storage::Storage<T, R, R>,
    DefaultAllocator: na::allocator::Allocator<R> + na::allocator::Allocator<R, R> + na::allocator::Allocator<R, C>,
{
    assert!(r_eq(&(q * r), a));
    assert!(is_upper_triangle(r));
    assert!(
        r_eq(
            &(q.transpose() * q), 
            &OMatrix::<T, R, R>::identity_generic(Dim::from_usize(q.nrows()), Dim::from_usize(q.ncols()))));
}

// 解线性方程 m x = b，其中 m 为上三角矩阵
fn solve_upper_linear_equation<T, R, C, S1, S2>
(
    m: &Matrix<T, R, C, S1>, 
    b: &Vector<T, R, S2>
) -> OVector<T, C>
where
    T: na::RealField + Copy,
    R: Dim,
    C: Dim,
    S1: na::storage::Storage<T, R, C> + std::fmt::Debug,
    S2: na::storage::Storage<T, R, na::U1> + std::fmt::Debug,
    DefaultAllocator: na::allocator::Allocator<C>,
{
    assert!(is_upper_triangle(m));
    let mut x: OVector<T, C> = OMatrix::<T, C, Const<1>>::zeros_generic(Dim::from_usize(m.nrows()), Dim::from_usize(1));
    for i in (0..m.nrows()).rev() {
        let sum = (i + 1..m.nrows()).fold(zero(), |sum, j| sum + m[(i, j)] * x[j]); // sigma_(k = i + 1)^(m.nrows()) m(i, k) * x(k)
        x[i] = (b[i] - sum) / m[(i, i)];
    }
    x
}

// 利用 QR 分解求解线性方程组
fn QR_linear_solver<T, R, C, S1, S2>(a: &Matrix<T, R, C, S1>, b: &Vector<T, R, S2>) -> OVector<T, C>
where
    T: na::RealField + Copy,
    R: na::Dim,
    C: na::Dim,
    S1: na::storage::Storage<T, R, C>,
    S2: na::storage::Storage<T, R, na::U1>,
    DefaultAllocator: na::allocator::Allocator<R> + na::allocator::Allocator<R, R> + na::allocator::Allocator<R, C> + na::allocator::Allocator<C>,
{
    let (r, q) = QR_Householder(a);
    let y = q.transpose() * b;
    solve_upper_linear_equation::<_, R, C, _, _>(&r, &y)
}

fn QR_linear_solver_ensures<T, R, C, S1, S2, S3>(a: &Matrix<T, R, C, S1>, b: &Vector<T, R, S2>, x: &Vector<T, C, S3>) -> ()
where
    T: na::RealField + Copy,
    R: na::Dim,
    C: na::Dim,
    S1: na::storage::Storage<T, R, C>,
    S2: na::storage::Storage<T, R, na::U1>,
    S3: na::storage::Storage<T, C, na::U1>,
    DefaultAllocator: na::allocator::Allocator<R> ,
{
    assert!(r_eq(&(a * x), b));
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
    println!("第一题");
    let matrix_in_exercise_1 = OMatrix::<f64, Const<84>, Const<84>>::from_fn(
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
    let b_in_exercise_1 = OVector::<f64, Const<84>>::from_fn(
        |i, _| 
            match i {
                0 => 7.0,
                83 => 14.0,
                _ => 15.0
            }
     );
    let mut time = std::time::Instant::now();
    let x = QR_linear_solver(&matrix_in_exercise_1, &b_in_exercise_1);
    // println!("finish solving QR, x = {:?}\n m * x = {:?}\n b = {:?}\n L2 delta = {:?},time = {:?}", x, matrix_in_exercise_1 * x, b_in_exercise_1, (matrix_in_exercise_1 * x - b_in_exercise_1).norm());
    println!("finish solving QR, L2 delta = {:?},time = {:?}", (matrix_in_exercise_1 * x - b_in_exercise_1).norm(), time.elapsed());
    time = std::time::Instant::now();
    let x_lu = LUcode::LUcode::LU::new(&matrix_in_exercise_1).solve_linear_equation_lu(&b_in_exercise_1);
    //println!("finish solving LU, x = {:?}\n m * x = {:?}\n b = {:?}\n L2 delta = {:?},time = {:?}", x_lu, matrix_in_exercise_1 * x_lu, b_in_exercise_1, (matrix_in_exercise_1 * x_lu - b_in_exercise_1).norm());
    println!("finish solving LU, L2 delta = {:?},time = {:?}, ",  (matrix_in_exercise_1 * x_lu - b_in_exercise_1).norm(), time.elapsed());
    time = std::time::Instant::now();
    let x_lu = LUcode::LUcode::LU::new(&matrix_in_exercise_1).solve_linear_equation_lu_col(&b_in_exercise_1);
    //println!("finish solving LU, x = {:?}\n m * x = {:?}\n b = {:?}\n L2 delta = {:?},time = {:?}", x_lu, matrix_in_exercise_1 * x_lu, b_in_exercise_1, (matrix_in_exercise_1 * x_lu - b_in_exercise_1).norm());
    println!("finish solving LU, L2 delta = {:?},time = {:?}", (matrix_in_exercise_1 * x_lu - b_in_exercise_1).norm(), time.elapsed());
    let matrix_in_exercise_2 = OMatrix::<f64, Const<100>, Const<100>>::from_fn(
        |i, j| 
            match signed_sub_of_usize(i, j) {
                (1, _) => 1.0,
                (0, _) => 10.0,
                _ => 0.0
            }
    );
    let b2 = OVector::<f64, Const<100>>::new_random();
    time = std::time::Instant::now();
    let x2 = QR_linear_solver(&matrix_in_exercise_2, &b2);
    //println!("finish solving QR, x = {:?}\n m * x = {:?}\n b = {:?}\n L2 delta = {:?},time = {:?}", x2, matrix_in_exercise_2 * x2, b2, (matrix_in_exercise_2 * x2 - b2).norm());
    println!("finish solving QR, L2 delta = {:?},time = {:?}", (matrix_in_exercise_2 * x2 - b2).norm(), time.elapsed());
    time = std::time::Instant::now();
    let x2_lu = LUcode::LUcode::LU::new(&matrix_in_exercise_2).solve_linear_equation_lu(&b2);
    //println!("finish solving LU, x = {:?}\n m * x = {:?}\n b = {:?}\n L2 delta = {:?},time = {:?}", x2_lu, matrix_in_exercise_2 * x2_lu, b2, (matrix_in_exercise_2 * x2_lu - b2).norm());
    println!("finish solving LU, L2 delta = {:?},time = {:?}",  (matrix_in_exercise_2 * x2_lu - b2).norm(), time.elapsed());
    time = std::time::Instant::now();
    let x2_lu = LUcode::LUcode::LU::new(&matrix_in_exercise_2).solve_linear_equation_lu_col(&b2);
    //println!("finish solving LU, x = {:?}\n m * x = {:?}\n b = {:?}\n L2 delta = {:?},time = {:?}", x2_lu, matrix_in_exercise_2 * x2_lu, b2, (matrix_in_exercise_2 * x2_lu - b2).norm());
    println!("finish solving LU, L2 delta = {:?},time = {:?}",  (matrix_in_exercise_2 * x2_lu - b2).norm(), time.elapsed());
    time = std::time::Instant::now();
    let x2_chol = LUcode::LUcode::Cholesky::new(&matrix_in_exercise_2).solve_linear_equation_cholesky(&b2);
    //println!("finish solving Cholesky, x = {:?}\n m * x = {:?}\n b = {:?}\n L2 delta = {:?},time = {:?}", x2_chol, matrix_in_exercise_2 * x2_chol, b2, (matrix_in_exercise_2 * x2_chol - b2).norm());
    println!("finish solving Cholesky, L2 delta = {:?},time = {:?}",  (matrix_in_exercise_2 * x2_chol - b2).norm(), time.elapsed());
    time = std::time::Instant::now();
    let x2_chol = LUcode::LUcode::Cholesky::new(&matrix_in_exercise_2).solve_linear_equation_improved_cholesky(&b2);
    //println!("finish solving Cholesky, x = {:?}\n m * x = {:?}\n b = {:?}\n L2 delta = {:?},time = {:?}", x2_chol, matrix_in_exercise_2 * x2_chol, b2, (matrix_in_exercise_2 * x2_chol - b2).norm());
    println!("finish solving Cholesky, L2 delta = {:?},time = {:?}",  (matrix_in_exercise_2 * x2_chol - b2).norm(), time.elapsed());

    // 下面是第二题
    println!("第二题");
    let t = OVector::<f64, Const<7>>::from_vec(vec![-1.0, -0.75, -0.5, 0.0, 0.25, 0.5, 0.75]);
    let y = OVector::<f64, Const<7>>::from_vec(vec![1.00, 0.8125, 0.75, 1.00, 1.3125, 1.75, 2.3125]);
    // 构造系数矩阵
    let m = OMatrix::<f64, Const<7>, Const<3>>::from_fn(|i, j| t[i].powf(j as f64));
    // 求 QR 分解
    let (r, q) = QR_Householder(&m);
    let c1 = q.transpose() * y;
    let res = solve_upper_linear_equation(
        &r.rows_range(0..3), 
        &c1.rows_range(0..3)
    );
    let loss = (m * res - y).norm();
    println!("得到最佳逼近：{:?}，误差为：{:?}", res, loss);

}
