defmodule Parser do
  def parser() do
    {:ok, erl} = :erlog.new()
    {:ok, preds} = :erlog.consult("parser/parser.pl", erl)
    # {:ok, parser} = :erlog.load(:parser, preds)
    # parser.parse("5 2 +", :ast)
    preds
  end
end
