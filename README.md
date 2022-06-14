# smalc
 a joke calculator written in elixir

# features

- All operators are emojis
- All numbers are in base 16
- All decimals get rounded
- For grouping stuff you can mismatch any `{` `}` `[` `]` `(` `)`
- All operators are right associative
- All the precedences are messed up. Division is 40, multiplication is 50, addition is 50, and subtraction is 60.

# how to use

Run `mix escript.build` and it will generate `smalc.exe`. Use `smalc filename` to run a file, or `smalc eval "code"` to evaluate an expression, or `smalc repl` for a repl. 

Run `smalc help` for the help guide.
