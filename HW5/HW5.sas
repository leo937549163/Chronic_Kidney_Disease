proc import datafile="C:\Users\lanxin\Documents\GitHub\Chronic_Kidney_Disease\HW5\CKDCC.csv"
     out=CKDCC
     dbms=csv
     replace;
     getnames=yes;
run;

proc glm data=CKDCC;
class sg rbc;
model bgr sc=sg rbc sg*rbc /
solution;
manova h=sg rbc sg*rbc;
run;

proc glm data=CKDCC;
class sg rbc;
model bgr sc hemo=sg rbc sg*rbc /
solution;
manova h=sg rbc sg*rbc;
run;

data CKDCC; set CKDCC; 
trtcombine=trim(trim(sg) || trim(rbc)); run;

proc sort data=CKDCC; 
by trtcombine; 

ods rtf file="C:\Users\lanxin\Documents\GitHub\Chronic_Kidney_Disease\HW5\contrast.rtf";
proc glm data=CKDCC; 
class trtcombine; 
model bgr sc=trtcombine; 
*contrast 'Red blood cell: abnormal vs normal' trtcombine 1 -1 1 -1 1 -1 1 -1 0;
*contrast 'Specific Gravity: 1.005 vs 1.010' trtcombine 1 1 -1 -1 0 0 0 0 0; 
*contrast 'Specific Gravity: 1.005 vs 1.015' trtcombine 1 1 0 0 -1 -1 0 0 0; 
*contrast 'Specific Gravity: 1.005 vs 1.020' trtcombine 1 1 0 0 0 0 -1 -1 0; 
*contrast 'Specific Gravity: 1.005 vs 1.025' trtcombine 1 1 0 0 0 0 0 0 -2; 
*contrast 'Specific Gravity: 1.010 vs 1.015' trtcombine 0 0 1 1 -1 -1 0 0 0; 
*contrast 'Specific Gravity: 1.010 vs 1.020' trtcombine 0 0 1 1 0 0 -1 -1 0; 
*contrast 'Specific Gravity: 1.010 vs 1.025' trtcombine 0 0 1 1 0 0 0 0 -2; 
*contrast 'Specific Gravity: 1.015 vs 1.020' trtcombine 0 0 0 0 1 1 -1 -1 0; 
*contrast 'Specific Gravity: 1.015 vs 1.025' trtcombine 0 0 0 0 1 1 0 0 -2; 
*contrast 'Specific Gravity: 1.020 vs 1.025' trtcombine 0 0 0 0 0 0 1 1 -2; 
contrast 'Specific Gravity linear effect' trtcombine 1 1 0.5 0.5 0 0 -0.5 -0.5 -2; 
contrast 'Specific Gravity: 1.010 vs the other ' trtcombine -1 -1 3.5 3.5 -1 -1 -1 -1 -1; 
*manova h=trtcombine; 
run;
ods rtf close;
