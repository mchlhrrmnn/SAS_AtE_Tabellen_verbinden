* AtE "Tabellen verbinden" *;
* 31_Join_Intro.sas / SAS.GERMHN, 22.2.24 *;

data LINKS;
  k=1; vl=1; output;
  k=2; vl=1; output;
  k=3; vl=1; output;
  k=4; vl=1; output;
run;

data RECHTS;
  k=5; vr=1; output;
  k=1; vr=1; output;
  k=3; vr=1; output;
  k=3; vr=2; output;
run;

* „SQL-Joinen“ mit proc SQL *;
proc SQL;
  create table LINKS_RECHTS_SQLJoin as
    select LINKS.*, RECHTS.VR, RECHTS.k as k_rechts from 
      LINKS
      join /*{inner|left|right|full} * inner = default falls keine Angabe */
      RECHTS
    on LINKS.k = RECHTS.k;
quit;
proc print noobs; run;

* „SQL-Joinen“ mit dem Data Step (Merge) *;
*   proc Sort data=RECHTS;
*     by k;
*   run;
data LINKS_RECHTS_DataStepMerge;
  keep k vl vr;
  merge LINKS(in=l)
        RECHTS(in=r);
  by k;
  * if l and r; * INNER *;
  * if l;       * LEFT  *;
  * if r;       * RIGHT *;
  * if l or r;  * FULL  *; * default falls kein if *;
run;
proc print noobs; run;
