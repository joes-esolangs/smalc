defmodule Main do
  def main(["-help"]), do: IO.puts("too lazy to write a help guide. look at lib/main.ex, its pretty self-explanatory")

  def main(["-repl"]) do
    IO.gets("-> ") |> handle_expression()
  end

  def main(["-eval", expr]) do
    expr
    |> Smalc.run()
    |> IO.puts()
  end

  def main([file]) do
    File.read!(file)
    |> Smalc.run()
    |> IO.puts()
  end

  def main(_) do
    exit("Argument error")
  end

  # Handling repl inputs

  defp handle_expression("done\n"), do: IO.puts("i dont want to catch you using a regular calculator")

  defp handle_expression(expression) do
    case Smalc.run(expression) do
      {:ok, value} ->
        IO.puts(value)

      {:error, line, message} ->
        IO.puts(
          """
          Line #{line}
          #{message}
          """
        )
    end

    main(["-repl"])
  end
end
