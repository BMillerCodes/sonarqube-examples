//PROCESSJ JOB (ACCT),'BATCH PROCESSING',CLASS=B,MSGCLASS=Y
//*
//* Batch job for data processing
//* Code smell: hardcoded account codes
//*
//***********************************************************************
//* STEP 1: SORT INPUT DATA
//***********************************************************************
//SORTSTEP  EXEC PGM=SORT,REGION=4M
//*
//SORTIN    DD DSN=USER.INPUT.DATA,
//            DISP=SHR
//*
//SORTOUT   DD DSN=USER.SORTED.DATA,
//            DISP=(NEW,CATLG,DELETE),
//            SPACE=(CYL,(5,2)),
//            DCB=(RECFM=FB,LRECL=100)
//*
//SYSOUT    DD SYSOUT=*
//*
//* Code smell: sort parameters without validation
//*
//SORTWK01  DD UNIT=SYSDA,SPACE=(CYL,(2,2))
//SORTWK02  DD UNIT=SYSDA,SPACE=(CYL,(2,2))
//SORTWK03  DD UNIT=SYSDA,SPACE=(CYL,(2,2))
//*
//* Code smell: inline control statements
//*
//SYSIN     DD *
  SORT FIELDS=(1,10,CH,A)
  RECORD TYPE=F,LENGTH=100
/*
