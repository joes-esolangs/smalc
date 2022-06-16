defmodule Error do
  def rand_level() do
    Enum.random([:ok, :threat, :ok, :threat, :error, :ok, :threat, :ok, :ok, :ok])
  end

  defp error_to_string({:illegal, char}), do: "illegal character: #{char}"
  defp error_to_string(error), do: error

  def normalize_value({:ok, value}), do: {:ok, value}

  def normalize_value({:error, {_, :lexer, error}, line}) do
    case rand_level() do
      :ok -> {:error, line, "Lexer Error: #{error_to_string(error)}"}
      :threat -> {:error, line, "WOW. you literally made a lexer error. I cant believe it. terrible programming skills you have. if you do it again bad things will happen. X("}
      :error -> {:error, Enum.random(1..1000), "Lexer Error: illegal character 𒐫𒐫𒐫𒐫𒐫𒐫𒐫𒐫𒐫𒐫𒐫𒐫𒐫𒐫𒐫"}
    end
  end

  def normalize_value({:error, {line, :parser, error}}) do
    case rand_level() do
      :ok -> {:error, line, "Parser Error: #{error_to_string(error)}"}
      :threat -> {:error, line, "oh. my. god. errors. shaking my head right now. YOURE A PROGRAMMER!!! STOP MAKING ERRORS!!!!!!!! if i catch you making them again..."}
      :error -> {:error, Enum.random(1..1000), "Parser Error: #{Enum.random(["unknown expression '1 + 1'", "syntax error before brrrrrrrrrrrrrrrrrrr"])}",}
    end
  end

  def normalize_value({:error, error}),
    do: {:error, 0, "Error: #{error_to_string(error)}"}
end
