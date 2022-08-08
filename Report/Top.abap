*&---------------------------------------------------------------------*
*&  Include           ZEXAMEN_DVM_TOP
*&---------------------------------------------------------------------*

" Tabla
TABLES zexa_tabla_dvm.

TYPES: BEGIN OF ty_alv,
         include    TYPE zexa_tabla_dvm,
         t_ico      TYPE icon_d,
         t_msg(100) TYPE c,
       END OF ty_alv.

DATA: gt_file     TYPE STANDARD TABLE OF zexa_tabla_dvm,
      gt_file_alv TYPE STANDARD TABLE OF ty_alv,
      ge_file     TYPE zexa_tabla_dvm,
      ge_file_alv TYPE ty_alv.