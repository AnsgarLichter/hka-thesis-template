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

  // Document and Page Setup
  set document(title: title, author: author)
  set page(
    margin: (left: 2.5cm, right: 2.5cm, top: 4cm, bottom: 2.5cm),
    numbering: "1 / 1",
    number-align: center,
  )
  counter(page).update(1)

  // Body Font Family
  set text(
    font: fontBody, 
    size: 12pt, 
    lang: "en"
  )

  show math.equation: set text(weight: 400)

  // Citations
  set cite(style: citationStyle)

  //Indentation of Lists
  set enum(indent: 2.5em)
  
  // Headings
  show heading: set block(below: 0.85em, above: 1.75em)
  show heading: set text(font: fontBody)
  set heading(numbering: headingsNumberingStyle)

  // Paragraphs
  set par(leading: 1em, justify: true)

  // Figures
  show figure: set text(size: 0.85em)

  body

  pagebreak()
  bibliography("../bibliography/expose.bib")
}