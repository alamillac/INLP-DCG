#!/usr/bin/env swipl

tokenize_line(String, ListTokens):-
    %Separators must be in a different token
    Separators = "[]/-|~",
    string_to_list(Separators, SepList),
    string_to_list(String, ListCodes),
    space_to_separators(SepList, ListCodes, NewList),

    CharsToRemove = ",'",
    string_to_list(CharsToRemove, RmList),
    remove_chars(RmList, NewList, NewList2),

    string_to_list(NewString, NewList2),
    %split_string(NewString, "\s\t,'", "\s\t,'", ListStrings),
    %maplist(atom_codes, ListTokens, ListStrings).
    tokenize_atom(NewString, ListTokens).

remove_chars(_, [], NL):-
    NL = [].

remove_chars(CharsToRemove, [H|T], NewList):-
    Space = 32,
    remove_chars(CharsToRemove, T, NL),
    ( member(H, CharsToRemove) ->
        append([Space], NL, NewList)
        ; NewList = [ H | NL ]
    ).

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
