CLASS zcl_bs_mail_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    data test type ref to zprodtype.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BS_MAIL_TEST IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    DATA: lv_date      TYPE d VALUE '20230331',  " Example: October 14, 2024
          lv_year      TYPE i,
          lv_month     TYPE i,
          lv_last_day  TYPE d,
          lv_month_str TYPE string.

    lv_year  = lv_date(4).      " Extract year
    lv_month = lv_date+4(2).    " Extract month

    " Increment the month to get the first day of the next month
    lv_month = lv_month + 1.

    " Handle year transitions (e.g., from December to January)
    IF lv_month > 12.
      lv_month = 1.
      lv_year  = lv_year + 1.
    ENDIF.

    " Format the month with leading zeroes (pad to 2 digits)
    lv_month_str = COND string( WHEN lv_month < 10 THEN |0{ lv_month }| ELSE |{ lv_month }| ).

    " Set the first day of the next month
    lv_last_day = |{ lv_year }{ lv_month_str }01|.

    " Subtract 1 day to get the last day of the current month
    lv_last_day = lv_last_day - 1.

    out->write( lv_last_day ).

*    " DATA(lv_system_techname)  = cl_abap_context_info=>get_system_url(  ). "   get_user_technical_name( ).
*    DATA(mandt) = sy-mandt.
*    DATA(host) = sy-host.
*    DATA(systemid) = sy-sysid.
*
*    out->write( mandt ).
*    out->write( host ).
*    out->write( systemid ).
**
**    data(h) = sy-host.
**     out->write( h ).
*
*    DATA: lv_env_type TYPE string.

*    SELECT SINGLE env_type INTO @lv_env_type FROM zenv_config_table WHERE client = @sy-mandt.
*
*    CASE lv_env_type.
*      WHEN 'DEV'.
*        " Handle development environment
*      WHEN 'TST'.
*        " Handle test environment
*      WHEN 'PRD'.
*        " Handle production environment
*      WHEN OTHERS.
*        " Handle unknown environment
*    ENDCASE.


*    TRY.
*        DATA(lo_mail) = cl_bcs_mail_message=>create_instance( ).
*
**        lo_mail->set_sender( 'renugadevi.s@noblq.com' ).
*        lo_mail->add_recipient( 'pallavarajan.p@noblq.com' ).
*
*        lo_mail->set_subject( 'Test Mail' ).
*
*        lo_mail->set_main( cl_bcs_mail_textpart=>create_instance(
*            iv_content      = '<h1>Hello</h1><p>Hello world send from RAP!</p>'
*            iv_content_type = 'text/html' ) ).
*
*        lo_mail->send( IMPORTING et_status = DATA(lt_status) ).
*
*        out->write( lt_status ).
*
*      CATCH cx_bcs_mail INTO DATA(lo_err).
*        out->write( lo_err->get_longtext( ) ).
*    ENDTRY.
  ENDMETHOD.
ENDCLASS.
