DATA NHTS;
  Infile "C:\Users\EmilyHong\Google 雲端硬碟\graduate\106A course\多變量分析\Homework 5\SCALENHTS.prn" ;
  Input ID CNTTDHH DRVRCNT HHFAMINC1 HHSIZE HHVEHCNT WRKCOUNT;
  Cards;
Run;
/*抓取30個樣本*/
Data NHTS1;
 Set NHTS;
 If ID >719;
 Run;

PROC PRINT;
/* Hierarchical Cluster Analysis */
/* outtree:分出來的結果 */
/*  METHOD= AVERAGE, COMPLETE, WARD, CENTROID */
/* RMSSTD= Root-mean-square standard deviation*/
/* RSQ = R-square */
/* Pseudo = Pseudo F &  Pseudo t**2 */
PROC CLUSTER DATA=NHTS1 METHOD=WARD NONORM RMSSTD RSQ PSEUDO OUTTREE=T1;
 VAR CNTTDHH DRVRCNT HHFAMINC1 HHSIZE HHVEHCNT WRKCOUNT;
RUN;

PROC TREE DATA=T1 HORIZONTAL OUT=OUTPUT;
  COPY CNTTDHH DRVRCNT HHFAMINC1 HHSIZE HHVEHCNT WRKCOUNT;
RUN;

/* Nonhierarchical Cluster Analysis k means seudo F值*/
/* MAXCLUSTERS=3 (分三群))MAXITER=10(做十次運算) */
PROC FASTCLUS DATA=NHTS LIST DISTANCE MAXCLUSTERS=3 MAXITER=10 OUT=T2;
  VAR CNTTDHH DRVRCNT HHFAMINC1 HHSIZE HHVEHCNT WRKCOUNT;
RUN;
PROC SORT;
  BY cluster;
RUN;
PROC PRINT;
  BY cluster;
  VAR id cluster distance CNTTDHH DRVRCNT HHFAMINC1 HHSIZE HHVEHCNT WRKCOUNT;
RUN;
