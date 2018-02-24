proc import datafile="C:\Users\lanxin\Desktop\2018Spring\S&DS563\Chronic_Kidney_Disease\CKD_numeric.csv" 
out=CKD_numeric dbms=csv replace; 
getnames=yes; 
run; 

data CKD_numeric;set CKD_numeric;
drop var1;
run;

PROC CLUSTER DATA=CKD_numeric METHOD=compact RMSSTD RSQ OUTTREE=TREE; 
id id; RUN;


*number of clusters;
filename foo3 url "http://reuningscherer.net/stat660/sas/cluster.sas.txt";
%include foo3;
%CLUSTPLOT(TREE); RUN;

*3 clusters??;
