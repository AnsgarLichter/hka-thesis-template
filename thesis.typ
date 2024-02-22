#import "thesis/template.typ": *
#import "common/todo.typ": *
#import "metadata.typ": *
#import "@preview/glossarium:0.2.6": make-glossary

#show: make-glossary
#show: thesis.with(
  degree: degree,
  program: program,
  title: titleEnglish,
  author: author,
  matriculationNumber: matriculationNumber,
  supervisor: supervisor,
  advisor: advisor,
  startDate: startDate,
  submissionDate: submissionDate
)

#include "chapters/1_introduction.typ"
#pagebreak()

#include "chapters/2_foundations.typ"
#pagebreak();

//Bibliography
#bibliography("bibliography/thesis.bib")
#pagebreak();

//Appendix
#heading(numbering: none)[Appendix A: Additional Material]
#include "chapters/A1_Material.typ"
