CLASS zcl_fkk_event_2645 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_fkk_sample_2645_badi .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FKK_EVENT_2645 IMPLEMENTATION.


  METHOD if_fkk_sample_2645_badi~execute.

  DATA(invcgunit) = cainvcgunit.
  DATA(docdate)  = cainvcgunit-cainvcgdoc-cainvcgdocheader-documentdate.
*    IMPORTING
*      !cainvcgunit       TYPE fkkinv_unit_public_data_gfn
*    CHANGING
*      !cadocheader       TYPE fkkko_gfn_t
*      !cadocumentbpitems TYPE fkkop_gfn_t
*      !cadocumentglitems TYPE fkkopk_gfn_t
*      !cainvcgdocument   TYPE fkkinvdoc_gfn
  ENDMETHOD.
ENDCLASS.
