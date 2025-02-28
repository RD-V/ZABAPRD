CLASS zcl_api_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_API_TEST IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    """"""""""SALES ORDER - PARTNER""""""""""""""""""""""""""
    TRY.
        "create http destination by url; API endpoint for API sandbox
        DATA(lo_http_destination) =
            cl_http_destination_provider=>create_by_url( 'https://my404095.s4hana.cloud.sap:443/sap/opu/odata4/sap/api_salesorder/srvd_a2x/sap/salesorder/0001/SalesOrder/40/_Partner?filter=PartnerFunction eq ''ES''' ).
        "alternatively create HTTP destination via destination service
        "cl_http_destination_provider=>create_by_cloud_destination( i_name = '<...>'
        "                            i_service_instance_name = '<...>' )
        "SAP Help: https://help.sap.com/viewer/65de2977205c403bbc107264b8eccf4b/Cloud/en-US/f871712b816943b0ab5e04b60799e518.html

        "create HTTP client by destination
        DATA(lo_web_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination ) .

        "adding headers
        DATA(lo_web_http_request) = lo_web_http_client->get_http_request( ).

        lo_web_http_request->set_header_fields( VALUE #(
       (  name = 'Authorization' value = 'Basic WklOVF9VU0VSOldlbGNvbWUyMDI0QFNBUEJUUDRVUw==' )
       (  name = 'DataServiceVersion' value = '2.0' )
       (  name = 'Accept' value = 'application/json' )
        ) ).

*        lo_web_http_request->set_header_fields( VALUE #(
*        (  name = 'config_authType' value = 'Basic' )
*        (  name = 'config_packageName' value = 'SAPS4HANACloud' )
*        (  name = 'config_actualUrl' value = 'https://my404095.s4hana.cloud.sap:443/sap/opu/odata4/sap/api_salesorder/srvd_a2x/sap/salesorder/0001' )
*        (  name = 'config_urlPattern' value = 'https://{host}:{port}/sap/opu/odata4/sap/api_salesorder/srvd_a2x/sap/salesorder/0001' )
*        (  name = 'config_apiName' value = 'CE_SALESORDER_0001' )
*        (  name = 'DataServiceVersion' value = '2.0' )
*        (  name = 'Accept' value = 'application/json' )
*         ) ).

        "set request method and execute request
        DATA(lo_web_http_response) = lo_web_http_client->execute( if_web_http_client=>get ).
        DATA(lv_response) = lo_web_http_response->get_text( ).

      CATCH cx_http_dest_provider_error cx_web_http_client_error cx_web_message_error.
        "error handling
    ENDTRY.

    DATA(test) = '2'.
    "uncomment the following line for console output; prerequisite: code snippet is implementation of if_oo_adt_classrun~main
    out->write( |response:  { lv_response }| ).

    """""""""""""""""""""


***************PRODUCT************************************************************************
*    TRY.
*        "create http destination by url; API endpoint for API sandbox
*        DATA(lo_http_destination) =
*             cl_http_destination_provider=>create_by_url( 'https://my404095.s4hana.cloud.sap:443/sap/opu/odata4/sap/api_product/srvd_a2x/sap/product/0002/Product?$top=50' ).
*        "alternatively create HTTP destination via destination service
*        "cl_http_destination_provider=>create_by_cloud_destination( i_name = '<...>'
*        "                            i_service_instance_name = '<...>' )
*        "SAP Help: https://help.sap.com/viewer/65de2977205c403bbc107264b8eccf4b/Cloud/en-US/f871712b816943b0ab5e04b60799e518.html
*
*        "create HTTP client by destination
*        DATA(lo_web_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination ) .
*
*        "adding headers
*        DATA(lo_web_http_request) = lo_web_http_client->get_http_request( ).
*        lo_web_http_request->set_header_fields( VALUE #(
*        (  name = 'Authorization' value = 'Basic WklOVF9VU0VSOldlbGNvbWUyMDI0QFNBUEJUUDRVUw==' )
*        (  name = 'DataServiceVersion' value = '2.0' )
*        (  name = 'Accept' value = 'application/json' )
*         ) ).
*
*        "set request method and execute request
*        DATA(lo_web_http_response) = lo_web_http_client->execute( if_web_http_client=>get ).
*        DATA(lv_response) = lo_web_http_response->get_text( ).
*
*      CATCH cx_http_dest_provider_error cx_web_http_client_error cx_web_message_error.
*        "error handling
*    ENDTRY.
*
*    "uncomment the following line for console output; prerequisite: code snippet is implementation of if_oo_adt_classrun~main
*    out->write( |response:  { lv_response }| ).

*****************PRODUCT************************************************************************

  ENDMETHOD.
ENDCLASS.
