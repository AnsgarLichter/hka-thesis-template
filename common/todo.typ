#let todo(body) = [
  #let rblock = block.with(stroke: red, radius: 0.5em, fill: red.lighten(80%))
  #let top-left = place.with(top + left, dx: 1em, dy: -0.35em)
  #block(inset: (top: 0.35em), {
    rblock(width: 100%, inset: 1em, body)
    top-left(rblock(fill: white, outset: 0.25em, text(fill: red)[*TODO*]))
  })
  <todo>
]

#let outline-todos(title: [TODOS]) = {
  heading(numbering: none, outlined: false, title)
  locate(loc => {
    let queried-todos = query(<todo>, loc)
    let headings = ()
    let last-heading
    for todo in queried-todos {
      let new-last-heading = query(selector(heading).before(todo.location()), loc).last()
      if last-heading != new-last-heading {
        headings.push((heading: new-last-heading, todos: (todo,)))
         last-heading = new-last-heading
      } else {
        headings.last().todos.push(todo)
      }
    }

    for head in headings {
      link(head.heading.location())[
        #numbering(head.heading.numbering, ..counter(heading).at(head.heading.location()))
        #head.heading.body
      ]
      [ ]
      box(width: 1fr, repeat[.])
      [ ]
      [#head.heading.location().page()]

      linebreak()
      pad(left: 1em, head.todos.map((todo) => {
        list.item(link(todo.location(), todo.body.children.at(0).body))
      }).join())
    }
  })
}