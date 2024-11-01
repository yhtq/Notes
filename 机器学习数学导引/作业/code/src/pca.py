import matplotlib
import numpy as np
import numpy.linalg as la
from sklearn.datasets import fetch_openml
import pandas as pd
import matplotlib.pyplot as plt

type Frame = pd.DataFrame
type Matrix = np.ndarray 
type Vector = np.ndarray
type Float = np.float64
type Complex = np.complex128

class PCA:
    def __init__(self, data: Matrix) -> None:
        self.data = data
        self.covariance_matrix: Matrix = np.cov(data, rowvar=False)
        self.eigenvalues, self.eigenvectors = la.eig(self.covariance_matrix)
        self.sorted_indices = np.argsort(self.eigenvalues)[::-1]
        self.sorted_eigenvalues = self.eigenvalues[self.sorted_indices]
    def top_k_eigenvectors(self, k: int) -> Vector:
        return self.sorted_eigenvalues[:k]
    def k0(self, percentage: Float = np.float64(0.9)):
        total = np.sum(self.sorted_eigenvalues)
        sum = np.float64(0)
        k = 0
        while sum / total < percentage:
            sum += self.sorted_eigenvalues[k]
            k += 1
        return k
    def project(self, k: int, x: Vector) -> Matrix:
        complex_vec = self.eigenvectors[:, self.sorted_indices[:k]].T @ x
        # 注意这里并没有复特征值，直接转换即可
        return complex_vec.real
    def reconstruction(self, x_1: Vector) -> Matrix:
        k = len(x_1)
        complex_vec = self.eigenvectors[:, self.sorted_indices[:k]] @ x_1
        return complex_vec.real
        

mnist = fetch_openml('mnist_784')
x: Frame = mnist.data
y: Frame = mnist.target
d: int = x.shape[1]
n: int = x.shape[0]
print(f"n = {n}, d = {d}")
(data_of_0, data_of_1) = (x[y == '0'], x[y == '1'])
pca_total = PCA(x.to_numpy(dtype=np.float64))
k = pca_total.k0()
print(f"top {k} eigenvectors are enough to explain 90% variance")
random_sample = data_of_0.sample(1).to_numpy(dtype=np.float64)
x_1 = random_sample[0]

# 画出重建后的向量与原向量距离的图像
matplotlib.use('pdf')
plt.figure()
x_2 = pca_total.reconstruction(pca_total.project(k, x_1))
xs = range(1, d, 20)
ys = [la.norm(pca_total.reconstruction(pca_total.project(k, x_1)) - x_1) for k in xs]
plt.plot(xs, ys)
plt.xlabel("number of eigenvectors")
plt.ylabel("reconstruction error")
plt.title("reconstruction error")
plt.savefig("output/reconstruction_error.png")

ks = [5, 30, 50, 100, 400]
# 画出重建后的图像
xs = [pca_total.reconstruction(pca_total.project(k, x_1)) for k in ks]
for k, graph in zip(ks, xs):
    graph = graph.reshape(28, 28)
    plt.figure()
    plt.imshow(graph, cmap='gray')
    plt.axis('off')
    plt.savefig(f"output/reconstruction_{k}.png")

def visualize(u1: Vector, u2: Vector, title: str):
    plt.figure()
    plt.scatter(data_of_0 @ u1, data_of_0 @ u2, label='0', c='r')
    plt.scatter(data_of_1 @ u1, data_of_1 @ u2, label='1', c='b')
    plt.legend()
    plt.title(title)
    plt.savefig(f"output/{title}.png")


v1 = np.random.normal(0, 1, d)
v2 = np.random.normal(0, 1, d)
u1 = v1 / la.norm(v1)
u2 = (v2 - np.inner(u1, v2) * u1) / la.norm(v2 - np.inner(u1, v2) * u1)
visualize(u1, u2, "random")
top2_eigenvectors = pca_total.eigenvectors[:, pca_total.sorted_indices[:2]]
u1 = top2_eigenvectors[:, 0]
u2 = top2_eigenvectors[:, 1]
visualize(u1, u2, "top2_eigenvectors")

