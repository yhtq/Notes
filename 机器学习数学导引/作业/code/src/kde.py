import numpy as np
import numpy.typing as npt
import matplotlib.pyplot as plt
import matplotlib
from functools import partial
from typing import Callable

type Float = np.float64
type Vector = npt.NDArray[Float]
type Kernel = Callable[[Float], Float]

# 按照某种分布产生数据的生成器
class Generator:
    def __init__(self, f: Callable[[int], Vector]):
        self.f = f
    def __call__(self, n: int) -> Vector:
        return self.f(n)
    def __add__(self, other: "Generator") -> "Generator":
        return Generator(lambda n: self(n) + other(n))
    def __mul__(self, other: "Generator") -> "Generator":
        return Generator(lambda n: self(n) * other(n))
    def mul_scalar(self, c: Float) -> "Generator":
        return Generator(lambda n: c * self(n))

# kernel density estimation，作为函数调用返回该点的密度估计值
class KDE:
    def __init__(self, kernel: Kernel, kernel_name: str, data: Vector, h: Float) -> None:
        self.kernel = kernel
        self.kernel_name = kernel_name
        self.data = data
        self.n = len(data)
        self.h = h
    def __call__(self, x: Float) -> Float:
        map_func = np.vectorize(lambda xi: self.kernel((x - xi) / self.h))
        return np.sum(
            map_func(self.data)
            ) / (self.n * self.h)

def Normal(mu: Float, sigma: Float) -> Generator:
    return Generator(lambda n: np.random.normal(mu, sigma, n))

def box_kernel(x: Float) -> Float:
    return np.float64(1) if np.abs(x) < 0.5 else np.float64(0)

def triangle_kernel(x: Float) -> Float:
    return np.float64(1) - np.abs(x) if np.abs(x) < 1 else np.float64(0)

def gaussian_kernel(x: Float) -> Float:
    return np.exp(-x**2 / 2) / np.sqrt(2 * np.pi)

sampler: Generator = \
Normal(np.float64(-2), np.float64(0.5)).mul_scalar(np.float64(0.3)) + Normal(np.float64(1), np.float64(1)).mul_scalar(np.float64(0.7))
sample_data: Vector = sampler(100)
kernal_funcs: list[tuple[str, Kernel]] = [
    ("box_kernel", box_kernel),
    ("triangle_kernel", triangle_kernel),
    ("gaussian_kernel", gaussian_kernel)
]
hs: list[Float] = [np.float64(1.0 / i) for i in range(1, 5)]
matplotlib.use('pdf')
x = np.linspace(-2, 2, 500)
for (k_name, k) in kernal_funcs:
    # 在同一张图上画出不同 h 下的密度估计曲线
    plt.figure()
    for h in hs:
        kde = KDE(k, k_name, sample_data, h)
        y = np.array([kde(xi) for xi in x])
        print(f"h: {h}, k_name: {k_name}")
        plt.plot(x, y, label=f"h={h}")
    plt.legend()
    plt.title(k_name)
    plt.savefig(f"{k_name}.png")

