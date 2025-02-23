#import "../template.typ": *
#show: note.with(
  title: "数理统计",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)
= 前言
  - 教师：刘力平，智华楼 335，liping\@math.pku.edu.cn
  - 教材：陈家鼎等《数理统计学讲义》
  - 参考书：
    - 陈希孺《数理统计引论》，适合作为参考
    - D. Freedman. 《统计学》，较为面向实践
    - Lehmann. 《Theory of Point Estimation》
    - Lehmann. 《Testing Statistical Hypothesis》
    - 陈希孺《数理统计学简史》
  - 作业：每节课留，每周三交，可延期至周五
  - 作业 20% + 期中考试 20% + 期末考试 60%
  + 习惯上，用大写字母 $X_i$ 表示抽样前样本对应的随机变量，用小写字母 $x_i$ 表示抽样后样本的观测值。
  + 通常情况下，我们处理的都是独立同分布的样本，称为简单随机样本。
  + 通常称一个样本的（可测）函数为一个统计量 
  
