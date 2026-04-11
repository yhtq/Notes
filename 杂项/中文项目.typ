#import "../template.typ": *
#show: note.with( 
  withOutlined: false,
  withChapterNewPage: false,
  withTitle: false
)
= 权限
  - 匿名用户只能访问一部分。校内用户跳转网关验证
  - 额外设置 access token，允许访问更多内容。access token 手工管理。
= 语音词汇变异
  - 序号对应词汇，录音
  - 分页展示
  - 搜索/筛选页面，显示筛出的条目，高亮搜索到的部分
= 被试个人信息
  - 包含若干信息项（母语，...），以表格形式提供
  - 其中若干项允许检索。被检索项内容均统一

= 语篇
  - 有索引界面，检索界面
  - 分隔符分割单位，搜索时按单位展示
  - 检索时显示检索到的单句（音标 + 翻译，分行对应）
= UI 风格参考

  