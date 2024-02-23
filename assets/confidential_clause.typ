#let __cc_messages_array = (
    (
        "de": "Sperrvermerk",
        "en": "Confidential Clause"
    ),
    (
        "de": "Die nachfolgende Arbeit enthält vertrauliche Daten der:",
        "en": "The following thesis contains confidential data from:"
    ),
    (
        "de": "Der Inhalt dieser Arbeit darf weder als Ganzes noch in Auszügen Personen außerhalb des Prüfungsprozesses und des Evaluationsverfahrens zugänglich gemacht werden, sofern keine anderslautende Genehmigung vom Dualen Partner vorliegt.",
        "en": "The content of this thesis must not be made accessible, either in its entirety or in excerpts, to individuals outside the examination process and evaluation procedure, unless there is explicit permission from the Dual Partner."
    )
)

#let __cc_messages(idx, lang) = __cc_messages_array.at(idx).at(lang)

#let confidentialClauseWith(
  lang: "de"
) = [
    #heading(outlined: false, numbering: none, __cc_messages(0, lang))

    #__cc_messages(1, lang)

    #pad(
        left: 30pt, 
        top: 0.5cm, 
        bottom: 0.5cm, 
        [
            SAP SE \
            Dietmar-Hopp-Allee 16 69190 Walldorf, Deutschland        
        ]
    )

    #__cc_messages(2, lang)
]

#confidentialClauseWith(lang: "en")