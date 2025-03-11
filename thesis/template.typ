#import "/common/titlepage.typ": *
#import "/common/settings.typ": *
#import "@preview/glossarium:0.5.4": print-glossary
#import "/abbreviations.typ": abbreviations

#let in-outline = state("in-outline", false)
#let flex-caption(long, short) = context if in-outline.get() { short } else { long }

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
  // Document Setup - here because Typst Preview says show rules must be appear before any content
  set document(title: title, author: author)
  
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

  // Page Setup
  set page(
    margin: (left: 2.5cm, right: 2.5cm, top: 4cm, bottom: 2.5cm),
    numbering: "I",
    number-align: center
  )
  counter(page).update(2)

  // Body Font Family
  set text(
    font: fontBody, 
    size: fontBodySize, 
    lang: "en"
  )

  show math.equation: set text(weight: 400)

  // Headings
  show heading: set block(
    below: headingsSpacing.below, 
    above: headingsSpacing.above
  )
  show heading: set text(font: fontBody, size: fontHeadingSize)
  set heading(numbering: none)

  // Paragraphs
  set par(leading: distanceBetweenLines, justify: true)

  // Figures
  show figure: set text(size: fontFiguresSubtitleSize)

  //Indentation of Lists
  set list(indent: listIdentation)
  set enum(indent: listIdentation)

  // Citations
  set cite(style: citationStyle)

  // Additional Syntax Styles
  set raw(syntaxes: ("/syntax/cds.sublime-syntax"))

  // Statutory Declaration
  include "/supplementary/statutoryDeclaration.typ"
  pagebreak()

  // Abstract
  include "/supplementary/abstract.typ"
  pagebreak()

  // Abstract German
  include "/supplementary/abstractGerman.typ"
  pagebreak()

  // Enable short captions to omit citations
  show outline: it => {
      in-outline.update(true)
      it
      in-outline.update(false)
  }

  // Table of Contents
  outline(
    title: {
      heading(outlined: false, "Table of Contents")
      
    },
    target: heading.where(supplement: [Chapter], outlined: true),
    indent: auto,
    depth: 3
  )
  
  v(2.4fr)
  pagebreak()

  // List of Figures
  outline(
    title: {
      heading(outlined: false, "List of Figures")
      
    },
    target: figure.where(kind: image),
  )
  pagebreak()

  // List of Tables
  outline(
    title: {
      heading(outlined: false, "List of Tables")
      
    },
    target: figure.where(kind: table)
  )
  pagebreak()

  // List of Listings
  outline(
    title: {
      heading(outlined: false, "List of Listings")
      
    },
    target: figure.where(kind: raw)
  )
  pagebreak()

  // List of Abbreviations
  heading(outlined: false)[List of Abbreviations]
  
  print-glossary(
    abbreviations,
    show-all: false,
    disable-back-references: true,
  )

  // Main Body
  set heading(numbering: headingsNumberingStyle, supplement: [Chapter])
  show heading.where(level: 1): it => {
    if it.numbering == none {
      [
        #it
      ]
    } else {
      [
        #pagebreak()
        #it
      ]
    }

    counter(figure.where(kind: table)).update(0);
    counter(figure.where(kind: image)).update(0);
    counter(figure.where(kind: raw)).update(0);
  }

  set figure(numbering: it => {
    let numberingOfHeading = counter(heading).display();
    let topLevelNumber = numberingOfHeading.slice(0, numberingOfHeading.position("."))
    [#topLevelNumber.#it]
  })
  
  set page(
    // Header with current heading
    header: context {
      let elements = query(
        selector(heading.where(depth: 1)).after(here())
      )

      // Don't show header if a new chapter is starting at the current page
      if elements != () and elements.first().location().page() == here().page() and elements.first().depth == 1 {
          return;
      }

      let displayHeading
      let displayNumbering
      let element
      elements = query(selector(heading).after(here()))
      if elements != () and elements.first().location().page() == here().page() {
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
          heading.where().before(here())        )
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
    },
    
    // Footer with Page Numbering
    footer: context {
      let currentPage = counter(page).display()
      let finalPage = counter(page).final().first()
  
      line(length: 100%, stroke: (paint: gray))
      align(center)[#currentPage / #finalPage]
    }
  )

  set page(
    numbering: "1/1",
    number-align: center,
  )
  counter(page).update(1)
  // Set after header and after all initial pages to just apply it to the acutal content
  show par: set block(spacing: spaceBeforeParagraph)

  // Actual Content
  body
}

// Appendix
#let appendix(body) = {
  pagebreak()
  outline(
    title: {
      heading("Appendix", outlined: true, numbering: none)
    },
    target: heading.where(supplement: [Appendix], outlined: true),
    indent: auto,
    depth: 3
  )

  counter(heading).update(0)
  set heading(numbering: "A.1.", supplement: [Appendix])
  show heading: it => {
    let prefixedNumbering;
    if it.level == 1 and it.numbering != none {
      prefixedNumbering = [#it.supplement #counter(heading).display()]
    } else if it.numbering != none {
      prefixedNumbering = [#counter(heading).display()]
    }
    
    block(
      below: 0.85em, 
      above: 1.75em
    )[
      #prefixedNumbering #it.body
    ]
  }

  set figure(numbering: it => {
    let alphabet = ("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z")
    let numberingOfHeading = counter(heading).display();
    let topLevelNumber = numberingOfHeading.slice(0, numberingOfHeading.position("."))
    let index = alphabet.position((el) => { el == topLevelNumber})

    if index == none {
      let numberingToAlphabet = numbering("A", int(topLevelNumber))
      [#numberingToAlphabet.#it]
    } else {
      [#topLevelNumber.#it]
    }
  })

  show heading.where(level: 1): it => {
    if it.numbering == none {
      [
        #it
      ]
    } else {
      [
        #pagebreak()
        #it
      ]
    }

    counter(figure.where(kind: table)).update(0);
    counter(figure.where(kind: image)).update(0);
    counter(figure.where(kind: raw)).update(0);
  }

  body
}