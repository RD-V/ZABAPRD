CLASS zcl_api_consumption DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
    METHODS: get_product_data IMPORTING iv_product_id      TYPE string
                              RETURNING VALUE(rt_response) TYPE string
                              RAISING
                                        cx_http_dest_provider_error
                                        cx_web_http_client_error.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_API_CONSUMPTION IMPLEMENTATION.


  METHOD get_product_data.
    DATA: lo_http_client           TYPE REF TO if_web_http_client,
          lo_web_http_get_response TYPE REF TO if_web_http_response,
          lo_web_http_get_request  TYPE REF TO if_web_http_request,
          lv_host                  TYPE string VALUE 'my404095-api.s4hana.cloud.sap',
          lv_port                  TYPE string VALUE '443',
          lv_path                  TYPE string,
          lv_url                   TYPE string,
          lv_auth                  TYPE string,
          lt_headers               TYPE tihttpnvp,
          lv_response              TYPE string,
          lv_response_code         TYPE string,
          lv_upload_bool           TYPE abap_bool,
          lv_product_id            TYPE string.

    " 1. Construct API URL
    lv_product_id = iv_product_id.
    lv_path = |/sap/opu/odata4/sap/api_product/srvd_a2x/sap/product/0002/Product|.
    " lv_url  = |https://{ lv_host }:{ lv_port }{ lv_path }?$top=50&$filter=Product eq '{ lv_product_id }'|.
    lv_url  = |https://{ lv_host }{ lv_path }?$top=50&$filter=Product eq '{ lv_product_id }'|.

    " 2. Create HTTP Client
    DATA(lo_destination) = cl_http_destination_provider=>create_by_url( lv_url ).
    lo_http_client = cl_web_http_client_manager=>create_by_http_destination( i_destination = lo_destination ).


    " Set the HTTP method and URL
    lo_web_http_get_request = lo_http_client->get_http_request( ).

    " 3. Set Headers (e.g., API Key, Content-Type)
    lo_web_http_get_request->set_header_fields( VALUE #(
        ( name = 'Content-Type' value = 'application/json' )
        ( name = 'Authorization' value = 'Basic WklOVF9VU0VSOldlbGNvbWUyMDI0QFNBUEJUUDRVUw==' )
*        ( name = 'x-csrf-token' value = 'fetch' )
*        ( name = 'Cookie' value = 'fetch' )
    ) ).

    " 4. Send GET Request
    TRY.
        lo_web_http_get_response = lo_http_client->execute( i_method = if_web_http_client=>get ).
      CATCH cx_web_http_client_error.
        "handle exception
    ENDTRY.

    " 5. Process Response
    lv_response = lo_web_http_get_response->get_text( ).
   " DATA(lv_csrf_token) = lo_web_http_get_response->get_header_field( i_name = 'x-csrf-token' ).

    rt_response = lv_response.

    lv_response_code = lo_web_http_get_response->get_status( )-code.

    IF lv_response_code = 200.
      lv_upload_bool = abap_false.
    ELSE.
      lv_upload_bool = abap_false.
    ENDIF.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

    TRY.
        DATA(resp) = me->get_product_data( iv_product_id = 'E006' ).
      CATCH cx_http_dest_provider_error cx_web_http_client_error.
        "handle exception

        out->write( 'response: ' && resp ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
