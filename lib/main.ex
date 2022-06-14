defmodule Main do
  def main(["-help"]), do: IO.puts("too lazy to write a help guide. look at lib/main.ex, its pretty self-explanatory")

  def main(["-repl"]) do
    expr = IO.gets("-> ")
    if expr == "done\n" do
      IO.puts("i dont want to catch you using a regular calculator")
    else
      try do
        expr |> Smalc.run() |> IO.puts()
      rescue
        e -> IO.puts("Error occured: #{Exception.message(e)}")
      end
      main(["-repl"])
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
