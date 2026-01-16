#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "../template.typ": *
#show: note.with( 
  withOutlined: false,
  withChapterNewPage: false,
  withHeadingNumbering: false,
  withTitle: false
)
#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  // config-common(handout: true),
  config-common(),  // freeze theorem counter for animation
  config-info(
    title: [Functional Programming],
    author: [ 11],
    date: datetime.today(),
    institution: [11 ],

  ),
)
#set text(size: 22pt)
// #set heading(numbering: "1.")
#title-slide()
