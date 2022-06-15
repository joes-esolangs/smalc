defmodule SmalcTest do
  use ExUnit.Case
  doctest Smalc

  test "math" do
    assert Smalc.run("4 + min 9 )8 4 -}") == {:ok, "2C"}
  end
end
