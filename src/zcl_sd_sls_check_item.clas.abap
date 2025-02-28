CLASS zcl_sd_sls_check_item DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_badi_interface .
    INTERFACES if_sd_sls_check_item .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SD_SLS_CHECK_ITEM IMPLEMENTATION.


  METHOD if_sd_sls_check_item~check_fields.

    DATA(cm) = salesdocumentitem-materialbycustomer.

    IF cm IS NOT INITIAL.

      "query purchase order item account assignment table
      SELECT SINGLE * FROM i_purordaccountassignmentapi01 WITH PRIVILEGED ACCESS
      WHERE salesorder = @salesdocumentitem-salesdocument
             AND salesorderitem = @salesdocumentitem-salesdocumentitem
              INTO @DATA(lt_poitem_acct_assign).

      IF lt_poitem_acct_assign IS NOT INITIAL.

        DATA(po) = lt_poitem_acct_assign-purchaseorder.
        DATA(po_item) = lt_poitem_acct_assign-purchaseorderitem.

        "query purchase order item
        SELECT SINGLE * FROM i_purchaseorderitemapi01 WITH PRIVILEGED ACCESS
        WHERE purchaseorder = @po AND purchaseorderitem = @po_item
                INTO @DATA(lt_poitem).

        IF lt_poitem IS NOT INITIAL.
          "update purchase order item
          lt_poitem-yy1_customermaterialnu_pdi = cm.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
