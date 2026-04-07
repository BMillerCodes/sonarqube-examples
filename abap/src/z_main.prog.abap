*&---------------------------------------------------------------------*
*& Report Z_MAIN
*& SonarQube ABAP Example
*&---------------------------------------------------------------------*
REPORT z_main.

DATA: gv_result TYPE i,
      gv_error  TYPE string.

* Simple calculation class
CLASS lcl_calculator DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: add IMPORTING a TYPE i b TYPE i RETURNING VALUE(r) TYPE i,
                     divide IMPORTING a TYPE i b TYPE i RETURNING VALUE(r) TYPE i
                            RAISING cx_sy_zerodivide.
ENDCLASS.

CLASS lcl_calculator IMPLEMENTATION.
  METHOD add.
    r = a + b.
  ENDMETHOD.

  METHOD divide.
    IF b = 0.
      RAISE EXCEPTION TYPE cx_sy_zerodivide.
    ENDIF.
    r = a / b.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  WRITE: / 'Hello from ABAP SonarQube example!'.

  gv_result = lcl_calculator=>add( 5, 3 ).
  WRITE: / '5 + 3 = ', gv_result.

  TRY.
      gv_result = lcl_calculator=>divide( 10, 0 ).
    CATCH cx_sy_zerodivide INTO DATA(lo_error).
      WRITE: / 'Error: Division by zero'.
  ENDTRY.