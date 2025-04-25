#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业5",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
= 
  + 选定基模型 $T(x\;theta)$
  + 假设已经学习得到 $f_(i - 1)$，按照：
    $
      argmin_theta sumi1n(L(y_i, T(x_i; theta) + f_(i - 1) (x_i)))
    $
    学习得到 $T$，并置：
    $
      f_i = T(x_i; theta) + f_(i - 1)(x_i)
    $
  + 最后，得到最终的模型
= 
  随机森林算法的框架为：
  + 对于每个 $t$:
    - 采用自助法，在训练集中随机抽取 $N$ 个样本
    - 以这些样本为数据训练决策树。训练时，选择划分特征时不再考量所有特征，而是先随机挑选 $k$ 个特征，再选取其中最优的
  + 如此训练得到 $T$ 个基学习器，采用简单投票（分类问题）或者取平均（回归问题）等结合方式得到最终的模型。

  随机森林方法与采用决策树的 Bagging 算法相比较，随机森林算法多了随机选取划分特征的扰动，有助于增加基学习器的训练效率和多样性，但单个基学习器可能性能有所降低。 

  在 20newsgroups 数据集上测试，代码如下：
  ```python
  from tarfile import XGLTYPE
  from typing import List, Tuple
  import numpy
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
  from sklearn.datasets import fetch_20newsgroups_vectorized
  from sklearn.ensemble import RandomForestClassifier
  from sklearn.model_selection import cross_val_score

  X, y = fetch_20newsgroups_vectorized(return_X_y=True)
  bagging_loss : List[Tuple[int, float]] = []
  random_forest_loss : List[Tuple[int, float]] = []
  for n in range(1, 15):
      bagging = RandomForestClassifier(n_estimators=n, random_state=RANDOM_STATE, n_jobs=-1)
      bagging.fit(X, y)
      random_forest = RandomForestClassifier(n_estimators=n, random_state=RANDOM_STATE, max_features="log2", n_jobs=-1)
      random_forest.fit(X, y)
      bagging_loss.append((n, bagging.score(X, y)))
      random_forest_loss.append((n, random_forest.score(X, y)))
      print(f"n: {n} Bagging: {bagging.score(X, y)}, Random Forest: {random_forest.score(X, y)}")
  ```
  结果如下：
  ```bash
  n: 1 Bagging: 0.7649814389252254, Random Forest: 0.7296270107831005
  n: 2 Bagging: 0.7661304578398445, Random Forest: 0.725207707265335
  n: 3 Bagging: 0.8942018737846915, Random Forest: 0.8662718755524129
  n: 4 Bagging: 0.9482057627717871, Random Forest: 0.9356549407813328
  n: 5 Bagging: 0.9730422485416298, Random Forest: 0.9672971539685346
  n: 6 Bagging: 0.9833834187732013, Random Forest: 0.9819692416475163
  n: 7 Bagging: 0.9893052854870072, Random Forest: 0.9896588297684284
  n: 8 Bagging: 0.9939897472158388, Random Forest: 0.9936362029344176
  n: 9 Bagging: 0.9964645571857875, Random Forest: 0.9974368039596959
  n: 10 Bagging: 0.9977903482411172, Random Forest: 0.9977019621707619
  n: 11 Bagging: 0.9989393671557363, Random Forest: 0.998850981085381
  n: 12 Bagging: 0.9993812975075128, Random Forest: 0.9992045253668022
  n: 13 Bagging: 0.9991161392964468, Random Forest: 0.9996464557185788
  n: 14 Bagging: 0.9998232278592893, Random Forest: 0.999734841788934
  ```
  可见 $n$ 较小时 Bagging 算法表现较好，$n$ 较大时两者相差不大。
= 3
  + 由定义，$C$ 中任何两点都与核心点 $x$ 密度可达，因此 $C$ 有连接性
  + 最大性由定义是显然的