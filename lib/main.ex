defmodule Main do
  def main(["-help"]),
    do:
      IO.puts("too lazy to write a help guide. look at lib/main.ex, its pretty self-explanatory")

  def main(["-repl"]) do
    case IO.gets("-> ") do
      "done\n" ->
        IO.puts("i dont want to catch you using a regular calculator")

      expr ->
        Smalc.output(expr)
        main(["-repl"])
    end
  end

  def main(["-eval", expr]), do: expr |> Smalc.output()

  def main([file]), do: File.read!(file) |> Smalc.output()

  def main(_), do: exit("Argument error")
end
