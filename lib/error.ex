defmodule Error do
  @menacing_errors [
    "WOW. you literally made a lexer error. I cant believe it. terrible programming skills you have. if you do it again bad things will happen. X(",
    "oh. my. god. errors. shaking my head right now. YOURE A PROGRAMMER!!! STOP MAKING ERRORS!!!!!!!! if i catch you making them again...",
    "*sigh* really?",
    "your program is so incredibly horrible that you managed to break the type system. The type system, that uses an algorithm that can't fail on valid input. Ya know what that means? Go fix your damn types, dumbass",
    "your program is so incredibly horrible that you managed to break the type system. The type system, that uses an algorithm that can't fail on valid input. You know how hard is it to break the type system IN A LANGUAGE WITHOUT TYPES??? Fix your damn code already."
  ]

  @lexer_errors [
    "illegal character 𒐫𒐫𒐫𒐫𒐫𒐫𒐫𒐫𒐫𒐫𒐫𒐫𒐫𒐫𒐫",
    "couldn't tokenize program",
    "found unknown token that can't be described"
  ]

  @parser_errors [
    "unknown expression '1 + 1'",
    "syntax error go brrrrrrrrrrrrrrrrrrr",
    "parser cannot form syntax tree"
  ]

  defp rand_level(), do: Enum.random([:ok, :threat, :ok, :threat, :error, :ok, :threat, :ok, :ok, :ok])


  defp rand_error(:threat), do: Enum.random(@menacing_errors)
  defp rand_error(:lexer), do: Enum.random(@lexer_errors)
  defp rand_error(:parser), do: Enum.random(@parser_errors)


  defp error_to_string({:illegal, char}), do: "illegal character: #{char}"
  defp error_to_string(error), do: error

  def normalize_value({:ok, value}), do: {:ok, value}

  def normalize_value({:error, {_, :lexer, error}, line}) do
    case rand_level() do
      :ok -> {:error, line, "Lexer Error: #{error_to_string(error)}"}
      :threat -> {:error, line, rand_error(:threat)}
      :error -> {:error, Enum.random(1..1000), "Lexer Error: #{rand_error(:lexer)}"}
    end
  end

  def normalize_value({:error, {line, :parser, error}}) do
    case rand_level() do
      :ok -> {:error, line, "Parser Error: #{error_to_string(error)}"}
      :threat -> {:error, line, rand_error(:threat)}
      :error -> {:error, Enum.random(1..1000), "Parser Error: #{rand_error(:parser)}",}
    end
  end

  def normalize_value({:error, error}),
    do: {:error, 0, "Error: #{error_to_string(error)}"}
end
