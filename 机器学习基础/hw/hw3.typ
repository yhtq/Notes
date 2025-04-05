#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业3",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
= 
  首先定义带权重的基尼指数：
  $
    "Geni"(D, W) = 1 - sumi1n(((sum_(a in D_i) w(a))/(sum_(a in D) w(a)))^2)
  $
  以及带权重的，对特征 $A$ 的基尼指数：
  $
    "Geni"(D, W, A) = sumk1m("Geni"(D, W)) * (sum_(a in D_k) w(a)) / (sum_(a in D) w(a))
  $
  采取如下策略：
  - 对于特征 $A$，记 $tilde(D)$ 为 $D$ 中特征 $A$ 未缺失的样本，用：
    $
      (sum_(a in tilde(D)) w(a)) / (sum_(a in D) w(a)) * "Geni"(D, W)
    $
    作为该特征的增益度量
  - 划分样本时，对于该特征缺失的样本，等权重划分到每个子节点
= 2 
  代码
  ```python
  from tarfile import XGLTYPE
  from matplotlib.axis import XAxis
  import numpy
  from obliquetree import Classifier, Regressor
  from obliquetree.utils import visualize_tree
  from sklearn.calibration import LabelEncoder
  from sklearn.discriminant_analysis import StandardScaler
  from sklearn.metrics import accuracy_score
  from sklearn.datasets import fetch_openml
  import pandas as pd
  from sklearn.model_selection import train_test_split
  RANDOM_STATE = 42
  X, y = (
      numpy.array([[0.697, 0.460], [0.774, 0.376], [0.634, 0.264], [0.608, 0.318],
      [0.556, 0.215], [0.403, 0.237], [0.481, 0.149], [0.437, 0.211],
      [0.666, 0.091], [0.243, 0.267], [0.245, 0.057], [0.343, 0.099],
      [0.639, 0.161], [0.657, 0.198], [0.360, 0.370], [0.593, 0.042],
      [0.719, 0.103]], dtype=float),
      numpy.array([1 for _ in range(8)] + [0 for _ in range(9)], dtype="int64")
      
  )
  from sklearn.datasets import fetch_california_housing
  from sklearn.ensemble import BaggingRegressor
  from sklearn.model_selection import cross_val_score

  from scikit_obliquetree.HHCART import HouseHolderCART
  from scikit_obliquetree.segmentor import MSE, MeanSegmentor

  X, y = fetch_california_housing(return_X_y=True)
  print(type(X), type(y))
  reg = BaggingRegressor(
      HouseHolderCART(MSE(), MeanSegmentor(), max_depth=3),
      n_estimators=2,
      n_jobs=-1,
  )
  print('CV Score', cross_val_score(reg, X, y))
  ```
  输出：
  ```python
  CV Score [0.37750938 0.51959126 0.57377515 0.36313804 0.52638363]
  ```