CLASS zttrx_ws DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.

    "  METHODS process_request.

ENDCLASS.



CLASS ZTTRX_WS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "METHOD process_request.
    DATA: lv_product               TYPE string,
          lv_response              TYPE string,
          lo_web_http_get_response TYPE REF TO if_web_http_response.



    "lo_response TYPE string.
    TRY.
        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                comm_scenario  = 'ZTTRX_CS'
                                service_id     = 'ZTTRX_OBS_REST'
                              ).
      CATCH cx_http_dest_provider_error.
        "handle exception
    ENDTRY.

    TRY.
        DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = lo_destination ).
      CATCH cx_web_http_client_error.
    ENDTRY.

    DATA(lo_request) = lo_http_client->get_http_request( ).

    lo_request->set_header_fields( VALUE #(
        ( name = 'Content-Type' value = 'application/json' )
        ( name = 'Authorization' value = 'd6ba0701728d66a22ffa8c0c4251db00:A:qV6NZvB5JnIgRM0d1sJ1jW9LSRQRNjqRdhNbfh3qAnOBzERyXpiHpNSTIayuC4PfHwdKfXdXq7F0tp' )
    ) ).

    TRY.
        "lo_response = lo_http_client->execute( i_method = if_web_http_client=>get ).
        "DATA(lo_response) = lo_http_client->execute( i_method = if_web_http_client=>get ).
        lo_web_http_get_response = lo_http_client->execute( i_method = if_web_http_client=>get ).
      CATCH cx_web_http_client_error.
        "handle exception
    ENDTRY.

    lv_response = lo_web_http_get_response->get_text( ).
    DATA(test) = lv_response.

    " Create an ABAP structure to contain the data from the API
    TYPES: BEGIN OF ts_descriptions,
             name              TYPE string,
             product_long_name TYPE string,
           END OF ts_descriptions.

    TYPES: BEGIN OF ts_identifiers,
             value TYPE string,
           END OF ts_identifiers.

    TYPES: BEGIN OF ts_specialized_properties,
             key   TYPE string,
             value TYPE string,
           END OF ts_specialized_properties.

*    TYPES: BEGIN OF ts_element,
*             specialized_properties TYPE ts_properties,
*           END OF ts_element.

    TYPES: BEGIN OF ts_root,
             status                 TYPE string,
             uuid                   TYPE string,
             descriptions           TYPE STANDARD TABLE OF ts_descriptions WITH EMPTY KEY,
             identifiers            TYPE STANDARD TABLE OF ts_identifiers WITH EMPTY KEY,
             specialized_properties TYPE STANDARD TABLE OF ts_specialized_properties WITH EMPTY KEY,
           END OF ts_root.

    DATA ls_root TYPE ts_root.

*call XCO library
    xco_cp_json=>data->from_string( lv_response )->apply( VALUE #(
 ( xco_cp_json=>transformation->pascal_case_to_underscore )
  ( xco_cp_json=>transformation->boolean_to_abap_bool )
                                       "  ( xco_cp_json=>transformation->camel_case_to_underscore )
) )->write_to( REF #( ls_root ) ).

    DATA(status_root) = ls_root-status. "can be assigned to a variable
    out->write( | status: { ls_root-status } | ).
    out->write( | uuid: { ls_root-uuid } | ).

    LOOP AT ls_root-descriptions ASSIGNING FIELD-SYMBOL(<abc>).
      out->write( | looping { sy-tabix }: { <abc>-name } | ).
      DATA(name_descriptions) = <abc>-name.
    ENDLOOP.

    LOOP AT ls_root-specialized_properties ASSIGNING FIELD-SYMBOL(<specialized_properties>).
*      out->write( | looping { sy-tabix }: { <xyz>-specialized_properties-key } | ).
*      out->write( | looping { sy-tabix }: { <xyz>-specialized_properties-value } | ).
    ENDLOOP.

    "
    TRY.        " catch any error
      CATCH cx_root INTO DATA(lx_root).
        out->write( lx_root->get_text( ) ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
