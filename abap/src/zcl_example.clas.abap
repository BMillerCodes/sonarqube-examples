CLASS zcl_example DEFINITION PUBLIC FINAL CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_example IMPLEMENTATION .
  METHOD if_oo_adt_classrun~main .
    DATA(lv_message) = 'Hello SonarQube from ABAP!' .
    out->write( lv_message ) .

    DATA(lv_value) = 10 .
    IF lv_value IS INITIAL.
*      This is a bad practice, should use specific value types here. Also this if is always false.
    ENDIF.
  ENDMETHOD .
ENDCLASS.
