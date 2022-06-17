% TODO: redefine numbers

Nonterminals expr.
Terminals bracket add sub mul divi ident ':' pow mod sqrt '?'.
Rootsymbol expr.

Right 30 pow.
Right 40 divi. 
Right 50 mul.
Right 60 add.
Right 70 sub.
Right 80 mod.

% maybe change it later to make it weirder
expr -> ':' expr ident ':' expr              : {assign, '$3', '$2', '$5'}.
expr -> ident                                : '$1'.

expr -> bracket expr bracket                 : '$2'.

expr -> expr '?' expr expr  : {ternary, '$1', '$3', '$4'}.

expr -> add expr expr                        : {add, '$2', '$3'}.
expr -> expr sub expr                        : {sub, '$1', '$3'}.
expr -> expr expr mul                        : {mul, '$1', '$2'}.
expr -> expr divi expr                       : {divi, '$1', '$3'}.
expr -> expr pow expr expr                   : {pow, '$1', '$4'}.
expr -> mod expr expr expr                   : {mod, '$2', '$4'}.
expr -> expr sqrt                            : {sqrt, '$1'}.

Erlang code.