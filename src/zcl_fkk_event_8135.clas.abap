CLASS zcl_fkk_event_8135 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_fkk_sample_8135_badi .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FKK_EVENT_8135 IMPLEMENTATION.


  METHOD if_fkk_sample_8135_badi~execute.

    "importing cabillgunit
    DATA(docid)  = cabillgunit-cabillgdoc-cabillgdocheader-cabillgdocument.
    DATA(basedate) = cabillgunit-cabillgdoc-cabillgdocheader-cabillgbasedate.
    DATA(dateCreatedDate) = cabillgunit-cabillgdoc-cabillgdocheader-data-cabillgdoccreationdate.

    DATA(test) = '2'.

    "Changing cabillgdocument
    cabillgdocument-cabillgdocheader-cabillgbasedate = '2024-08-01'.
  ENDMETHOD.
ENDCLASS.
