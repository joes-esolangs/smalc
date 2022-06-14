Definitions.

NUM        = [0-9|A|B|C|D|E|F]+
WHITESPACE = [\s\t\n\r]
BRACKET    = \[|\]|\(|\)|\{|\}
% BIN        = 🤣|🔪|💏|🐦

Rules.

{NUM}         : {token, {num,  TokenLine, TokenChars}}.
{BRACKET}     : {token, {bracket,  TokenLine}}.
🤣            : {token, {add, TokenLine}}.
🔪            : {token, {sub, TokenLine}}.
💏            : {token, {mul, TokenLine}}.
🐦            : {token, {divi, TokenLine}}.
% Possibility
% {BIN}         : {token, {bin, TokenLine, TokenChars}}.
{WHITESPACE}+ : skip_token.

Erlang code.