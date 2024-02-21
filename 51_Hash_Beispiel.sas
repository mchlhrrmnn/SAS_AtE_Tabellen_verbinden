* AtE "Tabellen verbinden" *;
* 51_Hash_Beispiel.sas / SAS.GERMHN, 22.2.24 *;

* durchschnittlicher Autopreis je Hersteller *;
proc SQL;
  create table CARS_MEAN_INVOICE as
    select distinct Make, round(mean(Invoice),1) as Mean_Invoice_by_Make
    from SASHELP.CARS
    group by Make;
quit;

* "Join" mit allen Autopreisen per Hash-Objekt *;
data CARS_WITH_MEAN_INVOICE; 
  if _n_ = 1 then do; * Hash initialisieren bevor der erste Satz gelesen wird *;
    if 0 then set CARS_MEAN_INVOICE; 
    dcl hash h(dataset:'WORK.CARS_MEAN_INVOICE'); * kleine rechte Tabelle *; 
    h.defineKey('Make'); * Key festlegen *;  
    h.defineData('Mean_Invoice_by_Make'); * Datenwert festlegen *; 
    h.defineDone();
  end; 
  set SASHELP.CARS; * große linke Tabelle *;  
  rc=h.find(); * Join über "Make" * ;
run;
proc print noobs; run;