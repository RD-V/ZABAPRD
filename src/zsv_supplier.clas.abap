CLASS zsv_supplier DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

*    METHODS: generate_signature
*      IMPORTING
*        iv_json_body        TYPE string    " Incoming JSON string
*        iv_signature_key    TYPE string    " Signature key
*      RETURNING
*        VALUE(rv_signature) TYPE string. " Calculated SHA-256 hash.
*
 PROTECTED SECTION.
 PRIVATE SECTION.
*    METHODS: base64_encode
*      IMPORTING
*        iv_input         TYPE string
*      RETURNING
*        VALUE(rv_output) TYPE string.
ENDCLASS.



CLASS ZSV_SUPPLIER IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lv_encoded_json           TYPE string,
          lv_signature_data         TYPE string,
          lv_response               TYPE string,
          lo_http_client            TYPE REF TO if_web_http_client, " Use if_web_http_client
          lo_web_http_post_response TYPE REF TO if_web_http_response,
          lo_web_http_post_request  TYPE REF TO if_web_http_request,
          lv_response_code          TYPE string,
          lv_response_objid         TYPE string,
          lv_hash_value             TYPE string,
          lv_upload_bool            TYPE abap_bool,
          lt_concat                 TYPE string,
          lo_digest                 TYPE REF TO cl_abap_message_digest,
          lv_signature_data_xstring TYPE xstring,
          lv_url                    TYPE string VALUE 'https://servicesuat.onesingleview.com/v1/api/erp/svSupplierService',
          http_destination          TYPE REF TO if_http_destination.

    DATA: lv_json_body     TYPE string,
          lv_signature_key TYPE string,
          lv_json_compact  TYPE string,
          lv_pattern       TYPE string,
          lt_matches       TYPE match_result_tab,
          lv_signature     TYPE string.

    TYPES: BEGIN OF ty_paymentterms,
             name  TYPE string,
             value TYPE string,
           END OF ty_paymentterms.

    TYPES: BEGIN OF ty_methodofpayment,
             name  TYPE string,
             value TYPE string,
           END OF ty_methodofpayment.

    TYPES: BEGIN OF ty_supplier,
             user_name         TYPE string,
             name              TYPE string,
             category          TYPE string,
             supplier_contact  TYPE string,
             mobile            TYPE string,
             email             TYPE string,
             supplier_code     TYPE string,
             payment_terms     TYPE STANDARD TABLE OF ty_paymentterms WITH EMPTY KEY,
             method_of_payment TYPE STANDARD TABLE OF ty_methodofpayment WITH EMPTY KEY,
           END OF ty_supplier.

    TYPES: BEGIN OF ty_company,
             code     TYPE string,
             supplier TYPE STANDARD TABLE OF ty_supplier WITH EMPTY KEY,
           END OF ty_company.

    TYPES: BEGIN OF ty_svsupplierservicerq,
             "  abc   TYPE ty_abc,
             company TYPE STANDARD TABLE OF ty_company WITH EMPTY KEY,
           END OF ty_svsupplierservicerq.

    TYPES: BEGIN OF ty_request,
             sv_supplier_service_r_q TYPE ty_svsupplierservicerq,
           END OF ty_request.

    DATA: ls_request         TYPE ty_request,
          lv_json            TYPE string,
          ls_company         TYPE ty_company,
          lt_company         TYPE TABLE OF ty_company,
          ls_supplier        TYPE ty_supplier,
          lt_supplier        TYPE TABLE OF ty_supplier,
          ls_paymentterms    TYPE ty_paymentterms,
          lt_paymentterms    TYPE TABLE OF ty_paymentterms,
          ls_methodofpayment TYPE ty_methodofpayment,
          lt_methodofpayment TYPE TABLE OF ty_methodofpayment,
          lv_json_request    TYPE string,
          struc2json_xco     TYPE string.

    " Populate the structure with values

    ls_paymentterms-name = 'Pay Immediately w/o Deduction'.
    ls_paymentterms-value = '0001'.
    APPEND ls_paymentterms TO lt_paymentterms.


    ls_methodofpayment-name = 'Check'.
    ls_methodofpayment-value = 'C'.
    APPEND ls_methodofpayment TO lt_methodofpayment.

    ls_supplier-user_name = 'abduser'.
    ls_supplier-name = 'Supplier02'.
    ls_supplier-category = 'Private Company'.
    ls_supplier-supplier_contact = 'Ronald Williams'.
    ls_supplier-mobile = '918877667789'.
    ls_supplier-email = 'ronald@abc.com'.
    ls_supplier-supplier_code = '1000010'.
    ls_supplier-payment_terms = lt_paymentterms.
    ls_supplier-method_of_payment = lt_methodofpayment.
    APPEND ls_supplier TO lt_supplier.

    ls_company-code = '1710'.
    ls_company-supplier = lt_supplier.
    APPEND ls_company TO lt_company.

    ls_request-sv_supplier_service_r_q-company = lt_company.

    " Converting API Request to camelCase
    struc2json_xco = xco_cp_json=>data->from_abap( ls_request )->apply(
    VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case ) ) )->to_string(  ).

    out->write( 'json_xco_content: ' && struc2json_xco ).
    lv_signature_key = 'oNXNmdSYySBa04n3nG'. "resulted from company creation response {"svGrpCmpServiceRS":{"group":{"code":"GRP0S4","status":0,"message":"group added successfully"},"company":[{"code":"1710","clientId":"L1zYYZ7e86aR","clientSecret":"wtjE
                                                      "tIF0H1hK","signatureKey":"oNXNmdSYySBa04n3nG","status":0,"message":"company added successfully"}]}}

    " Create an instance of the class
     DATA(lo_signature_generator) = NEW z_singleview_generatesignature( ).

    " Call the generate_signature method
    lv_signature = lo_signature_generator->generate_signature(
                                                                iv_json_body      = struc2json_xco
                                                                iv_signature_key  = lv_signature_key
                                                              ).

    out->write( 'lv_signature: ' && lv_signature ).

     TRY.
        http_destination = cl_http_destination_provider=>create_by_url( lv_url ).
      CATCH cx_http_dest_provider_error.
        "handle exception
    ENDTRY.
    TRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( i_destination = http_destination ).
      CATCH cx_web_http_client_error.
        "handle exception
    ENDTRY.

    " Set the HTTP method and URL
    lo_web_http_post_request = lo_http_client->get_http_request( ).
    TRY.
        lo_web_http_post_response = lo_http_client->execute( if_web_http_client=>post ).
      CATCH cx_web_http_client_error.
        "handle exception
    ENDTRY.

    lo_web_http_post_request->set_header_fields( VALUE #( ( name = 'clientid' value = 'L1zYYZ7e86aR' ) ) ).
    lo_web_http_post_request->set_header_fields( VALUE #( ( name = 'clientsecret' value = 'wtjEtIF0H1hK' ) ) ).
    lo_web_http_post_request->set_header_fields( VALUE #( ( name = 'signature' value = lv_signature ) ) ).
    lo_web_http_post_request->set_content_type( content_type = 'application/json' ).

    lo_web_http_post_request->set_text( struc2json_xco ).
    TRY.
        lo_web_http_post_response = lo_http_client->execute( if_web_http_client=>post ).
      CATCH cx_web_http_client_error.
        "handle exception
    ENDTRY.


    lv_response = lo_web_http_post_response->get_text( ).

    lv_response_code = lo_web_http_post_response->get_status( )-code.
    out->write( 'response message:' && lv_response ).

    IF lv_response_code = 200.
      lv_upload_bool = abap_true.
*    success
    ELSE.
      lv_upload_bool = abap_false.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
