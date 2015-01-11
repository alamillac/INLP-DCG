#!/usr/bin/env swipl

tokenize_line(String, ListTokens):-
    %Separators must be in a different token
    Separators = "[]/-|~",
    string_to_list(Separators, SepList),
    string_to_list(String, ListCodes),
    space_to_separators(SepList, ListCodes, NewList),
    string_to_list(NewString, NewList),
    split_string(NewString, "\s\t,'", "\s\t,'", ListStrings),
    maplist(atom_codes, ListTokens, ListStrings).

space_to_separators(_, VoidList, NewList):-
    VoidList = [],
    NewList = [].

space_to_separators(Sep, [H|T], NewList):-
    Space = 32,
    space_to_separators(Sep, T, NL),
    ( member(H, Sep) ->
        append([Space, H, Space], NL, NewList)
        ; NewList = [ H | NL ]
    ).
