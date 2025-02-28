CLASS z_new_job_class_ec DEFINITION
PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_apj_dt_exec_object.
    INTERFACES if_apj_rt_exec_object.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z_NEW_JOB_CLASS_EC IMPLEMENTATION.


  METHOD if_apj_dt_exec_object~get_parameters.
* You can Insert code here for getting Job parameters
  ENDMETHOD.


  METHOD if_apj_rt_exec_object~execute.
    DATA(l_log) = cl_bali_log=>create_with_header( cl_bali_header_setter=>create( object =
             'Z_APP_LOG_OBJ1' subobject = 'ZSUBOBJECT1' ) ).

    "Add a message as item to the log
    DATA(l_message) = cl_bali_message_setter=>create( severity =
                      if_bali_constants=>c_severity_error
                                                      id = 'PO'
                                                      number = '000' ).
    l_log->add_item( item = l_message ).

    "Add a second message, this time from system fields SY-MSGID, ...
    "MESSAGE ID 'ZTEST' TYPE 'S' NUMBER '058' INTO DATA(l_text).

    l_log->add_item( item = cl_bali_message_setter=>create_from_sy( ) ).

    "Add a free text to the log

    DATA(l_free_text) = cl_bali_free_text_setter=>create( severity =
                        if_bali_constants=>c_severity_error
                        text = 'Some Error Text' ).

    l_log->add_item( item = l_free_text ).

    " Add an exception to the log
    DATA: i TYPE i.
    TRY.
        i = 1 / 0.
      CATCH cx_sy_zerodivide INTO DATA(l_ref).
    ENDTRY.

    DATA(l_exception) = cl_bali_exception_setter=>create( severity =
                               if_bali_constants=>c_severity_error
                               exception = l_ref ).
    l_log->add_item( item = l_exception ).

    "Save the log into the database
    cl_bali_log_db=>get_instance( )->save_log( log = l_log assign_to_current_appl_job = abap_true ).
    COMMIT WORK.

    "CATCH cx_bali_runtime INTO DATA(l_runtime_exception).
    "ENDTRY.
  ENDMETHOD.
ENDCLASS.
