CLASS zcl_sd_bil_data_transfer DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_sd_bil_data_transfer .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SD_BIL_DATA_TRANSFER IMPLEMENTATION.


  METHOD if_sd_bil_data_transfer~change_data.

    MOVE-CORRESPONDING bil_doc TO bil_doc_res.
    MOVE-CORRESPONDING bil_doc_item TO bil_doc_item_res.

    bil_doc_res-billingdocumentdate = '2024-08-01'.
    bil_doc_res-assignmentreference = 'test assign ref'.
    bil_doc_res-yy1_bankname_bdh = '01'.
*
*    GET TIME STAMP FIELD DATA(ts).
*    CONVERT TIME STAMP ts TIME ZONE 'UTC' INTO DATE bil_doc_res-billingdocumentdate.

*   Example field manipulation of billing document item:
*   Here we're setting the item text of the billing document item.
    bil_doc_item_res-documentitemtext = 'This is an example1 text'.

*   Example field manipulation of split-relevant (header) fields of the billing document:
*   Here we're clearing the region field from the billing document.
    bil_doc_clear_flds_f_split-regionistobedeleted = abap_true.

*   importing
*      !BIL_DOC type IF_SD_BIL_DATA_TRANSFER_TYPES=>TY_S_BIL_DOC_ATTR
*    changing
*      !BIL_DOC_RES type IF_SD_BIL_DATA_TRANSFER_TYPES=>TY_S_BIL_DOC_RES
*      !BIL_DOC_CLEAR_FLDS_F_SPLIT type IF_SD_BIL_DATA_TRANSFER_TYPES=>TY_S_BIL_DOC_CLE

  ENDMETHOD.
ENDCLASS.
