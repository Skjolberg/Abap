*&---------------------------------------------------------------------*
*&  Include           Z_TEST_DVM_TOP
*&---------------------------------------------------------------------*

TABLES zdvm.

TYPES: BEGIN OF ty_log,
         log TYPE char100,
       END OF ty_log,
       ty_t_log TYPE STANDARD TABLE OF ty_log.

DATA: gt_log TYPE ty_t_log,
      gt_data TYPE STANDARD TABLE OF zdvm.
