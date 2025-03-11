#import "thesis/template.typ": *
#import "common/todo.typ": *
#import "metadata.typ": *
#import "@preview/glossarium:0.5.4": make-glossary, register-glossary
#import "/abbreviations.typ": abbreviations

#show: make-glossary
#register-glossary(abbreviations)
#show: thesis.with(
  degree: degree,
  program: program,
  title: titleEnglish,
  subtitle: subtitleEnglish,
  author: author,
  matriculationNumber: matriculationNumber,
  placeOfWork: placeOfWork,
  supervisor: supervisor,
  advisor: advisor,
  startDate: startDate,
  submissionDate: submissionDate
)

#include "chapters/1_introduction.typ"

#include "chapters/2_foundations.typ"

//Bibliography
#pagebreak()
#bibliography("bibliography/thesis.bib")

//Appendix
#appendix()[
  #include "chapters/A1_Material.typ"

  #include "chapters/A2_Transcripts.typ"
]