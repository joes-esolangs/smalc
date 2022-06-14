Definitions.

NUM        = [0-9|A|B|C|D|E|F]+
WHITESPACE = [\s\t\n\r]
BRACKET    = \[|\]|\(|\)|\{|\}

Rules.

{NUM}          : {token, {num,  TokenLine, TokenChars}}.
{BRACKET}      : {token, {bracket,  TokenLine}}.
min            : {token, {add, TokenLine}}.
max            : {token, {sub, TokenLine}}.
\+             : {token, {mul, TokenLine}}.
\-             : {token, {divi, TokenLine}}.
{WHITESPACE}+ : skip_token.

Erlang code.