* AtE "Tabellen verbinden" *;
* 32_Join_Many_to_Many_Merge.sas / SAS.GERMHN, 22.2.24 *;

data LINKS;
  k=1; vl=1; output;
  k=3; vl=1; output; * <- many-to-many *;
  k=3; vl=2; output; * <- many-to-many *;
  k=4; vl=1; output;
run;

data RECHTS;
  k=1; vr=1; output;
  k=3; vr=1; output; * <- many-to-many *;
  k=3; vr=2; output; * <- many-to-many *;
  k=5; vr=1; output;
run;

* „SQL-Joinen“ mit dem Data Step (Merge) *;
* - Achtung: der INNER Join "geht schief" wegen many-to-many! *;
data LINKSRECHTS_MERGE;
  merge LINKS(in=l) 
        RECHTS(in=r);
  by k;
  if l and r;
run;
proc print noobs; run;

* „SQL-Joinen“ mit proc SQL *;
* - korrekter INNER Join per SQL mit allen 2*2=4 Sätzen für k=3 *;
proc SQL;
  create table LINKSRECHTS_SQLJoin as
    select LINKS.*, RECHTS.vr from 
      LINKS
      inner join 
      RECHTS
    on LINKS.k = RECHTS.k;
quit;
proc print noobs; run;