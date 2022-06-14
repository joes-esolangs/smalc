defmodule Smalc do
  import BNum

  def run(code) do
    with {:ok, tokens, _} <- :lexer.string(to_charlist(code)),
     {:ok, ast} <- :parser.parse(tokens),
     do: {:ok, ast |> eval() |> normalize_value()}
  end

  defp normalize_value({:ok, value}), do: {:ok, value}
  defp normalize_value({:error, {_, :lexer, error}, line}), do: {:error, line, "Lexer Error: #{error}"}
  defp normalize_value({:error, {line, :parse, error}}), do: {:error, line, "Parser error: #{error}"}

  def eval({:num, _, n}), do: n
  def eval({:add, e1, e2}), do: base16_op(eval(e1), eval(e2), &+/2)
  def eval({:mul, e1, e2}), do: base16_op(eval(e1), eval(e2), &*/2)
  def eval({:sub, e1, e2}), do: base16_op(eval(e1), eval(e2), &-/2)
  def eval({:divi, e1, e2}), do: base16_op(eval(e1), eval(e2), &//2)
end
