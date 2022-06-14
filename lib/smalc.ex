defmodule Smalc do
  import BNum

  def run(code) do
    {:ok, tokens, _} = code |> to_charlist() |> :lexer.string()
    {:ok, ast} = :parser.parse(tokens)
    eval(ast)
  end

  def eval({:num, _, n}), do: n

  def eval({:add, e1, e2}), do: base16_op(eval(e1), eval(e2), &+/2)

  def eval({:mul, e1, e2}), do: base16_op(eval(e1), eval(e2), &*/2)

  def eval({:sub, e1, e2}), do: base16_op(eval(e1), eval(e2), &-/2)

  def eval({:divi, e1, e2}), do: base16_op(eval(e1), eval(e2), &//2)
end
