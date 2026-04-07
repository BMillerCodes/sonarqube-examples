//COMPILE  JOB (DEV),'COMPILE COBOL',CLASS=5,MSGCLASS=H
//*
//* JCL for compiling COBOL program
//* Code smell: no validation of compiler return codes
//*
//CLEANUP  EXEC PGM=IEFBR14
//DD1      DD DSN=&&LOADSET,DISP=(MOD,DELETE,DELETE),
//            SPACE=(TRK,1)
//*
//* Code smell: hardcoded program names
//*
//COMPILE  EXEC PGM=IGYCRCTL,REGION=8M
//*
//SYSIN    DD DSN=USER.SOURCE.COBOL(PROG1),DISP=SHR
//*
//* Code smell: no error handling for compilation failures
//*
//SYSLIB   DD DSN=USER.COPYBOOK,DISP=SHR
//         DD DSN=SQLCA,DISP=SHR
//*
//SYSPRINT DD SYSOUT=*
//SYSUT1   DD SPACE=(CYL,(5,5)),UNIT=SYSDA
//SYSUT2   DD SPACE=(CYL,(5,5)),UNIT=SYSDA
//SYSUT3   DD SPACE=(CYL,(5,5)),UNIT=SYSDA
//SYSUT4   DD SPACE=(CYL,(5,5)),UNIT=SYSDA
//SYSUT5   DD SPACE=(CYL,(5,5)),UNIT=SYSDA
//SYSUT6   DD SPACE=(CYL,(5,5)),UNIT=SYSDA
//SYSUT7   DD SPACE=(CYL,(5,5)),UNIT=SYSDA
//*
//LKED    EXEC PGM=HEWL,REGION=4M,COND=(0,LT)
//*
//SYSLIN   DD DSN=&&LOADSET,DISP=(OLD,DELETE)
//         DD DDNAME=SYSIN
//*
//SYSLIB   DD DSN=CEE.SCEELKED,DISP=SHR
//*
//SYSPRINT DD SYSOUT=*
//SYSUT1   DD SPACE=(CYL,(5,2)),UNIT=SYSDA
//*
//* Code smell: hardcoded load library
//*
//SYSLMOD  DD DSN=USER.LOADLIB(PROG1),
//            DISP=(NEW,CATLG,DELETE),
//            SPACE=(TRK,(5,5,10)),
//            DCB=(RECFM=U,BLKSIZE=32760)
//