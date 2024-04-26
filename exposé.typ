#import "exposé/template.typ": *
#import "common/todo.typ": *
#import "metadata.typ": *

#show: exposé.with(
  degree: degree,
  program: program,
  title: titleEnglish,
  subtitle: subtitleEnglish,
  titleGerman: titleGerman,
  subtitleGerman: subtitleGerman,
  author: author,
  matriculationNumber: matriculationNumber,
  placeOfWork: placeOfWork,
  supervisor: supervisor,
  startDate: startDate,
  submissionDate: submissionDateExposé
)

= Motivation and Background
#todo()[
  + In welchem Umfeld (Firma / Abteilung) fertigen Sie Ihre Arbeit an? 
  + Was ist dort der hauptsächliche Arbeitsschwerpunkt? 
  + In welchem Forschungs- oder Entwicklungs- projekt wird die Arbeit eingeordnet?
  + Welche Ausgangspunkte finden Sie bereits vor und sind somit nicht mehr Teil der Arbeit? 
  + Welche Vorgaben macht man Ihnen (Sprache, Tools, etc.)? 
  + Welche Literatur gibt es zum Thema?
]

This is an example citation @Smith.2020.

= Goal and Approach
#todo()[
  + Nennen Sie auch das Ziel der Arbeit: Was soll am Ende vorliegen (z.B. ein Prototyp, eine Machbarkeitsstudie, eine Marktanalyse, ein fertiges Modul, usw.)?
  + Welche Arbeitsschritte sollen ausgeführt werden, wenn die Arbeit wie geplant abläuft?
]

#pagebreak()
#bibliography("bibliography/exposé.bib")