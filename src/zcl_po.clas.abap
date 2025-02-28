CLASS zcl_po DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PO IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    CONSTANTS max_count TYPE i VALUE 5.

    DATA numbers TYPE TABLE OF i.

    DO max_count TIMES.


      CASE sy-index.
        WHEN 1.
          APPEND 0 TO numbers.
        WHEN 2.
          APPEND 1 TO numbers.
           WHEN OTHERS.
          APPEND numbers[  sy-index - 2 ]
               + numbers[  sy-index - 1 ]
              TO numbers.
      ENDCASE.
    ENDDO.

    DATA(counter) = 0.
    LOOP AT numbers INTO DATA(number).

      counter = counter + 1.

*      APPEND |{ counter WIDTH = 4 }: { number WIDTH = 10 ALIGN = RIGHT }|
*          TO if_oo_ad.
*



    ENDLOOP.

  out->write(
         data   = out
         name   = |The first { max_count } Fibonacci Numbers|
                ) .
*    SELECT * FROM i_purchaseorderitemapi01
*       WHERE purchaseorder = '4500000001' AND purchaseorderitem = '00010'
*          INTO TABLE @DATA(lt_zpoitem).
*
**    SELECT * FROM i_purchaseorderpricingelement
**WHERE purchaseorder = '4500000001' "AND PurchaseOrder- = '00010'
**   INTO TABLE @DATA(lt_zpoitem_price_element).
*
*    ""I_PURCHASEORDERTP_2 "_PurOrdPricingElement->create
*
*    "READ ENTITIES OF
*
*    MODIFY ENTITIES OF i_purchaseordertp_2 PRIVILEGED
*           ENTITY purchaseorderitem
*          CREATE BY \_purordpricingelement SET FIELDS WITH VALUE #(
*           ( %key-purchaseorder    = '4500000001'   "lr_key->%tky
*             %key-purchaseorderitem = '00010'
*             %target =   VALUE #( (
*               %cid                = 'CIDPOFREIGHT'
*               conditiontype       = 'FVA1'
*               conditionrateamount = '4'
*               conditioncurrency   = 'USD' ) ) ) )
*           FAILED DATA(ls_modify_failed)
*           REPORTED DATA(ls_modify_reported).
*
*    COMMIT ENTITIES.
*
*    DATA(failed)   = ls_modify_failed.
*    DATA(reported) = ls_modify_reported.
*
*    READ ENTITIES OF i_purchaseordertp_2  PRIVILEGED
*         ENTITY purchaseorderitem
*            "ALL FIELDS WITH
*            "CORRESPONDING #( lt_zpoitem )
*              ALL FIELDS WITH VALUE #(  ( %key-purchaseorder = '4500000001' %key-purchaseorderitem = '00010' ) )
*                "ALL FIELDS WITH VALUE #(  ( %key-itemuuid = keys[ 1 ]-%key-itemuuid ) )
*          RESULT DATA(lt_po).
*
*    DATA(test) = '2'.
*    out->write( 'exit' ).

  ENDMETHOD.
ENDCLASS.
