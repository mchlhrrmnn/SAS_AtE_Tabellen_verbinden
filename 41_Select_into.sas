* AtE "Tabellen verbinden" *;
* 41_Select_into.sas / SAS.GERMHN, 22.2.24 *;

proc SQL noprint;
  select distinct trim(MAKE)!!"="
                  !!left(put(floor(mean(HORSEPOWER)),best.)) 
    into :ALLE_PS separated by " / "
    from SASHELP.CARS
    group by MAKE;
quit;

footnote1 Durchschnittliche PS je Autobauer:;
footnote2 &ALLE_PS;

proc SQL;
  select MAKE, MODEL, HORSEPOWER
    from SASHELP.CARS 
    where HORSEPOWER < 120;
quit;

