* AtE "Tabellen verbinden" *;
* 33_Self_Join.sas / SAS.GERMHN, 22.2.24 *;

data Mitarbeiter;
  set SASHELP.CLASS;
  keep Name PN PN_Manager;
  PN = _n_;
  PN_Manager = 5-ceil(_n_/7);
  if PN = PN_Manager then PN_Manager=.;
run;

* proc SQL *;
proc SQL;
  create table Mitarbeiter_Manager_Name as
    select L.*, R.Name as Manager_Name
    from Mitarbeiter as L
         left join 
         Mitarbeiter as R
    on L.PN_Manager = R.PN
    order by PN;
quit;
proc print noobs; run;

* Data Step Merge *;
proc Sort data=Mitarbeiter out=Mitarbeiter_by_PN_Manager;
  by PN_Manager;
run;
data Mitarbeiter_Manager_Name;
  merge Mitarbeiter_by_PN_Manager(in=l)
        Mitarbeiter(in=r keep=PN Name rename=(PN=PN_Manager Name=Manager_Name));
  by PN_Manager;
  if l;
run;
proc Sort data=Mitarbeiter_Manager_Name;
  by PN;
run;
proc print noobs; run;
  


