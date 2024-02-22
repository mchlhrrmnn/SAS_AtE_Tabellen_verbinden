* AtE "Tabellen verbinden" *;
* 91_Sonstige_Beispiele.sas / SAS.GERMHN, 22.2.24 *;

* equi join: *;
*  entspricht einem inner join *;
proc SQL;
  create table LINKS_RECHTS_SQLEquiJoin as
    select LINKS.*, RECHTS.VR, RECHTS.k as k_rechts from 
      LINKS, 
      RECHTS
    where LINKS.k = RECHTS.K;
quit;
proc print noobs; run;

* natural join: *;
*  impliziter join über gleichnamige Spalten *;
*  INNER (Default) oder FULL OUTER, je nach Angabe *;
proc SQL;
  create table LINKS_RECHTS_SQLNaturalJoin as
    select LINKS.*, RECHTS.VR, RECHTS.k as k_rechts from 
      LINKS
      natural full outer join
      RECHTS;
quit;
proc print noobs; run;

* cross join: *;
*  4*4 = 16 Sätze ... jeder mit jedem anderen kombiniert *;
proc SQL;
  create table LINKS_RECHTS_SQLCrossJoin as
    select LINKS.*, RECHTS.VR, RECHTS.k as k_rechts from 
      LINKS
      cross join
      RECHTS;
quit;
proc print noobs; run;
