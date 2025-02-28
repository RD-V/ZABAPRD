CLASS zsv_customtable_crud DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZSV_CUSTOMTABLE_CRUD IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.



    "METHOD process_request.
*    DATA: lv_product               TYPE string,
*          lv_response              TYPE string,
*          lv_json                  TYPE string,
*          lv_csrf_token            TYPE string,
*          lo_request               TYPE REF TO if_web_http_request,
*          lo_web_http_client       TYPE REF TO if_web_http_client,
*          lo_web_http_get_response TYPE REF TO if_web_http_response.
*
*    "lo_response TYPE string.
*    TRY.
**        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
**                                comm_scenario  = 'ZSV_COMM_CSD'
**                                service_id     = 'ZUI_SV_CMPGRP_O4' "'ZUI_SV_CMPGRP_O4_0001_G4BA'
**                              ).
*        DATA: lv_url TYPE string VALUE 'https://my404095-api.s4hana.cloud.sap/sap/opu/odata4/sap/zui_sv_cmpgrp_o4/srvd/sap/zui_sv_cmpgrp_o4/0001/'.
*        DATA(lo_destination) = cl_http_destination_provider=>create_by_url( lv_url ).
*
*      CATCH cx_http_dest_provider_error.
*        "handle exception
*    ENDTRY.
*
*    TRY.
*        DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = lo_destination ).
*      CATCH cx_web_http_client_error.
*    ENDTRY.
*
*    lo_request = lo_web_http_client->get_http_request( ).
*
*    lo_request->set_header_fields( VALUE #(
*        ( name = 'Content-Type' value = 'application/json' )
*        ( name = 'Authorization' value = 'Basic WklOVF9VU0VSOkxEeFFoZnMkRktBU0NoY214YXhiallFU1FoSmtqR0hTSFJOM2VZZFo=' )
*        ( name = 'x-csrf-token' value = 'Fetch' ) ) ).
*
*    TRY.
*        lo_web_http_get_response = lo_web_http_client->execute( i_method = if_web_http_client=>get ).
*        lv_csrf_token = lo_web_http_get_response->get_header_field( i_name = 'x-csrf-token' ).
*
*        DATA(token) = lv_csrf_token.
*        out->write( | token: { lv_csrf_token } | ).
*
*      CATCH cx_web_http_client_error.
*        "handle exception
*    ENDTRY.

*    lv_json = `'{ "Id": "4","CompanyId": "C04", "CompanyName": "Master Holdings" }'`.
*    lo_request->set_text( lv_json ).
*
*    "lv_response = lo_web_http_client->execute( if_web_http_client=>post ).
*
*    lv_response = lo_web_http_get_response->get_text( ).
*    DATA(test) = lv_response.
*    DATA(test2) = '2'.
*    out->write( | uuid: { lv_response } | ).

*
    "METHOD process_request.
    DATA: lv_product                TYPE string,
          lv_get_response           TYPE string,
          lv_post_response          TYPE string,
          lv_cookie_string          TYPE string,
          lt_cookie_list            TYPE STANDARD TABLE OF string,
          lv_cookie_str             TYPE string,
          lt_cookies_bucket         TYPE if_web_http_request=>cookies,
          lv_cookie_part            TYPE if_web_http_request=>cookie,
          lo_get_request            TYPE REF TO if_web_http_request,
          lo_web_http_get_response  TYPE REF TO if_web_http_response,
          lo_post_request           TYPE REF TO if_web_http_request,
          lo_web_http_post_response TYPE REF TO if_web_http_response,
          updated_lv_cookie_string TYPE string.


********************************  GET CSRF TOKEN ****************************************************************

    "lo_response TYPE string.
    TRY.

*DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement( comm_scenario  = 'ZSV_COMM_CSD' ).


*        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
*                                comm_scenario  = 'ZSV_COMM_CSD'
*                              service_id     = 'ZUI_SV_CMPGRP_O4' "'ZUI_SV_CMPGRP_O4_0001_G4BA'
*                              ).
        DATA: lv_url TYPE string VALUE 'https://my404095-api.s4hana.cloud.sap/sap/opu/odata4/sap/zui_sv_cmpgrp_o4/srvd/sap/zui_sv_cmpgrp_o4/0001/'.
        DATA(lo_destination) = cl_http_destination_provider=>create_by_url( lv_url ).

