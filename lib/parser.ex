defmodule Parser do
  # dead dead dead and doesnt work
  import NimbleParsec

  defcombinatorp :expr,
    empty()
    |> choice(
      [
        parsec(:e1),
        parsec(:assign)
      ]
    )

  defparsec :parse, parsec(:expr)

  defcombinatorp :whitespace,
    choice([
      string(" "),
      string("\n"),
      string("\t"),
      string("\r")
    ])
    |> repeat()
    |> ignore()

  defcombinatorp :rbrack,
    choice([
      string("["),
      string(")"),
      string("("),
      string("}"),
      string("{")
    ])
    |> parsec(:whitespace)

  defcombinatorp :lbrack,
    choice([
      string("]"),
      string(")"),
      string("("),
      string("}"),
      string("{")
    ])
    |> parsec(:whitespace)

  defcombinatorp :ident,
    ascii_char([?a..?z, ?A..?Z, ?0..?9])
    |> repeat()

  defcombinatorp :assign,
    ignore(ascii_char([?:]))
    |> parsec(:whitespace)
    |> parsec(:expr)
    |> parsec(:whitespace)
    |> parsec(:expr)
    |> parsec(:whitespace)
    |> ignore(ascii_char([?:]))
    |> parsec(:whitespace)
    |> parsec(:expr)
    |> tag(:assign)

  defcombinatorp :e1,
    choice(
      [
        parsec(:e2)
        |> parsec(:whitespace)
        |> ignore(string("extrema"))
        |> ignore(parsec(:e2))
        |> repeat()
        |> parsec(:e2)
        |> tag(:pow),
        parsec(:e2)
      ]
    )

  defcombinatorp :e2,
    choice(
      [
        parsec(:e3)
        |> parsec(:whitespace)
        |> ignore(string("-"))
        |> repeat()
        |> parsec(:e3)
        |> tag(:div),
        parsec(:e3)
      ]
    )

  defcombinatorp :e3,
    choice(
      [
        parsec(:e4)
        |> parsec(:whitespace)
        |> repeat(parsec(:e4) |> parsec(:whitespace) |> ignore(string("+")))
        |> tag(:mul),
        parsec(:e4)
      ]
    )

  defcombinatorp :e4,
    choice(
      [
        ignore(string("min"))
        |> parsec(:whitespace)
        |> parsec(:e5)
        |> parsec(:whitespace)
        |> repeat()
        |> parsec(:e5)
        |> tag(:add),
        parsec(:e5)
      ]
    )


  defcombinatorp :e5,
    choice(
      [
        parsec(:e6)
        |> parsec(:whitespace)
        |> ignore(string("max"))
        |> repeat()
        |> parsec(:e6)
        |> tag(:sub),
        parsec(:e6)
      ]
    )

  defcombinatorp :e6,
    choice(
      [
        ignore(string("@"))
        |> ignore(parsec(:e7))
        |> parsec(:whitespace)
        |> parsec(:e7)
        |> parsec(:whitespace)
        |> repeat()
        |> parsec(:e7)
        |> tag(:mod),
        parsec(:e7)
      ]
    )

  defcombinatorp :e7,
    choice(
      [
        parsec(:ident)
        |> tag(:ident),
        ignore(parsec(:rbrack))
        |> parsec(:expr)
        |> ignore(parsec(:lbrack))
      ]
    )


end
