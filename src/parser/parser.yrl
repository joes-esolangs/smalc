% TODO: redefine numbers

Nonterminals expr.
Terminals num bracket add sub mul divi ident ':' '.' pow.
Rootsymbol expr.

Right 30 pow.
Right 40 divi. 
Right 50 mul.
Right 60 add.
Right 70 sub.

expr -> num                                  : '$1'. 
expr -> bracket expr bracket                 : '$2'.
expr -> add expr expr                        : {add, '$2', '$3'}.
expr -> expr sub expr                        : {sub, '$1', '$3'}.
expr -> expr expr mul                        : {mul, '$1', '$2'}.
expr -> expr divi expr                       : {divi, '$1', '$3'}.
expr -> expr pow expr expr                   : {pow, '$1', '$4'}.
% maybe change it later to make it weirder
% also make it possible to redefine numbers
expr -> ':' expr ident ':' expr              : {assign, '$3', '$2', '$5'}.
expr -> ident '.'                            : {get, '$1'}.

Erlang code.