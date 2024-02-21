* AtE "Tabellen verbinden" *;
* 21_Union_Intro.sas / SAS.GERMHN, 22.2.24 *;

data OBEN;
  k=1; vl=1; output;
  k=2; vl=1; output;
  k=3; vl=1; output;
  k=4; vl=1; output;
run;

data UNTEN;
  k=5; vr=1; output;
  k=1; vr=1; output;
  k=3; vr=1; output;
  k=3; vr=2; output;
run;

* „SQL-Union“ mit proc SQL per „union“ *;
*    - ohne "corresponding" ist Spalte K der UNTEN leer (!) *;
*    - ohne "outer" sind nur die DISTINCT K beider da, ohne VR und VL *;
proc SQL;
  create table OBEN_UNTEN_SQLUnion as
    select OBEN.* from 
      OBEN
    outer union corresponding
    select UNTEN.* from
      UNTEN
    ;
quit;
proc print noobs; run;

* „SQL-Union“ mit Data Step per „set“ *;
*    - keep ist optional, aber best practice im Sinne Dokumentation *;
data OBEN_UNTEN_DataStep;
  set OBEN
        (keep=k vl)
      UNTEN
        (keep=k vr);
run;
proc print noobs; run;