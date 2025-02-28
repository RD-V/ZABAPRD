CLASS zcl_apoc_add_email_recipients DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_apoc_add_email_recipients .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_APOC_ADD_EMAIL_RECIPIENTS IMPLEMENTATION.


  METHOD if_apoc_add_email_recipients~add_email_recipients.

    DATA(bill_doc_id_runtime) = outputcontrolapplicationobject. "billing document ID

    "select created user from billing document CDS view
    SELECT SINGLE createdbyuser FROM i_billingdocumentbasic WITH PRIVILEGED ACCESS
       WHERE billingdocument = @bill_doc_id_runtime
         INTO @DATA(user_id).

    "select email address of created user
    SELECT SINGLE defaultemailaddress FROM i_businessuservh WITH PRIVILEGED ACCESS
       WHERE userid =  @user_id                      "'CB9980000020'
           INTO @DATA(email_address).

    DATA(email_id) = email_address.

    "Add Additional Email Recipients for Billing Documents by Using Custom Logic
    DATA: ls_additional_email_recipient LIKE LINE OF additionalemailrecipients.
**
    ls_additional_email_recipient-outputrequestitememailrole = 'TO'.
    ls_additional_email_recipient-outputrequestitememailaddress = 'example_to@sap.com'.
    APPEND ls_additional_email_recipient TO additionalemailrecipients.

    ls_additional_email_recipient-outputrequestitememailrole = 'CC'.
    ls_additional_email_recipient-outputrequestitememailaddress = email_id.    "'example_cc@sap.com'.
    APPEND ls_additional_email_recipient TO additionalemailrecipients.
*
*    ls_additional_email_recipient-outputrequestitememailrole = 'BCC'.
*    ls_additional_email_recipient-outputrequestitememailaddress = 'example_bcc@sap.com'.
*    APPEND ls_additional_email_recipient TO additionalemailrecipients.


  ENDMETHOD.
ENDCLASS.
