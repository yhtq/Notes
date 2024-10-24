use core::time;
use std::mem::swap;

use na::{DefaultAllocator, Matrix, OMatrix, OVector, Vector};
use nalgebra::{self as na, Const, Dim, DimName, DimSub, Owned, UniformNorm, U1};
use nalgebra::Normed;

trait default_allocator<R: Dim + na::DimSub<U1>> : na::allocator::Allocator<R> + na::allocator::Allocator<R, R> + nalgebra::allocator::Allocator<R, <R as na::DimSub<na::Const<1>>>::Output> + nalgebra::allocator::Allocator<<R as na::DimSub<na::Const<1>>>::Output> {}
struct Iterator<T, R, S1, S2>
where
    T: na::RealField + Copy,
    R: na::Dim,
    S1: na::storage::Storage<T, R, R>,
    S2: na::storage::Storage<T, R>,
    DefaultAllocator: na::allocator::Allocator<R>,
{
    m: Matrix<T, R, R, S1>,
    b: Vector<T, R, S2>,
    x_curr: OVector<T, R>,
    x_old: OVector<T, R>,
}
impl<T, R, S1, S2> Iterator<T, R, S1, S2>
where
    T: na::RealField + Copy,
    R: na::Dim,
    S1: na::storage::Storage<T, R, R>,
    S2: na::storage::Storage<T, R>,
    DefaultAllocator: na::allocator::Allocator<R>,
{
    fn new(m: Matrix<T, R, R, S1>, b: Vector<T, R, S2>, x0: OVector<T, R>) -> Self {
        Self { m, b, x_curr: x0.clone(), x_old: x0, }
    }
    fn until_condition(
        &mut self,
        condition: fn(&Matrix<T, R, R, S1>, &OVector<T, R>, &OVector<T, R>) -> bool,    //  三个参数包括 m, x_old, x_new
        max_times: usize,
    ) -> Option<usize> {
        for i in 0..max_times {
            swap(&mut self.x_old, &mut self.x_curr);
            self.x_curr = (&self.m) * (&self.x_old) + &self.b;
            if condition(&self.m, &self.x_old, &self.x_curr) {
                return Some(i)
            }
        }
        None
    }
}
impl<T, R, S1, S2> Iterator<T, R, S1, S2>
where
    T: na::RealField + Copy,
    R: na::Dim + na::DimSub<U1>,
    S1: na::storage::Storage<T, R, R>,
    S2: na::storage::Storage<T, R>,
    DefaultAllocator: default_allocator<R>,
{
    fn print_rho(&self) -> () {
        let rho = self.m.clone_owned().schur().complex_eigenvalues();
        println!("rho = {:?}", rho);
    }
}

fn get_Jacobi<T, R, S1, S2>(A: &Matrix<T, R, R, S1>, b: &Vector<T, R, S2>) 
-> Iterator<T, R, Owned<T, R, R>, Owned<T, R, U1>>
where
    T: na::RealField + Copy,
    R: na::Dim + na::DimSub<U1>,
    S1: na::storage::Storage<T, R, R>,
    S2: na::storage::Storage<T, R>,
    DefaultAllocator: default_allocator<R>,
{
    // m = D^(-1) (D - A), b = D^(-1) b
    let D = OMatrix::<T, R, R>::from_diagonal(&A.diagonal());
    let DInv = D.clone().try_inverse().unwrap();
    let m = (&DInv) * (&D - A);
    let b1 = (&DInv) * b;
    Iterator::new(m, b1, OVector::<T, R>::zeros_generic(Dim::from_usize(A.nrows()), U1))
}


fn get_GaussSeidel<T, R, S1, S2>(A: &Matrix<T, R, R, S1>, b: &Vector<T, R, S2>)
-> Iterator<T, R, Owned<T, R, R>, Owned<T, R, U1>>
where
    T: na::RealField + Copy,
    R: na::Dim + na::DimSub<U1>,
    S1: na::storage::Storage<T, R, R>,
    S2: na::storage::Storage<T, R>,
    DefaultAllocator: default_allocator<R>,
{
    // m = (D - L)^(-1) U , b = (D - L)^(-1) b
    let D_L = A.lower_triangle();   // 包含对角线的下三角部分，也就是 D - L
    let mut U = - A.upper_triangle();     // 上三角部分，不含对角线
    U.fill_diagonal(T::zero());
    let D_LInv = D_L.clone().try_inverse().unwrap();
    let m = (&D_LInv) * &U;
    let b1 = D_L.try_inverse().unwrap() * b;
    Iterator::new(m, b1, OVector::<T, R>::zeros_generic(Dim::from_usize(A.nrows()), U1))
}


