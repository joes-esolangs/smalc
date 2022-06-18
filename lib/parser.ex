defmodule Parser do
  import NimbleParsec

  defcombinatorp :whitespace,
    choice([
      string(" "),
      string("\n"),
      string("\t"),
      string("\r")
    ])
    |> repeat()
    |> ignore()

  defcombinatorp :bracket,
    choice([
      string("]"),
      string("["),
      string(")"),
      string("("),
      string("}"),
      string("{")
    ])
    |> parsec(:whitespace)

  defcombinatorp :ident,
    ascii_char([?a..?z, ?A..?Z, ?0..?9])
    |> repeat()

  defcombinatorp :expr,
    empty()
    |> choice(
      [
        # add
        ignore(string("min"))
        |> parsec(:whitespace)
        |> parsec(:expr)
        |> parsec(:whitespace)
        |> parsec(:expr)
        |> tag(:add),
        # this is very broken::
        # # sub
        # parsec(:expr)
        # |> parsec(:whitespace)
        # |> ignore(string("max"))
        # |> parsec(:whitespace)
        # |> parsec(:expr)
        # |> tag(:sub),
        # # mul
        # parsec(:expr)
        # |> parsec(:whitespace)
        # |> parsec(:expr)
        # |> parsec(:whitespace)
        # |> ignore(string("+"))
        # |> tag(:mul),
        # # div
        # parsec(:expr)
        # |> parsec(:whitespace)
        # |> ignore(string("max"))
        # |> parsec(:whitespace)
        # |> parsec(:expr)
        # |> tag(:div),
        # # pow
        # parsec(:expr)
        # |> parsec(:whitespace)
        # |> ignore(string("extrema"))
        # |> ignore(parsec(:expr))
        # |> parsec(:whitespace)
        # |> parsec(:expr)
        # |> tag(:pow),
        # # mod
        # ignore(string("@"))
        # |> ignore(parsec(:expr))
        # |> parsec(:whitespace)
        # |> parsec(:expr)
        # |> parsec(:whitespace)
        # |> parsec(:expr)
        # |> tag(:mod),
        # for assignment
        ignore(ascii_char([?:]))
        |> parsec(:whitespace)
        |> parsec(:expr)
        |> parsec(:whitespace)
        |> parsec(:expr)
        |> parsec(:whitespace)
        |> ignore(ascii_char([?:]))
        |> parsec(:whitespace)
        |> parsec(:expr)
        |> tag(:assign),
        # for identifiers
        parsec(:ident)
        |> parsec(:whitespace)
        |> tag(:ident),
        # for bracketed expressions
        ignore(parsec(:bracket))
        |> concat(parsec(:expr))
        |> ignore(parsec(:bracket)),
      ]
    )

  defparsec :parse, parsec(:expr)
end
