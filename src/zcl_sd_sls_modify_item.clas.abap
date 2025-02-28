CLASS zcl_sd_sls_modify_item DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_sd_sls_modify_item .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SD_SLS_MODIFY_ITEM IMPLEMENTATION.


  METHOD if_sd_sls_modify_item~modify_fields.

     DATA(cm) = salesdocumentitem-materialbycustomer.
     DATA update_tab type TABLE FOR UPDATE I_PurchaseOrderItemTP_2.

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

*    READ ENTITIES OF I_PurchaseOrderItemTP_2
*    ENTITY ZSupplier
*    FIELDS ( SupplierId SupplierName ) WITH VALUE #( ( %key-SupplierId = '1005' ) )
*    RESULT DATA(result)
*    FAILED DATA(failed)
*    REPORTED DATA(reported).

    "out->write( result ).
   " LOOP AT result into DATA(temp1).
    "update_tab = CORRESPONDING #( temp1 ).
*    update_tab- lt_poitem-YY1_CustomerMaterialNu_PDI
*    update_tab - lt_poitem - YY1_CustomerMaterialNu_PDI = cm.
*    update_record-%control-SupplierName = if_abap_behv=>mk-on.
*    APPEND update_record to update_tab.
*    "ENDLOOP.
*
*   " MODIFY ENTITIES OF ZI_SUPPLIER
*    ENTITY ZSupplier
*    CREATE FROM create_tab
*    "UPDATE FROM update_tab
*    MAPPED DATA(mapped_data)
*    FAILED DATA(failed_data)
*    REPORTED DATA(reported_data).
*    COMMIT ENTITIES.
*

        lt_poitem-NetAmount = 100.
        DATA(podemo) = lt_poitem-NetAmount.
*          lt_poitem-yy1_customermaterialnu_pdi = cm.
*
*                  DATA(podemo) = lt_poitem-yy1_customermaterialnu_pdi.

        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
