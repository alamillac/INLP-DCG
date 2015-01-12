#!/usr/bin/env swipl

mapMonth('January', 1).
mapMonth('Jan', 1).
mapMonth('january', 1).
mapMonth('February', 2).
mapMonth('Feb', 2).
mapMonth('february', 2).
mapMonth('March', 3).
mapMonth('march', 3).
mapMonth('April', 4).
mapMonth('May', 5).
mapMonth('may', 5).
mapMonth('June', 6).
mapMonth('Jun', 6).
mapMonth('July', 7).
mapMonth('july', 7).
mapMonth('August', 8).
mapMonth('September', 9).
mapMonth('Sep', 9).
mapMonth('september', 9).
mapMonth('October', 10).
mapMonth('Oct', 10).
mapMonth('November', 11).
mapMonth('Nov', 11).
mapMonth('December', 12).
mapMonth('Dec', 12).

dayOfWeek('Monday').
dayOfWeek('Tuesday').
dayOfWeek('Wednesday').
dayOfWeek('Thursday').
dayOfWeek('Friday').
dayOfWeek('Saturday').
dayOfWeek('Sunday').

isSeparator('|').
isSeparator('-').
isSeparator('/').

ad_year(NumYear, ADYear):-
    number(NumYear),
    atomic_concat('AD ', NumYear, ADYear).

separator --> [Sep], {isSeparator(Sep)}.

open_separator --> ['[','['].
close_separator --> [']',']'].

abrv --> [NumAbr], {member(NumAbr, ['st', 'nd', 'rd', 'th'])}.
num(Num) --> [Num], {number(Num)}.
num(Num) --> [Num], {number(Num)},
             abrv.

day(NumDay) --> num(NumDay), {NumDay > 0, NumDay < 32}.

month(NumMonth) --> [Month], {mapMonth(Month, NumMonth)}.
month(NumMonth) --> num(NumMonth), {NumMonth < 13, NumMonth > 0}.

year(NumYear) --> num(NumYear).
year(ADYear) --> ['AD', Year], {ad_year(Year, ADYear)}.
year(ADYear) --> [Year, 'AD'], {ad_year(Year, ADYear)}.

birth_date --> [birth_date].
birth_date --> [birth, _, date].
birth_date --> [birth, date].

ca --> ['c','.'].
ca --> ['ca','.'].
ca --> [].

century --> ['century'].
century --> ['Century'].

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

%about [[1955]]
f_date(aprox(Date)) --> birth_date,
                        [about],
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

%Friday, [[July 26]], [[1968]]
p_date(date(Year,Month,Day)) --> [Dow], { dayOfWeek(Dow) },
                                 open_separator,
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

%[[21 July]] 1944
p_date(date(Year,Month,Day)) --> open_separator,
                                 day(Day),
                                 month(Month),
                                 close_separator,
                                 year(Year),
                                 any.

%1918|07|1
p_date(date(Year,Month,Day)) --> year(Year),
                                 separator,
                                 month(Month),
                                 separator,
                                 day(Day),
                                 any.

%11-07-1966
p_date(date(Year,Month,Day)) --> day(Day),
                                 separator,
                                 month(Month),
                                 separator,
                                 year(Year),
                                 any.

%7/20/61
p_date(date(Year,Month,Day)) --> month(Month),
                                 separator,
                                 day(Day),
                                 separator,
                                 year(Year),
                                 any.

%August 5, 1958
p_date(date(Year,Month,Day)) --> month(Month),
                                 day(Day),
                                 year(Year),
                                 any.

%18 May, 1959
p_date(date(Year,Month,Day)) --> day(Day),
                                 month(Month),
                                 year(Year).

%29 January|1860
p_date(date(Year,Month,Day)) --> day(Day),
                                 month(Month),
                                 separator,
                                 year(Year),
                                 any.

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

%[[february 17, 1961]]
p_date(date(Year,Month,Day)) --> open_separator,
                                 month(Month),
                                 day(Day),
                                 year(Year),
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

%May 8
p_date(date(nil,Month,Day)) --> month(Month),
                                day(Day).

%23rd October
p_date(date(nil,Month,Day)) --> day(Day),
                                month(Month).

%[[1877]]
%c. [[1877]]
p_year(date(Year)) --> ca,
                       open_separator,
                       year(Year),
                       close_separator.

%973
%c. 1973
p_year(date(Year)) --> ca,
                       year(Year).

p_date(Date) --> p_year(Date).

%[[626]] or [[627]]
p_date(or(Date1,Date2)) --> p_year(Date1),
                            [or],
                            p_year(Date2).

%[[468]]/[[470]]
p_date(between(Date1,Date2)) --> p_year(Date1),
                                 [/],
                                 p_year(Date2).

%about [[1000]] to [[1007]]
p_date(between(Date1,Date2)) --> p_year(Date1),
                                 [to],
                                 p_year(Date2).

%10th century
p_date(between(date(YearIni),date(YearFin))) --> num(Century),
                       century,
                       { YearFin is Century * 100,
                         YearIni is YearFin - 100 }.

%[[10th century]]
p_date(between(date(YearIni),date(YearFin))) --> open_separator,
                       num(Century),
                       century,
                       { YearFin is Century * 100,
                         YearIni is YearFin - 100 },
                       close_separator.
