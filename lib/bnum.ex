defmodule BNum do
  def to_base10(num) do
    {num, _} = Integer.parse(to_string(num), 16)
    num
  end

  def to_base16(num), do: Integer.to_string(round(num), 16)

  def base16_op(n, m, op) when is_function(op), do: op.(to_base10(elem(n, 0)), to_base10(elem(m, 0))) |> to_base16()

  def base16_op(n, op), do: op.(to_base10(elem(n, 0))) |> to_base16()
end
