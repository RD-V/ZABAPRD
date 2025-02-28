CLASS zcl_bap DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BAP IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    SELECT FROM zc_aconn1
         FIELDS '19891109'                           AS char_8,
         CAST( '18345' AS INT4 ) AS casting,
                CAST( '19891109' AS CHAR( 4 ) )      AS char_4,
                CAST( '19891109' AS NUMC( 8  ) )     AS numc_8,

                CAST( '19891109' AS INT4 )          AS integer,
                CAST( '19891109' AS DEC( 10, 0 ) )  AS dec_10_2,
                CAST( '19891109' AS FLTP )          AS fltp,

                CAST( '19891109' AS DATS )          AS date

           INTO TABLE @DATA(result).

    DATA(test) = '2'.

*    CASE test.
*      WHEN 'Mr.'  THEN 'Mister'
*      WHEN 'Mrs.' THEN 'Misses'
*      WHEN OTHERS
*    ENDCASE ##NO_TEXT.
*CASE test

    out->write(
      EXPORTING
        data   = result
        name   = 'RESULT'
    ).


*    CONSTANTS c_number TYPE i VALUE 1234.
*
*    SELECT FROM zc_aconn1
*     FIELDS 'Hello'  AS character,  " type c
*             1 AS integer1,         " type i
*            -1 AS integer2,         " type i
*            @c_number AS constant
*     INTO TABLE @DATA(result).


