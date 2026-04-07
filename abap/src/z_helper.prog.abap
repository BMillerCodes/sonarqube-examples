*&---------------------------------------------------------------------*
*& Include Z_HELPER
*& Helper functions for ABAP example
*&---------------------------------------------------------------------*

CLASS lcl_helper DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: multiply IMPORTING a TYPE i b TYPE i RETURNING VALUE(r) TYPE i,
                   is_valid IMPORTING value TYPE i RETURNING VALUE(r) TYPE abap_bool,
                   format_message IMPORTING message TYPE string
                                  RETURNING VALUE(r) TYPE string.
ENDCLASS.

CLASS lcl_helper IMPLEMENTATION.
  METHOD multiply.
    r = a * b.
  ENDMETHOD.

  METHOD is_valid.
    r = COND #( WHEN value >= 0 AND value <= 100 THEN abap_true ELSE abap_false ).
  ENDMETHOD.

  METHOD format_message.
    r = '[INFO] ' && message.
  ENDMETHOD.
ENDCLASS.