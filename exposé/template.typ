#import "../common/titlepage.typ": *
#import "../common/settings.typ": *

#let exposé(
  degree: "",
  program: "",
  title: "",
  subtitle: "",
  titleGerman: "",
  subtitleGerman: "",
  author: "",
  matriculationNumber: "",
  placeOfWork: "",
  supervisor: "",
  advisor: "",
  startDate: none,
  submissionDate: none,
  body,
) = {

  //Document Setup
  set document(title: title, author: author)

  titlepage(
    degree: degree,
    program: program,
    title: title,
    subtitle: subtitle,
    titleGerman: titleGerman,
    subtitleGerman: subtitleGerman,
    author: author,
    matriculationNumber: matriculationNumber,
    placeOfWork: placeOfWork,
    supervisor: supervisor,
    advisor: advisor,
    startDate: startDate,
    submissionDate: submissionDate
  )

  // Page Setup
  set page(
    margin: (left: 2.5cm, right: 2.5cm, top: 4cm, bottom: 2.5cm),
    numbering: "1 / 1",
    number-align: center,
    footer: locate(currentLocation => {
      let currentPage = counter(page).display()
      let finalPage = counter(page).final(currentLocation).first()
  
      line(length: 100%, stroke: (paint: gray))
      align(center)[#currentPage / #finalPage]
    })
  )
  counter(page).update(1)

  // Body Font Family
  set text(
    font: fontBody, 
    size: fontBodySize, 
    lang: "en"
  )

  show math.equation: set text(weight: 400)

  // Citations
  set cite(style: citationStyle)

  // Headings
  show heading: set block(
    below: headingsSpacing.below, 
    above: headingsSpacing.above
  )
  show heading: set text(
    font: fontBody, 
    size: fontHeadingSize
  )
  set heading(numbering: headingsNumberingStyle)

  // Paragraphs
  set par(leading: 1em, justify: true)

  // Figures
  show figure: set text(size: fontFiguresSubtitleSize)

  //Indentation of Lists
  set list(indent: listIdentation)
  set enum(indent: listIdentation)

  // Set after header and after all initial pages to just apply it to the acutal content
  show par: set block(spacing: spaceBeforeParagraph)
  
  body
}