*            DATA(lo_destination) = cl_http_destination_provider=>create_by_url( |https://my404095-api.s4hana.cloud.sap/sap/opu/odata4/sap/zui_sv_cmpgrp_o4/srvd/sap/zui_sv_cmpgrp_o4/0001/ZC_SV_CMPGRP| ).

*        lo_destination = cl_http_destination_provider=>create_by_url( lv_url ).


      CATCH cx_http_dest_provider_error.
        "handle exception
    ENDTRY.

    TRY.
        DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = lo_destination ).
      CATCH cx_web_http_client_error.
    ENDTRY.

   lo_get_request = lo_http_client->get_http_request( ).

*     lo_get_request = lo_http_client->get_http_request( )->set_authorization_basic(
*                                                                                  i_username = 'ZINT_USER'
*                                                                                    i_password = 'LDxQhfs$FKASChcmxaxbjYESQhJkjGHSHRN3eYdZ'
*                                                                                     i_username = 'rudhra.udayakumar@erplogic.com'
*                                                                                    i_password = 'Nobl@2025*!'
*                                                                                 ).


    lo_get_request->set_header_fields( VALUE #(
        ( name = 'Content-Type' value = 'application/json' )
        ( name = 'Authorization' value = 'Basic WklOVF9VU0VSOkxEeFFoZnMkRktBU0NoY214YXhiallFU1FoSmtqR0hTSFJOM2VZZFo=' )
        ( name = 'x-csrf-token' value = 'fetch' )
        ( name = 'Cookie' value = 'fetch' )
    ) ).

    TRY.
        lo_web_http_get_response = lo_http_client->execute( i_method = if_web_http_client=>get ).
      CATCH cx_web_http_client_error.
        "handle exception
    ENDTRY.

    lv_get_response = lo_web_http_get_response->get_text( ).
    DATA(lv_csrf_token) = lo_web_http_get_response->get_header_field( i_name = 'x-csrf-token' ).
    DATA(lv_cookies) = lo_web_http_get_response->get_header_field( i_name = 'set-cookie' ).
    lt_cookies_bucket = lo_web_http_get_response->get_cookies( ).
    DATA(lv_get_response_code) = lo_web_http_get_response->get_status( )-code.
    DATA(token) = lv_csrf_token.




    """"""""""""""""""""""""""""""""""""""""""'
    " Iterate over the cookies and add them to lt_cookies
*    LOOP AT lt_cookies_bucket INTO DATA(lt_cookie).

* LOOP AT lt_cookies_bucket INTO lv_cookie_part.
*        lv_cookie_string =  lv_cookie_part-value.
*        DATA(cookie_part_value) = lv_cookie_part-value.
*        DATA(cookie_formatted_value) = lt_cookie_list.
*        DATA(test) = lv_get_response.
*        DATA(test2) = '2'.
*
*        if updated_lv_cookie_string IS  INITIAL.
*
*                    updated_lv_cookie_string =  lv_cookie_string && ';' .
*        ELSE.
*                updated_lv_cookie_string = updated_lv_cookie_string && lv_cookie_string.
*
*        out->write( | uuid: { lv_get_response } | ).
*
*      APPEND lv_cookie_string TO lt_cookie_list.
*        ENDIF.
*    ENDLOOP.

    LOOP AT lt_cookies_bucket INTO lv_cookie_part.
*      IF lv_cookie_part-name EQ 'sap-XSRF_XA4_080'.

IF lv_cookie_string IS INITIAL.

        lv_cookie_string = lv_cookie_part-name && '=' && lv_cookie_part-value.

        updated_lv_cookie_string =  lv_cookie_string && ';' .


*          lv_cookie_string = lv_cookie_part-name && '=' && lv_cookie_part-value && ';'.



*          lv_cookie_string = lv_cookie_part-name && '=' && lv_cookie_part-value && ';Path= ' &&  lv_cookie_part-path && ';Secure= '
*          &&  lv_cookie_part-secure && ';Domain= ' &&  lv_cookie_part-domain.

ELSE.

            lv_cookie_string = lv_cookie_part-name && '=' && lv_cookie_part-value.

            updated_lv_cookie_string = updated_lv_cookie_string && lv_cookie_string.

        DATA(cookie_part_value) = lv_cookie_part-value.
        DATA(cookie_formatted_value) = lt_cookie_list.
        DATA(test) = lv_get_response.
        DATA(test2) = '2'.
        out->write( | test: { lv_cookie_string } | ).
ENDIF.

      APPEND lv_cookie_string TO lt_cookie_list.

    ENDLOOP.

