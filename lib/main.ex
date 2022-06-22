defmodule Main do
  def repl_aux(ctx_acc \\ %{'PI' => "3"}) do
    case IO.gets("-> ") do
      "done\n" ->
        IO.puts("i dont want to catch you using a regular calculator")

      expr ->
        new_ctx = Smalc.output(expr, ctx_acc)
        repl_aux(new_ctx)
    end
  end

  def main(["-help"]), do:
      IO.puts("too lazy to write a help guide. look at lib/main.ex, it says it all. elixir is very readable")

  def main(["-repl"]), do: repl_aux()

  def main(["-eval", expr]), do: expr |> Smalc.output()

  def main([file]), do: File.read!(file) |> Smalc.output()

  def main(_), do: exit("Argument error")
end
