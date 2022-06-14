defmodule BNum_Deprecated do
  def base16_digit(n) when n in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] do
    {num, _} = Integer.parse(n, 10)
    num
  end
  def base16_digit(n) when n in ["A", "B", "C", "D", "E", "F"] do
    key =
      %{
        "A" => 10,
        "B" => 11,
        "C" => 12,
        "D" => 13,
        "E" => 14,
        "F" => 15
      }
    key[n]
  end

  def base10_digit(n) when n in 0..9, do: inspect(n)
  def base10_digit(n) when n in 10..15 do
    key =
      %{
        10 => "A",
        11 => "B",
        12 => "C",
        13 => "D",
        14 => "E",
        15 => "F"
      }
    key[n]
  end

  def quotient(n, f) do
    n / f |> floor()
  end

  def quotient_list(0), do: []
  def quotient_list(n) do
    [Integer.mod(n, 16)] ++ quotient_list(quotient(n, 16))
  end

  def to_base10(num) do
    num_digits = num |> String.split("") |> Enum.drop(1) |> Enum.take(String.length(num))
    for {n, e} <- Enum.zip(num_digits, (String.length(num)-1)..0) do
      base16_digit(n) * (16 ** e)
    end |> Enum.sum()
  end

  def to_base16(num) do
    quotient_list(num) |> Enum.map(&base10_digit/1) |> to_string() |> String.reverse()
  end
end