*
*    DATA timestamp1 TYPE utclong.
*    DATA timestamp2 TYPE utclong.
*    DATA difference TYPE decfloat34.
*    DATA date_user TYPE d.
*    DATA time_user TYPE t.
*
*    timestamp1 = utclong_current( ).
*    out->write( |Current UTC time { timestamp1 }| ).
*
*    timestamp2 = utclong_add( val = timestamp1 days = 7 ).
*    out->write( |Added 7 days to current UTC time { timestamp2 }| ).
*
*    difference = utclong_diff( high = timestamp2 low = timestamp1 ).
*    out->write( |Difference between timestamps in seconds: { difference }| ).
*
*    out->write( |Difference between timestamps in days: { difference / 3600 / 24 }| ).
*
*    CONVERT UTCLONG utclong_current( )
*       INTO DATE date_user
*            TIME time_user
*            TIME ZONE cl_abap_context_info=>get_user_time_zone( ).
*
*    out->write( |UTC timestamp split into date (type D) and time (type T )| ).
*    out->write( |according to the user's time zone (cl_abap_context_info=>get_user_time_zone( ) ).| ).
*    out->write( |{ date_user DATE = USER }, { time_user TIME = USER }| ).

*DATA var_date TYPE d.
*DATA var_int TYPE i.
*DATA var_string TYPE string.
*DATA var_n TYPE n LENGTH 4.
*
*var_date = cl_abap_context_info=>get_system_date( ).
*var_int = var_date.
*
*out->write( |Date as date| ).
*out->write( var_date ).
*out->write( |Date assigned to integer| ).
*out->write( var_int ).
*
*var_string = `R2D2`.
*var_n = var_string.
*
*out->write( |String| ).
*out->write( var_string ).
*out->write( |String assigned to type N| ).
*out->write( var_n ).

*
*    DATA long_char TYPE c LENGTH 10.
*    DATA short_char TYPE c LENGTH 5.
*
*
*    DATA result TYPE p LENGTH 3 DECIMALS 4.
*
*
*    long_char = 'ABCDEFGHIJ'.
*    short_char = long_char.
*
*
*    out->write( long_char ).
*    out->write( short_char ).
*
*
*    result = 1 / 8.
*    out->write( |1 / 8 is rounded to { result }| ).



*    DATA var_string TYPE string.
*    DATA var_int TYPE i.
*    DATA var_date TYPE d.
*    DATA var_pack TYPE p LENGTH 3 DECIMALS 2.
*
*
*    var_string = `12345`.
*    var_int = var_string.
*
*
*    out->write( 'Conversion successful' ).
*
*
*    var_string = `20230101`.
*    var_date = var_string.
*
*
*    out->write( |String value: { var_string }| ).
*    out->write( |Date: { var_date }| ).
*    out->write( |Date Value: { var_date DATE = USER }| ).

*  "Table type (local)
*    TYPES tt_strings TYPE TABLE OF string.
*    DATA texts1      TYPE tt_strings.
*
*    " Table type (global)
*    DATA texts2 TYPE  string_table.

** Declarations
***********************************************************************
*
*    CONSTANTS c_number TYPE i VALUE 3.
**    CONSTANTS c_number TYPE i VALUE 5.
**    CONSTANTS c_number TYPE i VALUE 10.
*
*    DATA number TYPE i.
*
** Example 1: DO ... ENDDO with TIMES
***********************************************************************
*
*    out->write(  `----------------------------------` ).
*    out->write(  `Example 1: DO ... ENDDO with TIMES` ).
*    out->write(  `----------------------------------` ).
*
*    DO c_number TIMES.
*      out->write(  `Hello World` ).
*    ENDDO.
*
** Example 2: DO ... ENDDO with Abort Condition
***********************************************************************
*
*    out->write(  `-------------------------------` ).
*    out->write(  `Example 2: With Abort Condition` ).
*    out->write(  `-------------------------------` ).
*
*    number = c_number * c_number.
*
*    " count backwards from number to c_number.
*    DO.
*
*      out->write( |{ sy-index }: Value of number: {  number }| ).
*      number = number - 1.
*
*      "abort condition
*      IF number <= c_number.
*        EXIT.
*      ENDIF.
*
*    ENDDO.
*

*
** Declarations
***********************************************************************
*    DATA result TYPE i.
*
*    DATA numbers TYPE TABLE OF i.
*
** Preparation
***********************************************************************
*
*    APPEND 123 TO numbers.
*
** Example 1: Conversion Error (no Number)
***********************************************************************
*
*    CONSTANTS c_text TYPE string VALUE 'ABC'.
**    CONSTANTS c_text TYPE string VALUE '123'.
*
*    out->write(  `---------------------------` ).
*    out->write(  `Example 1: Conversion Error` ).
*    out->write(  `---------------------------` ).
*
*    TRY.
*        result = c_text.
*        out->write( |Converted content is { result }|  ).
*      CATCH cx_sy_conversion_no_number.
*        out->write( |Error: { c_text } is not a number!| ).
*    ENDTRY.
*
** Example 2: Division by Zero
***********************************************************************
*
*    CONSTANTS c_number TYPE i VALUE 0.
**    CONSTANTS c_number TYPE i VALUE 7.
*
*    out->write(  `---------------------------` ).
*    out->write(  `Example 2: Division by Zero` ).
*    out->write(  `---------------------------` ).
*
*    TRY.
*        result = 100 / c_number.
*        out->write( |100 divided by { c_number } equals { result }| ).
*      CATCH cx_sy_zerodivide.
*        out->write(  `Error: Division by zero is not defined!` ).
*    ENDTRY.
*
** Example 3: Itab Error (Line Not Found)
***********************************************************************
*
*    CONSTANTS c_index TYPE i VALUE 2.
**    CONSTANTS c_index TYPE i VALUE 1.
*
*    out->write(  `-------------------------` ).
*    out->write(  `Example 3: Line Not Found` ).
*    out->write(  `-------------------------` ).
*
*    TRY.
*        result = numbers[ c_index ].
*        out->write( |Content of row { c_index } equals { result }| ).
*      CATCH cx_sy_itab_line_not_found.
*        out->write(  `Error: Itab has less than { c_index } rows!` ).
*    ENDTRY.
*
*
** Example 4: Combination of Different Exceptions
***********************************************************************
**    CONSTANTS c_char TYPE c LENGTH 1 VALUE 'X'.
**    CONSTANTS c_char TYPE c length 1 value '0'.
*   " CONSTANTS c_char TYPE c LENGTH 1 VALUE '1'.
*    CONSTANTS c_char TYPE c length 1 value '2'.
*
*    out->write(  `----------------------` ).
*    out->write(  `Example 4: Combination` ).
*    out->write(  `----------------------` ).
*
*    TRY.
*        result = numbers[ 2 / c_char ].
*        out->write( |Result: { result } | ).
*      CATCH cx_sy_zerodivide.
*        out->write( `Error: Division by zero is not defined`  ).
*      CATCH cx_sy_conversion_no_number.
*        out->write( |Error: { c_char } is not a number! | ).
*      CATCH cx_sy_itab_line_not_found.
*        out->write( |Error: Itab contains less than { 2 / c_char } rows| ).
*    ENDTRY.


*    DATA number1 TYPE i.
*    DATA number2 TYPE i.
*
*    DATA result TYPE p LENGTH 8 DECIMALS 2.
*
*    number1 = -8.
*    number2 =  3.
*
*    result = number1 / number2.
*
*    DATA(output) = |{ number1 } / { number2 } = { result }|.
*    out->write( result ).
*    out->write( output ).

*
** Declarations
***********************************************************************
*    TYPES t_amount TYPE  p LENGTH 8 DECIMALS 2.
*
*    DATA amount   TYPE t_amount VALUE '3.30'.
*    DATA amount1  TYPE t_amount VALUE '1.20'.
*    DATA amount2  TYPE t_amount VALUE '2.10'.
*
*    DATA the_date  TYPE d                     VALUE '19891109'.
*    DATA my_number TYPE p LENGTH 3 DECIMALS 2 VALUE '-273.15'.
*
*    DATA part1 TYPE string VALUE `Hello`.
*    DATA part2 TYPE string VALUE `World`.
*
** String Templates
***********************************************************************
*
*    " comment/uncomment the following lines for different examples
*    "  DATA(text) = |Hello World|.
**    DATA(text) = |Total: { amount } EUR|.
*    DATA(text) = |Total: { amount1 + amount2 } EUR|.
*
** Format Options
***********************************************************************
*
*    "Date
**    DATA(text) = |Raw Date: { the_date             }|.
**    DATA(text) = |ISO Date: { the_date Date = ISO  }|.
**    DATA(text) = |USER Date:{ the_date Date = USER }|.
*
*    "Number
**    DATA(text) = |Raw Number { my_number                    }|.
**    DATA(text) = |User Format{ my_number NUMBER = USER      }|.
**    DATA(text) = |Sign Right { my_number SIGN = RIGHT       }|.
**    DATA(text) = |Scientific { my_number STYLE = SCIENTIFIC }|.
*
** String expression (concatenation Operator)
***********************************************************************
*
**    DATA(text) = part1 && part2.
**    DATA(text) = part1 && | | && part2.
**    DATA(text) = |{ amount1 } + { amount2 }| &&
**                 | = | &&
**                 |{ amount1 + amount2 }|.
**
**                 DATA(a) = amount1.
**
**                 text  = |{ a } + { amount2 }| && | = | && |{ amount1 + amount2 }|.
*
*
** Output
***********************************************************************
*
*    out->write( text ).



** Declarations
***********************************************************************
*
*    " comment/uncomment these line for different result types
*  "  TYPES t_result TYPE p LENGTH 8 DECIMALS 2.
* "  TYPES t_result TYPE p LENGTH 8 DECIMALS 0.
*    TYPES t_result TYPE i.
*
*    DATA result TYPE t_result.
*
** Calculations
***********************************************************************
*    " comment/uncomment these lines for different calculations
*
*    result = 2 + 3.
**    result = 2 - 3.
**    result = 2 * 3.
*    result = 2 / 3.
**
**    result = sqrt( 2 ).
**    result = ipow( base = 2 exp = 3 ).
**
*  "  result = ( 8 * 7 - 6 ) / ( 5 + 4 ).
*   result = 8 * 7 - 6 / 5 + 4.
*
** Output
***********************************************************************
*
*    out->write( result ).


** Data Objects with Built-in Types
***********************************************************************
*
*    " comment/uncomment the following declarations and check the output
*  "  DATA variable TYPE string.
*   "DATA variable TYPE i.
*  "  DATA variable TYPE d.
*  "  DATA variable TYPE c LENGTH 10.
*   " DATA variable TYPE n LENGTH 10.
*    DATA variable TYPE p LENGTH 10 DECIMALS 2.
*
** Output
***********************************************************************
*
*    out->write(  'Result with Initial Value)' ).
*    out->write(   variable ).
*    out->write(  '---------' ).
*
*    variable = '198911093'.
*
*    out->write(  'Result with Value 19891109' ).
*    out->write(   variable ).
*    out->write(  '---------' ).
  ENDMETHOD.
ENDCLASS.
