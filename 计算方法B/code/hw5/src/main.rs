use std::borrow::Borrow;
use std::iter;

use na::{DefaultAllocator, OMatrix, Vector};
use nalgebra::{self as na, Dim, Matrix, OVector, Unit, U1, U3, U8};
use nalgebra::Normed;

// 根据多项式向量构造友阵，注意多项式为：
// p(x) = x^n + poly(0) * x^(n-1) + poly(1) * x^(n-2) + ... + poly(n-2) * x + poly(n-1) 
fn get_companion_matrix<T, D, S> (poly: &Vector<T, D, S>) -> OMatrix<T, D, D>
where
    T: na::RealField + Copy,
    D: Dim,
    S: na::storage::Storage<T, D, U1>,
    DefaultAllocator: na::allocator::Allocator<D, D>
{
    let n = poly.nrows();
    let mut companion = OMatrix::<T, D, D>::zeros_generic(D::from_usize(n), D::from_usize(n));
    for i in 0..n-1 {
        companion[(i+1, i)] = T::one();
    }
    for i in 0..n {
        companion[(i, n-1)] = -poly[n - 1 - i];
    }
    companion
}

// 用幂法计算矩阵特征值
struct PowerMethod<'a, T: na::RealField + Copy, D: Dim, S: na::storage::Storage<T, D, D>>
where DefaultAllocator: na::allocator::Allocator<D, U1>
{
    name: &'a str,
    matrix: Matrix<T, D, D, S>,
    x: Unit<OVector<T, D>>,
}

impl <'a, T: na::RealField + Copy, D: Dim, S: na::storage::Storage<T, D, D>> PowerMethod<'a, T, D, S>
where DefaultAllocator: na::allocator::Allocator<D, U1>
{
    fn new(name: &'a str, matrix: Matrix<T, D, D, S>, x: Unit<OVector<T, D>>) -> Self {
        Self { name, matrix, x }
    }
    fn next(self) -> PowerMethod<'a, T, D, S> {
        let x1 = self.x.into_inner();
        let y = (&self.matrix) * (x1);
        let x = Unit::new_normalize(y);
        PowerMethod::new(self.name, self.matrix, x)
    }
    fn get_lambda(&self) -> T {
        let x = self.x.as_ref();
        let y = (&self.matrix) * x;
        y.ad_mul(&self.x.as_ref())[0]
    }
    fn run_until(self, max_iter: usize, tol: T) -> Result<(Self, usize), String> {
        let mut lambda_o = self.get_lambda();
        let mut next = self;
        for i in 0..max_iter {
            next = next.next();
            let lambda = next.get_lambda();
            if (lambda - lambda_o).abs() < tol * lambda.abs()
            {
                return Ok((next, i));
            }
            lambda_o = lambda;
        }
        Err(format!("{}: max_iter reached", next.name.to_string()))
    }
}

fn polynomial_to_string <T, D, S> (poly: &Vector<T, D, S>) -> String
where
    T: na::RealField + Copy,
    D: Dim,
    S: na::storage::Storage<T, D, U1>,
    DefaultAllocator: na::allocator::Allocator<D, D> + na::allocator::Allocator<D, U1>
{
    let n = poly.nrows();
    iter::once(format!("x^{}", n))
    .chain(poly.iter().enumerate().map(|(i, x)| {
        if i == n - 1 {
            format!("{}", x)
        } else {
            if *x == T::zero() {
                "".to_string()
            } else if *x == T::one() {
                format!("x^{}", n - 1 - i)
            } else {
                format!("{}x^{}", x, n - 1 - i)
            }
        }
    }))
    .collect::<Vec<String>>().join(" + ")
}

fn get_max_root_of_polynomial<T, D, S> (poly: &Vector<T, D, S>) -> ()
where
    T: na::RealField + Copy,
    D: Dim,
    S: na::storage::Storage<T, D, U1>,
    DefaultAllocator: na::allocator::Allocator<D, D> + na::allocator::Allocator<D, U1>
{
    let companion = get_companion_matrix(poly);
    let x = Unit::new_normalize(OVector::<T, D>::repeat_generic(poly.shape_generic().0, U1 ,T::one()));
    let name = polynomial_to_string(poly);
    let power_method = PowerMethod::new(name.as_str(), companion, x);
    let (power_method, iter) = power_method.run_until(1000, T::from_f64(1e-10).unwrap()).unwrap();
    let lambda = power_method.get_lambda();
    println!("max root: {}, iter: {}", lambda, iter);
}

fn main() {
    get_max_root_of_polynomial(
        &OVector::<f64, U3>::from_vec(vec![1.0, -5.0, 3.0])
    );
    get_max_root_of_polynomial(
        &OVector::<f64, U3>::from_vec(vec![0.0, -3.0, -1.0])
    );
    get_max_root_of_polynomial(
        &OVector::<f64, U8>::from_vec(vec![101.0, 208.01, 10891.01, 9802.08, 79108.9, -99902.0, 790.0, -1000.0])
    );
}
