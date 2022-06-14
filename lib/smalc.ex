defmodule Smalc do
  import BNum

  # Running and outputting

  def output(expr) do
    case Smalc.run(expr) do
      {:ok, value} ->
        IO.puts(value)

      {:error, line, message} ->
        IO.puts("""
        Line #{line}
        #{message}
        """)
    end
  end

  def run(code) do
    with {:ok, tokens, _} <- :lexer.string(to_charlist(code)),
         {:ok, ast} <- :parser.parse(tokens) do
      {:ok, ast |> eval()}
    end
    |> normalize_value()
  end

  # Errors and values

  def error_to_string({:illegal, char}), do: "illegal character: #{char}"
  def error_to_string(error), do: error

  defp normalize_value({:ok, value}), do: {:ok, value}

  defp normalize_value({:error, {_, :lexer, error}, line}),
    do: {:error, line, "Lexer Error: #{error_to_string(error)}"}

  defp normalize_value({:error, {line, :parser, error}}),
    do: {:error, line, "Parser error: #{error_to_string(error)}"}

  # AST evaluation

  def eval({:num, _, n}), do: n
  def eval({:add, e1, e2}), do: base16_op(eval(e1), eval(e2), &+/2)
  def eval({:mul, e1, e2}), do: base16_op(eval(e1), eval(e2), &*/2)
  def eval({:sub, e1, e2}), do: base16_op(eval(e1), eval(e2), &-/2)
  def eval({:divi, e1, e2}), do: base16_op(eval(e1), eval(e2), &//2)
end
