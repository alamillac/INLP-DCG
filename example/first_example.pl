% Este es mi primer programa Prolog
%
% Se trata de un arbol genealogico muy simple
%
% Parentescos basicos
% padre(A,B) significa que B es el padre de A

padre(juan, alberto).
padre(luis, alberto).
padre(alberto, leoncio).
padre(geronimo, leoncio).
padre(luisa, geronimo).

% Hermanos

hermano(A, B) :-
    padre(A, P),
    padre(B, P),
    A \== B.

% abuelo-nieto
% nieto(A,B) significa que A es nieto de B

nieto(A, B) :-
    padre(A, P),
    padre(P, B).

sum(List,Sum) :-
        List = []
         ->   Sum = 0
         ;    List = [Head|Tail],
              sum(Tail,TailSum),
              Sum is TailSum + Head.

add_2(X,Y):-
    Y is X + 2.

a_sqrt(X,Y) :-
        X > 0,
        Y is -sqrt(X).

a_sqrt(X,Y) :-
        X > 0,
        Y is sqrt(X).
