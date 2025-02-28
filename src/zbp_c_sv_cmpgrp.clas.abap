class ZBP_C_SV_CMPGRP definition
   PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    PROTECTED SECTION.
  PRIVATE SECTION.
        TYPES tt_ZC_SV_CMPGRP TYPE STANDARD TABLE OF z_inbound_api=>tys_zc_sv_cmpgrptype WITH EMPTY KEY.
    METHODS create_inbound_api RETURNING VALUE(rt_table) TYPE tt_ZC_SV_CMPGRP
                                      RAISING
                                        cx_http_dest_provider_error.
ENDCLASS.



CLASS ZBP_C_SV_CMPGRP IMPLEMENTATION.


            METHOD create_inbound_api.


DATA:
  ls_business_data TYPE z_inbound_api=>tys_zc_sv_cmpgrptype,
  lo_http_client   TYPE REF TO if_web_http_client,
  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,

  get_lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
  get_lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
  get_lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst,
  get_lo_destination   TYPE REF TO if_http_destination,
  get_lo_http_client   TYPE REF TO if_web_http_client,

  lo_request       TYPE REF TO /iwbep/if_cp_request_create,
  lo_destination   TYPE REF TO if_http_destination,
  lo_response      TYPE REF TO /iwbep/if_cp_response_create,

 lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
 lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
        lo_filter_node_root   TYPE REF TO /iwbep/if_cp_filter_node,
        lt_range_ID TYPE RANGE OF z_inbound_api=>tys_zc_sv_cmpgrptype-id.

DATA: lt_response_headers TYPE tihttpnvp,
      lv_csrf_token       TYPE string.




*  get_lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v4_remote_proxy(
*       EXPORTING
*          is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
*                                              proxy_model_id      = 'Z_INBOUND_API'
*                                              proxy_model_version = '0001' )
*         io_http_client             = lo_http_client
*         iv_relative_service_root   = '/sap/opu/odata4/sap/zui_sv_cmpgrp_o4/srvd/sap/zui_sv_cmpgrp_o4/0001/ZC_SV_CMPGRP' ).
*
*     ASSERT lo_http_client IS BOUND.


TRY.
" Create http client
get_lo_destination  = cl_http_destination_provider=>create_by_comm_arrangement(
                                             comm_scenario  = 'ZSV_COMM_CSD'
*                                             comm_system_id = '0M4P870'
*                                             service_id     = 'ZUI_SV_CMPGRP_O4_0001_G4BA'
                                             ).
CATCH cx_http_dest_provider_error.
  "handle exception
ENDTRY.

        DATA: lv_url TYPE string VALUE 'https://my404095-api.s4hana.cloud.sap'.


*              get_lo_destination = cl_http_destination_provider=>create_by_url( lv_url ).

              get_lo_http_client = cl_web_http_client_manager=>create_by_http_destination( get_lo_destination ).


        get_lo_http_client->get_http_request( )->set_header_fields( VALUE #(
                ( name = 'Content-Type' value = 'application/json' )
                ( name = 'Authorization' value = 'Basic WklOVF9VU0VSOkxEeFFoZnMkRktBU0NoY214YXhiallFU1FoSmtqR0hTSFJOM2VZZFo=' )
                ( name = 'x-csrf-token' value = 'fetch' )
                ( name = 'Cookie' value = 'fetch' ) ) ).

lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v4_remote_proxy(
  EXPORTING
     is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                         proxy_model_id      = 'Z_INBOUND_API'
                                         proxy_model_version = '0001' )
    io_http_client             = get_lo_http_client
    iv_relative_service_root   = '/sap/opu/odata4/sap/zui_sv_cmpgrp_o4/srvd/sap/zui_sv_cmpgrp_o4/0001/' ).

ASSERT get_lo_http_client IS BOUND.



" Navigate to the resource and create a request for the create operation
 get_lo_request = lo_client_proxy->create_resource_for_entity_set( 'ZC_SV_CMPGRP' )->create_request_for_read( ).

       " Create the filter tree
      lo_filter_factory = get_lo_request->create_filter_factory( ).
*
*lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'ID'
*                                                        it_range             = lt_range_ID ).
*lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'COMPANY_ID'
*                                                        it_range             = lt_range_COMPANY_ID ).

*lo_filter_node_root = lo_filter_node_1->and( lo_filter_node_2 ).
*lo_request->set_filter( lo_filter_node_root ).

get_lo_request->set_top( 100 )->set_skip( 0 ).

" Set the business data for the created entity
*lo_request->set_business_data( ls_business_data ).


" Execute the request
*lo_response = lo_request->execute( ).
get_lo_response = get_lo_request->execute( ).

" Fetch the response headers
lt_response_headers = get_lo_http_client->get_http_request( )->get_header_fields( ).

" Search for the CSRF token in the headers
LOOP AT lt_response_headers INTO DATA(ls_header).
  IF ls_header-name = 'x-csrf-token'.
    lv_csrf_token = ls_header-value.
    EXIT.
  ENDIF.
ENDLOOP.




lo_request = lo_client_proxy->create_resource_for_entity_set( 'ZC_SV_CMPGRP' )->create_request_for_create( ).


              lo_http_client = cl_web_http_client_manager=>create_by_http_destination( get_lo_destination ).


 lo_http_client->get_http_request( )->set_header_fields( VALUE #(
                ( name = 'Content-Type' value = 'application/json' )
                ( name = 'Authorization' value = 'Basic WklOVF9VU0VSOkxEeFFoZnMkRktBU0NoY214YXhiallFU1FoSmtqR0hTSFJOM2VZZFo=' )
                ( name = 'x-csrf-token' value = lv_csrf_token ) ) ).

* Prepare business data
ls_business_data = VALUE #(
          id                          = '17'
          company_id                  = 'AUDI'
          company_name                = 'AU'
*          local_created_by            = 'LocalCreatedBy'
*          local_created_at            = 20170101123000
*          local_last_changed_by       = 'LocalLastChangedBy'
*          local_last_changed_at       = 20170101123000
*          last_changed_at             = 20170101123000
*          has_draft_entity            = abap_true
*          draft_entity_creation_date  = 20170101123000
*          draft_entity_last_change_d  = 20170101123000
*          has_active_entity           = abap_true
*          is_active_entity            = abap_true
 ).



" Set the business data for the created entity
lo_request->set_business_data( ls_business_data ).

" Execute the request
lo_response = lo_request->execute( ).


TRY.
    lo_response->get_business_data( IMPORTING es_business_data = rt_table )." Get the after image
*lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
" Handle remote Exception
" It contains details about the problems of your http(s) connection


CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
" Handle Exception

CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
" Handle Exception
RAISE SHORTDUMP lx_web_http_client_error.

    ENDTRY.

       ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
*    DATA business_data TYPE TABLE OF z_inbound_api=>tys_zc_sv_cmpgrptype.


        out->write( create_inbound_api( ) ).

    TRY.

      CATCH cx_root INTO DATA(exception).
        out->write( cl_message_helper=>get_latest_t100_exception( exception )->if_message~get_text( ) ).


    ENDTRY.
  ENDMETHOD.
ENDCLASS.
