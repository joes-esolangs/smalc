defmodule Main do
  def main(["repl"]) do
    IO.puts("TODO")
  end

  def main(["eval", expr]) do
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
end
