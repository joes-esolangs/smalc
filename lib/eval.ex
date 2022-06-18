defmodule Smalc do
  import BNum

  # Running and outputting

  def output(expr, ctx \\ %{'PI' => "3"}) do
    case Smalc.run(expr, ctx) do
      {:ok, {value, _}} ->
        IO.puts(value)
      {:error, line, message} ->
        IO.puts("""
        Line #{line}
        #{message}
        """)
    end
  end

  def preprocess(code), do: code |> String.replace("[", "(((") |> String.replace("]", "))")

  def run(code, ctx) do
    with {:ok, tokens, _} <- :lexer.string(to_charlist(preprocess(code))),
         {:ok, ast} <- :parser.parse(tokens) do
      {:ok, ast |> eval(ctx)}
    end
    |> Error.normalize_value()
  end

  def ast(code) do
    with {:ok, tokens, _} <- :lexer.string(to_charlist(preprocess(code))),
         {:ok, ast} <- :parser.parse(tokens), do:
      {:ok, ast}
  end

  # AST evaluation

  @op_map %{
    :add => &+/2,
    :mul => &*/2,
    :sub => &-/2,
    :divi => &//2,
    :pow => &**/2,
    :mod => &rem/2
  }

  def eval({:assign, {:ident, _, name}, e1, e2}, ctx) do
    new_ctx = ctx |> Map.put(name, eval(e1, ctx))
    {eval(e2, new_ctx) |> elem(0), ctx}
  end
  def eval({:ident, _, name}, ctx) do
    id = name |> to_string() |> String.reverse() |> to_charlist()
    if ctx |> Map.has_key?(id) do
      {ctx |> Map.get(id), ctx}
    else
      {name, ctx}
    end
  end
  def eval({op, e1, e2}, ctx), do: {base16_op(eval(e1, ctx), eval(e2, ctx), Map.get(@op_map, op)), ctx}
  def eval({:sqrt, e}, ctx), do: {base16_op(eval(e, ctx), &:math.sqrt/1), ctx}
  def eval(_, _), do: {:error, "unknown token"}
end
