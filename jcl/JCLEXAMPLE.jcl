//JCLEXAMPLE JOB (ACCT),'RUN COBOL PROGRAM',CLASS=A,MSGCLASS=X
//*
//* Code smell: hardcoded dataset names without proper validation
//* Code smell: no error handling for missing datasets
//*
//STEP1    EXEC PGM=COBB,REGION=0M
//*
//* DD statements for input/output
//*
//SYSIN    DD DSN=USER.COBOL.INPUT,DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//*
//* Code smell: hardcoded file paths
//*
数据集 (Dataset) definitions for COBOL program
//STDIN    DD DSN=USER.DATA.FILE1,DISP=SHR
//STDOUT   DD DSN=USER.OUTPUT.FILE1,
//            DISP=(NEW,CATLG,DELETE),
//            SPACE=(TRK,(10,5)),
//            DCB=(RECFM=FB,LRECL=80,BLKSIZE=8000)
//*
//* Code smell: inline program parameters without validation
//*
//PARM     DD *
INPUT FILE: USER.DATA.FILE1
OUTPUT FILE: USER.OUTPUT.FILE1
MODE: BATCH
/*