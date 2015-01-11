#!/usr/bin/env swipl

:- initialization main.

file_procesed.

process_file(File):-
    read_line_to_codes(File, Line),
    ( Line \= end_of_file
    -> process_line(Line),
    process_file(File)
    ;
    file_procesed
    ).

process_line(Line):-
    tokenize_line(Line, ListTokens),
    phrase(f_date(Date), ListTokens),
    ( Date = 'void'
        -> write(Date),write(' '),write(ListTokens),nl
        ; write(Date),nl
    ).

main :-
    ensure_loaded(tokenizer),
    ensure_loaded(parser),
    %open('example_test.txt', read, File),
    open('examples_birth_date.txt', read, File),
    process_file(File),
    close(File),
    halt.
