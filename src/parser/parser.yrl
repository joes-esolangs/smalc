Nonterminals prog expr.
Terminals num bracket add sub mul divi.
Rootsymbol prog.

Right 40 divi. 
Right 50 mul.
Right 60 add.
Right 70 sub.

prog -> expr : '$1'.

expr -> num : '$1'. 
expr -> bracket expr bracket : '$2'.
expr -> expr add expr : {add, '$1', '$3'}.
expr -> expr sub expr : {sub, '$1', '$3'}.
expr -> expr mul expr : {mul, '$1', '$3'}.
expr -> expr divi expr : {divi, '$1', '$3'}.

Erlang code.