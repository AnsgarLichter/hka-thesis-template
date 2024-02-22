#import "../common/titlepage.typ": *
#import "../common/settings.typ": *

#let exposé(
  degree: "",
  program: "",
  title: "",
  titleGerman: "",
  author: "",
  matriculationNumber: "",
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
    titleGerman: titleGerman,
    author: author,
    matriculationNumber: matriculationNumber,
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

  // Headings
  show heading: set block(below: 0.85em, above: 1.75em)
  show heading: set text(font: fontBody)
  set heading(numbering: headingsNumberingStyle)

  // Paragraphs
  set par(leading: 1em, justify: true, first-line-indent: 2em)

  // Figures
  show figure: set text(size: 0.85em)

  body

  pagebreak()
  bibliography("../bibliography/expose.bib")
}