CLASS zexcel_attach DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
    METHODS send_email.

  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES: BEGIN OF ty_employee,
             emp_id       TYPE pernr_d,
             emp_name     TYPE text100,
             manager_id   TYPE pernr_d,
             manager_name TYPE text100,
             emp_position TYPE text100,
           END OF ty_employee,
           tt_employee TYPE TABLE OF ty_employee WITH EMPTY KEY.

    TYPES: BEGIN OF ty_column,
             column_name TYPE c LENGTH 30,
             column_text TYPE c LENGTH 40,
           END OF ty_column,
           tt_columns TYPE TABLE OF ty_column WITH EMPTY KEY.
    CLASS-DATA mt_emloyees TYPE tt_employee.
    CLASS-DATA mt_columns  TYPE tt_columns.

    METHODS load_data.
    METHODS convert_itab_to_xls_xstring RETURNING VALUE(rv_xstring) TYPE xstring.

ENDCLASS.



CLASS ZEXCEL_ATTACH IMPLEMENTATION.


  METHOD convert_itab_to_xls_xstring.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
  ENDMETHOD.


  METHOD load_data.
    mt_emloyees = VALUE #( ( emp_id = '1' emp_name = 'Name 1' emp_position = 'DEV_1' manager_id = '1' manager_name = 'Manager 1' )
                             ( emp_id = '2' emp_name = 'Name 2' emp_position = 'DEV_2' manager_id = '2' manager_name = 'Manager 2' ) ).

    mt_columns = VALUE #( ( column_name = 'EMP_ID'       column_text = 'Employee ID' )
                          ( column_name = 'EMP_NAME'     column_text = 'Employee Name' )
                          ( column_name = 'EMP_POSITION' column_text = 'Employee Position' )
                          ( column_name = 'MANAGER_ID'   column_text = 'Manager ID' )
                          ( column_name = 'MANAGER_NAME' column_text = 'Manager Name' ) ).
  ENDMETHOD.


  METHOD send_email.
  ENDMETHOD.
ENDCLASS.
