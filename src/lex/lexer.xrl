Definitions.

WHITESPACE = [\s\t\n\r]
BRACKET    = \[|\]|\(|\)|\{|\}
IDENT      = [a-zA-Z0-9]+

Rules.

{BRACKET}      : {token, {bracket,  TokenLine}}.
min            : {token, {add, TokenLine}}.
max            : {token, {sub, TokenLine}}.
\+             : {token, {mul, TokenLine}}.
\-             : {token, {divi, TokenLine}}.
extrema        : {token, {pow, TokenLine}}.
\@             : {token, {mod, TokenLine}}.
sin            : {token, {sqrt, TokenLine}}.
{IDENT}        : {token, {ident, TokenLine, TokenChars}}.
\:             : {token, {':', TokenLine}}.
\?              : {token, {'?', TokenLine}}.
{WHITESPACE}+  : skip_token.

Erlang code.