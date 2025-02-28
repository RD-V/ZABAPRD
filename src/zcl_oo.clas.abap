CLASS zcl_oo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
    DATA instance_value TYPE i.
    CLASS-DATA static_value TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_OO IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    "data declarations
    DATA assign_value TYPE REF TO zcl_oo.
    DATA assign_values TYPE TABLE OF REF TO zcl_oo.

    "instantiate class
    assign_value = NEW #( ).

    "assign value
    assign_value->static_value   = '2'.
    assign_value->instance_value = '3'.

    APPEND assign_value TO assign_values.

    DATA(test) = assign_values.

  ENDMETHOD.
ENDCLASS.
