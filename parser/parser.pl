:- module(parser, [parse/2]).
:- use_module(lexer).

run(Code, AST) :-
    tokenize(Code, Out),
    parse(Out, AST).

parse(Tokens, AST) :-
    AST is phrase(expr, Tokens).

expr --> e1.
expr --> assign.

e1 --> e2, [pow_t(_)], e2, e2.
e1 --> e2.

e2 --> e3, [div_t(_)], e3.
e2 --> e2.

e3 --> e4, e4, [mul_t(_)].
e3 --> e4.

e4 --> [add_t(_)], e5, e5.
e4 --> e5.

e5 --> e6, [sub_t(_)], e6.
e5 --> e6.

e6 --> [mod_t(_)], e7, e7.
e6 --> e7.

e7 --> [ident_t(_, _)].
e7 --> [l_brack_t(_)], e1, [r_brack_t(_)].

assign --> [colon_t(_)], e1, [ident_t(_, _)], [colon_t(_)], e1.