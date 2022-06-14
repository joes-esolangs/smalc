defmodule Main do
  def main(["-repl"]) do
    expr = IO.gets("-> ")
    if expr == "done\n" do
      IO.puts("i dont want to catch you using a regular calculator")
    else
      try do
        expr |> Smalc.run() |> IO.puts()
      catch
        e -> IO.puts("Error: #{Exception.message(e)}")
      after
        main(["-repl"])
      end
    end
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
end
