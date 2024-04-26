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

  set page(
    // Header with current heading
    header: locate(location => {
      let elements = query(
        selector(heading.where(depth: 1)).after(location), 
        location
      )

      // Don't show header if a new chapter is starting at the current page
      if elements != () and elements.first().location().page() == location.page() and elements.first().depth == 1 {
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
    }),
    
    // Footer with Page Numbering
    footer: locate(currentLocation => {
      let currentPage = counter(page).display()
      let finalPage = counter(page).final(currentLocation).first()
  
      line(length: 100%, stroke: (paint: gray))
      align(center)[#currentPage / #finalPage]
    })
  )

  // Set after header and after all initial pages to just apply it to the acutal content
  show par: set block(spacing: spaceBeforeParagraph)
  
  body
}