fn get_SOR<T, R, S1, S2>(A: &Matrix<T, R, R, S1>, b: &Vector<T, R, S2>, omega: T)
-> Iterator<T, R, Owned<T, R, R>, Owned<T, R, U1>>
where
    T: na::RealField + Copy,
    R: na::Dim + na::DimSub<U1>,
    S1: na::storage::Storage<T, R, R>,
    S2: na::storage::Storage<T, R>,
    DefaultAllocator: default_allocator<R>,
{
    // m = (D - omegaL)^(-1) ((1 - omega) D + omega U), b = omega (D - omega L)^(-1) b
    let mut U = - A.upper_triangle();     // 上三角部分，不含对角线
    U.fill_diagonal(T::zero());
    let mut L = - A.lower_triangle();   // 下三角部分，不含对角线
    L.fill_diagonal(T::zero());
    let D = OMatrix::<T, R, R>::from_diagonal(&A.diagonal());
    let D_omegaL = &D - L.scale(omega);
    let D_omegaLInv = D_omegaL.clone().try_inverse().unwrap();
    let m = &D_omegaLInv * (D.scale(T::from_i64(1).unwrap() - omega) + U.scale(omega));
    let b1 = &D_omegaLInv * b.scale(omega);
    Iterator::new(m, b1, OVector::<T, R>::zeros_generic(Dim::from_usize(A.nrows()), U1))
}

fn stop_condition<T, R, S1, S2>(
    m: &Matrix<T, R, R, S1>,
    x_new: &Vector<T, R, S2>,
    x_old: &Vector<T, R, S2>,
) -> bool
where
    T: na::RealField + Copy,
    R: na::Dim,
    S1: na::storage::Storage<T, R, R>,
    S2: na::storage::Storage<T, R>,
    DefaultAllocator: na::allocator::Allocator<R>
{
    //  迭代停止条件，这里采用比较简单的策略，新结果与旧结果的差小于 1e-5 就停止
    let delta_x = x_new - x_old;
    let max_delta = delta_x.amax();
    // println!("max_delta = {:?}", max_delta);
    max_delta < T::from_f64(1e-4).unwrap() * x_new.amax()
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
fn produce_test<T, N, S>(epsilon: T, a: T, times: Option<usize>, name: &str, res: &Vector<T, N, S>, ) -> () 
where 
    T: na::RealField + Copy,
    N: na::DimName,
    S: na::storage::Storage<T, N>,
    DefaultAllocator: na::allocator::Allocator<N>
{
    let n = N::USIZE;
    let y = 
        OVector::<T, N>::from_fn(|i, _| T::from_f64(i as f64 / n as f64).unwrap())
        .map(
            |x| (T::one() - a)/(T::one() - T::exp(- T::one() / epsilon)) * (T::one() - T::exp(- x / epsilon)) + a * x
        );
    match times {
        Some(i) => {
            println!("{} iter times: {:?}", name, i);
            println!("L2 distance to true result: {:?}", (res - y).norm());
        },
        None => println!("{} iter disconverge", name),
    }
}
fn solve<T, N>(epsilon: T, a: T) ->()
where 
T: na::RealField + Copy,
N: na::DimName + na::DimSub<U1> + na::DimMin<N, Output = N>,
DefaultAllocator: default_allocator<N>
{
    let n = N::USIZE;
    let h = T::from_f64(1.0 / n as f64).unwrap();
    println!("a = {:?}, epsilon = {:?}, n = {:?}, h = {:?}", a, epsilon, n, h);
    let A = OMatrix::<T, N, N>::from_fn(
        |i, j|
            match signed_sub_of_usize(i, j) 
            {
                (1, SubSign::Negative) => epsilon + h,
                (0, _) => -(T::from_usize(2).unwrap() * epsilon + h),
                (1, SubSign::NonNegative) => epsilon,
                _ => T::zero()
            }
    );
    let b = OVector::<T, N>::from_element(a * h * h);
    let produce_test1 = 
        |mut iter: Iterator<T, N, Owned<T, N, N>, Owned<T, N, U1>>, name: &str| {
            let times = iter.until_condition(stop_condition, 10000);
            produce_test(epsilon, a, times, name, &iter.x_curr);
        };
    produce_test1(get_Jacobi(&A, &b), "Jacobi");
    produce_test1(get_GaussSeidel(&A, &b), "GaussSeidel");
    let produce_test_SOR = 
        |omega: f64| {
            let mut iter = get_SOR(&A, &b, T::from_f64(omega).unwrap());
            let times = iter.until_condition(stop_condition, 10000);
            produce_test(epsilon, a, times, &format!("SOR({})", omega), &iter.x_curr);
        };

    for h in 1..20 {
        produce_test_SOR(h as f64 / 10.0);
    }
}



impl default_allocator<na::U100> for nalgebra::DefaultAllocator {
}

fn main() {
    solve::<f64, na::U100>(1.0, 5.0);
    solve::<f64, na::U100>(0.1, 5.0);
    solve::<f64, na::U100>(0.01, 5.0);
    solve::<f64, na::U100>(0.0001, 5.0);
}