*    ENDLOOP.

    """ """"""""""""""""""""""""""""""""""""""""""'
*    DATA(cookie_part_value1) = cookie_part_value.
*    DATA(substrings2) = substring_after( val = cookie_part_value sub = token ).
*    DATA(cookie_formatted_value1) = cookie_formatted_value.
*    DATA(test1) = lv_get_response.

**********************************  POST ****************************************************************
    "lo_response TYPE string.
    TRY.
*        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
*                                comm_scenario  = 'ZSV_COMM_CSD'
*                                service_id     = 'ZUI_SV_CMPGRP_O4' "'ZUI_SV_CMPGRP_O4_0001_G4BA'
*                              ).
*        DATA: lv_post_url TYPE string VALUE 'https://my404095-api.s4hana.cloud.sap/sap/opu/odata4/sap/zui_sv_cmpgrp_o4/srvd/sap/zui_sv_cmpgrp_o4/0001/ZC_SV_CMPGRP'.

*         lo_destination = cl_http_destination_provider=>create_by_url( |https://my404095-api.s4hana.cloud.sap/sap/opu/odata4/sap/zui_sv_cmpgrp_o4/srvd/sap/zui_sv_cmpgrp_o4/0001/ZC_SV_CMPGRP| ).


*        DATA(lo_post_destination) = cl_http_destination_provider=>create_by_url( lv_post_url ).

      CATCH cx_http_dest_provider_error.
        "handle exception
    ENDTRY.

    TRY.
        DATA(lo_post_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = lo_destination ).

*         lo_post_http_client->get_http_request( )->set_authorization_basic(
*                                                                                    i_username = 'ZINT_USER'
*                                                                                    i_password = 'LDxQhfs$FKASChcmxaxbjYESQhJkjGHSHRN3eYdZ'
*                                                                                    i_username = 'rudhra.udayakumar@erplogic.com'
*                                                                                    i_password = 'Nobl@2025*!'
*                                                                                 ).

      CATCH cx_web_http_client_error.
    ENDTRY.

    lo_post_request = lo_post_http_client->get_http_request( ).
    lo_post_http_client->accept_cookies( i_allow = '1' ).

    lo_post_request->set_header_field( i_name = 'x-csrf-token' i_value = token ).




    TRY.
        "  lo_post_http_client->set_csrf_token( ).
      CATCH cx_web_http_client_error.
        "handle exception
    ENDTRY.

    lo_post_request->set_header_fields( VALUE #(
        ( name = 'Content-Type' value = 'application/json' )
       ( name = 'Authorization' value = 'Basic WklOVF9VU0VSOkxEeFFoZnMkRktBU0NoY214YXhiallFU1FoSmtqR0hTSFJOM2VZZFo=' )
        ( name = 'x-csrf-token' value = token )
*      ( name = 'Cookie' value = updated_lv_cookie_string )
    ) ).

    DATA(post_body) = `{ "Id": "6", "CompanyId": "C06", "CompanyName": "Master Holdings 6" }`.
    lo_post_request->set_text( post_body ).
    lo_post_request->set_cookie( i_name = 'Cookie' i_value = updated_lv_cookie_string ).


*    lo_post_request->set_cookie( i_name = 'sap-XSRF_XA4_080' i_value = lv_cookies ).
*    lo_post_request->set_cookie( i_name = 'sap-XSRF_XA4_080' i_value = cookie_part_value1 ).

*     newly added code on 21092024 for trying to CSRF ERROR
*    LOOP AT lt_cookies_bucket ASSIGNING FIELD-SYMBOL(<cookie>).
*
*            lo_post_request->set_cookie( i_name = <cookie>-name
*                       i_path = <cookie>-path
*                       i_value = <cookie>-value
*                       i_domain = <cookie>-domain
*                       i_expires = <cookie>-expires
*                       i_secure = <cookie>-secure  ).
*
*          ENDLOOP.



    TRY.
        lo_web_http_post_response = lo_http_client->execute( i_method = if_web_http_client=>post ).
      CATCH cx_web_http_client_error.
        "handle exception
    ENDTRY.

    lv_post_response = lo_web_http_post_response->get_text( ).

    DATA(lv_post_response_code) = lo_web_http_get_response->get_status( )-code.


    DATA(create_response) = lv_post_response.

        out->write( | uuid: { lv_post_response } | ).

    lo_post_http_client->close( ).

    DATA(test3) = '2'.

  ENDMETHOD.
ENDCLASS.
