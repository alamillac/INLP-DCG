#!/usr/bin/env swipl

mapMonth('January', 1).
mapMonth('February', 2).
mapMonth('March', 3).
mapMonth('April', 4).
mapMonth('May', 5).
mapMonth('June', 6).
mapMonth('July', 7).
mapMonth('August', 8).
mapMonth('September', 9).
mapMonth('October', 10).
mapMonth('November', 11).
mapMonth('December', 12).

isSeparator('|').
isSeparator('-').

ad_year(Year, ADYear):-
    atom_number(Year, NumYear),
    atomic_concat('AD ', NumYear, ADYear).

separator --> [Sep], {isSeparator(Sep)}.

open_separator --> ['[','['].
close_separator --> [']',']'].

day(NumDay) --> [Day], {atom_number(Day, NumDay), NumDay > 0, NumDay < 32}.

month(NumMonth) --> [Month], {mapMonth(Month, NumMonth)}.
month(NumMonth) --> [Month], {atom_number(Month, NumMonth), NumMonth < 13, NumMonth > 0}.

year(NumYear) --> [Year], {atom_number(Year, NumYear)}.
year(ADYear) --> ['AD', Year], {ad_year(Year, ADYear)}.
year(ADYear) --> [Year, 'AD'], {ad_year(Year, ADYear)}.

birth_date --> [birth_date].
birth_date --> [birth, date].

century --> ['c.'].
century --> [].

aprox --> ['~'].

unknown --> ['unknown'].
unknown --> ['Unknown'].

any --> [].
any --> [_], any.

%birth_date     Date
f_date(Date) --> birth_date,
                 p_date(Date).

%birth_date     ~ Date
f_date(aprox(Date)) --> birth_date,
                        aprox,
                        p_date(Date).

%Error handler
f_date(void) --> any.

%Unknown
p_date(date('Unknown')) --> unknown,
                            any.

%[[August 16]], [[1913]]
p_date(date(Year,Month,Day)) --> open_separator,
                                 month(Month),
                                 day(Day),
                                 close_separator,
                                 open_separator,
                                 year(Year),
                                 close_separator,
                                 any.

%[[22 April]] [[1571]]
p_date(date(Year,Month,Day)) --> open_separator,
                                 day(Day),
                                 month(Month),
                                 close_separator,
                                 open_separator,
                                 year(Year),
                                 close_separator,
                                 any.

%1918|07|1
p_date(date(Year,Month,Day)) --> year(Year),
                                 separator,
                                 month(Month),
                                 separator,
                                 day(Day),
                                 any.

%August 5, 1958
p_date(date(Year,Month,Day)) --> month(Month),
                                 day(Day),
                                 year(Year).

%18 May, 1959
p_date(date(Year,Month,Day)) --> day(Day),
                                 month(Month),
                                 year(Year).

%March 30, [[1955]]
p_date(date(Year,Month,Day)) --> month(Month),
                                 day(Day),
                                 open_separator,
                                 year(Year),
                                 close_separator.

%[[April 20]], 1586
p_date(date(Year,Month,Day)) --> open_separator,
                                 month(Month),
                                 day(Day),
                                 close_separator,
                                 year(Year).

%[[1885-11-01]]
p_date(date(Year,Month,Day)) --> open_separator,
                                 year(Year),
                                 separator,
                                 month(Month),
                                 separator,
                                 day(Day),
                                 close_separator.

%[[May]][[13]][[1984]]
p_date(date(Year,Month,Day)) --> open_separator,
                                 month(Month),
                                 close_separator,
                                 open_separator,
                                 day(Day),
                                 close_separator,
                                 open_separator,
                                 year(Year),
                                 close_separator.

%[[March]] 2 [[1973]]
p_date(date(Year,Month,Day)) --> open_separator,
                                 month(Month),
                                 close_separator,
                                 day(Day),
                                 open_separator,
                                 year(Year),
                                 close_separator.

%May 8
p_date(date(nil,Month,Day)) --> month(Month),
                                day(Day).

%November, 1954
p_date(date(Year,Month,nil)) --> month(Month),
                                 year(Year).

%[[December 1975]]
p_date(date(Year,Month,nil)) --> open_separator,
                                 month(Month),
                                 year(Year),
                                 close_separator.

%[[October]] [[1832]]
p_date(date(Year,Month,nil)) --> open_separator,
                                 month(Month),
                                 close_separator,
                                 open_separator,
                                 year(Year),
                                 close_separator.

%January [[1968]]
p_date(date(Year,Month,nil)) --> month(Month),
                                 open_separator,
                                 year(Year),
                                 close_separator.

%[[1877]]
%c. [[1877]]
p_year(date(Year)) --> century,
                       open_separator,
                       year(Year),
                       close_separator.

%973
%c. 1973
p_year(date(Year)) --> century,
                       year(Year).

p_date(Date) --> p_year(Date).

%[[626]] or [[627]]
p_date(or(Date1,Date2)) --> p_year(Date1),
                            [or],
                            p_year(Date2).

