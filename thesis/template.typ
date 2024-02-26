#import "../common/titlepage.typ": *
#import "../common/settings.typ": *
#import "@preview/glossarium:0.2.6": print-glossary
#import "../abbreviations.typ": abbreviations
#import "@preview/hydra:0.3.0": hydra


#let thesis(
  degree: "",
  program: "",
  title: "",
  subtitle: "",
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
    author: author,
    placeOfWork: placeOfWork,
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
    numbering: "I",
    number-align: center,
  )
  counter(page).update(2)

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
  set heading(numbering: none)

  // Paragraphs
  set par(leading: 1em, justify: true)

  // Figures
  show figure: set text(size: 0.85em)

  // Citations
  set cite(style: citationStyle)

  // Additional Syntax Styles
  set raw(syntaxes: ("../syntax/cds.sublime-syntax"))

  // Statutory Declaration
  include "../supplementary/statutoryDeclaration.typ"
  pagebreak();

  // Abstract
  include "../supplementary/abstract.typ"
  pagebreak();

  // Abstract German
  include "../supplementary/abstractGerman.typ"
  pagebreak();

  // Table of Contents
  outline(
    title: {
      text(font: fontBody, 1.5em, weight: 700, "Table of Contents")
      v(15mm)
    },
    indent: true,
    depth: 3
  )
  
  
  v(2.4fr)
  pagebreak()

  // List of Figures
  outline(
    title:"List of Figures",
    target: figure.where(kind: image),
  )
  pagebreak()

  // List of Tables
  outline(
    title: "List of Tables",
    target: figure.where(kind: table)
  )
  pagebreak()

  // List of Listings
  outline(
    title: "List of Listings",
    target: figure.where(kind: raw)
  )
  pagebreak()

  // List of Abbreviations
  heading(numbering: none)[List of Abbreviations]
  print-glossary(
    abbreviations,
    show-all: false,
    disable-back-references: true,
  )
  pagebreak()

  // Main Body
  set heading(numbering: headingsNumberingStyle, supplement: "Chapter")
  set page(
    margin: (left: 2.5cm, right: 2.5cm, top: 4cm, bottom: 2.5cm),
    number-align: center,
  )

  // Header with current heading
  set page(
    header: locate(location => {
      let elements = query(
        selector(heading.where(level: 1)).after(location), 
        location
      )

      // Don't show header if a new chapter is starting at the current page
      if elements != () and elements.first().location().page() == location.page() and elements.first().level == 1 {
          return;
      }

      let displayHeading
      let displayNumbering
      let element
      elements = query(selector(heading).after(location), location)
      if elements != () and elements.first().location().page() == location.page() {
        element = elements.first()
        if element.has("numbering") and element.numbering != none {
          displayNumbering = numbering(element.numbering, ..counter(heading).at(element.location()))
        } else {
          displayNumbering = numbering(headingsNumberingStyle, ..counter(heading).at(element.location()))
        }

        displayHeading = element.body
      } else {
        // Otherwise take the next heading backwards
        elements = query(
          heading.where().before(location), 
          location
        )
        if elements != () {
          element = elements.last()
          if element.has("numbering") and element.numbering != none {
            displayNumbering = numbering(element.numbering, ..counter(heading).at(element.location()))
          } else {
            displayNumbering = numbering(headingsNumberingStyle, ..counter(heading).at(element.location()))
          }

          displayHeading = element.body
        }
      }

      align(center, displayNumbering + " " + displayHeading)
      line(length: 100%, stroke: (paint: gray))
    })
  )

  // Footer with Page Numbering
  set page(footer: locate(currentLocation => {
    let currentPage = counter(page).display()
    let finalPage = counter(page).final(currentLocation).first()

    line(length: 100%, stroke: (paint: gray))
    align(center)[#currentPage / #finalPage]
  }))
  counter(page).update(1)  
  body
}