Definitions.

NUM        = [0-9A-F]+
WHITESPACE = [\s\t\n\r]
BRACKET    = \[|\]|\(|\)|\{|\}
IDENT      = [a-zA-Z0-9]+

Rules.

{NUM}          : {token, {num,  TokenLine, TokenChars}}.
{BRACKET}      : {token, {bracket,  TokenLine}}.
min            : {token, {add, TokenLine}}.
max            : {token, {sub, TokenLine}}.
\+             : {token, {mul, TokenLine}}.
\-             : {token, {divi, TokenLine}}.
\:             : {token, {':', TokenLine}}.
\.             : {token, {'.', TokenLine}}.
{IDENT}        : {token, {ident, TokenLine, TokenChars}}.
{WHITESPACE}+  : skip_token.

Erlang code.