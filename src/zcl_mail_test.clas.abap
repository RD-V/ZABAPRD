CLASS zcl_mail_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_MAIL_TEST IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  "Getting a handler for the currently active tenant
DATA(ten) = xco_cp=>current->tenant( ).
DATA(id) = ten->get_id( ).


"Getting the UI URL of the currently active tenant
DATA(ui_url) = ten->get_url( xco_cp_tenant=>url_type->ui ).
DATA(host) = ui_url->get_host( ).
DATA(port) = ui_url->get_port( ).
data(t) = '2'.


TYPES: BEGIN OF ty_person,
         name TYPE string,
         age  TYPE i,
       END OF ty_person.

DATA: lt_persons TYPE TABLE OF ty_person,
      lv_json    TYPE string.

APPEND VALUE #( name = 'John Doe' age = 30 ) TO lt_persons.
APPEND VALUE #( name = 'Jane Doe' age = 25 ) TO lt_persons.

"lv_json = /ui2/cl_json=>serialize( data = lt_persons pretty_name = /ui2/cl_json=>pretty_mode-condensed ).


  DATA(json_body) = |{ `"svGrpCmpServiceRQ"` }|.

    DATA(json_body1) = |{ `"svGrpCmpServiceRQ":{"group":{"en":"Group 1","ar":"Group1","code":"GRP01"},"company":[{"en":"ABC Company","ar":"ABC Company","code":"A01","address":"No: 10, Address line","erpService":"ERP Service","callBackPaymentStatusUr` &&
`l":"Enter_Callback_Payment_Status_URL","callBackPaymentChargeUrl":" Enter_Callback_Payment_Charge_URL"}]}` }|.

 " DATA(test) = JSON.ST.

*    DATA(config_instance) = cl_bcs_mail_system_config=>create_instance( ).
*
*    DATA recipient_domains TYPE cl_bcs_mail_system_config=>tyt_recipient_domains.
*    DATA sender_domains TYPE cl_bcs_mail_system_config=>tyt_sender_domains.
*    recipient_domains = VALUE #( ( 'noblq.com' ) ( '@noblq.com' ) ).
*    sender_domains = VALUE #( ( 'noblq.com' ) ( 'erplogic.com' ) ).
*
*    "Add allowed domains
*    TRY.
*        config_instance->set_address_check_active( abap_true ).
*        config_instance->add_allowed_recipient_domains( recipient_domains ).
*        config_instance->add_allowed_sender_domains( sender_domains ).
*        config_instance->modify_default_sender_address( iv_default_address = 'renugadevi.s@noblq.com'
*                                                    iv_default_name = 'Renuga' ).
*      CATCH cx_bcs_mail_config INTO DATA(write_error).
*        "handle exception
*    ENDTRY.
*
*    "Read allowed domains
*    DATA(allowed_recipient_domains) = config_instance->read_allowed_recipient_domains( ).
*    DATA(allowed_sender_domains) = config_instance->read_allowed_sender_domains( ).
*    config_instance->read_default_sender_address(
*      IMPORTING
*        ev_default_sender_address = DATA(default_sender_address)
*        ev_default_sender_name = DATA(default_sender_name) ).

    "Delete allowed domains
*    TRY.
*        config_instance->delete_allowed_rec_domains( allowed_recipient_domains ).
*        config_instance->delete_allowed_sender_domains( allowed_sender_domains ).
*        config_instance->delete_default_sender_addr( 'renugadevi.s@noblq.com' ).
*      CATCH cx_bcs_mail_config INTO DATA(deletion_error).
*        "handle exception
*    ENDTRY.

****************************************************
*    TRY.
*        DATA(lo_mail_address) = cl_mail_address=>create_instance( iv_address_string = 'renugadevi.s@noblq.com' ).
*      CATCH cx_bcs_mail INTO DATA(lx_err).
*        "exception handling
*    ENDTRY.
*
*    DATA(lv_address_valid) = lo_mail_address->validate( ).
****************************************************

    TRY.
        DATA(lo_mail) = cl_bcs_mail_message=>create_instance( ).
        DATA: attachment  TYPE REF TO cl_bcs_mail_bodypart.

       " lo_mail->set_sender( 'renugadevi.s@noblq.com' ).
        lo_mail->add_recipient( 'renugadevi.s@noblq.com' ).

        lo_mail->set_subject( 'Test Mail_2' ).

        lo_mail->set_main( cl_bcs_mail_textpart=>create_instance(
            iv_content      = '<h1>Hello</h1><p>Hello world send from RAP!</p>'
            iv_content_type = 'text/html' ) ).

*            lo_mail->set_main( CL_BCS_MAIL_BINARYPART=>create_instance(
*            iv_content      = ''
*            iv_content_type = 'l' ) ).

        " lo_mail->add_attachment( attachment ).


        lo_mail->add_attachment( cl_bcs_mail_textpart=>create_instance(
       iv_content      = 'This is a text attachment'
       iv_content_type = 'text/plain'
       iv_filename     = 'Text_Attachment.txt'
     ) ).
        "importing io_attachment  type ref to cl_bcs_mail_bodypart
        lo_mail->send( IMPORTING et_status = DATA(lt_status) ).
        " lo_mail->send( ).
        COMMIT WORK.

        out->write( lt_status ).


      CATCH cx_bcs_mail INTO DATA(lo_err).
        out->write( lo_err->get_longtext( ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
