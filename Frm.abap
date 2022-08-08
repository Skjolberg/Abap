*&---------------------------------------------------------------------*
*&  Include           ZEXAMEN_DVM_FRM
*&---------------------------------------------------------------------*

FORM help_search .

  DATA: lv_rc       TYPE i,
        lt_filename TYPE filetable.

  CALL METHOD cl_gui_frontend_services=>file_open_dialog
    CHANGING
      file_table              = lt_filename
      rc                      = lv_rc
    EXCEPTIONS
      file_open_dialog_failed = 1
      cntl_error              = 2
      error_no_gui            = 3
      not_supported_by_gui    = 4
      OTHERS                  = 5.
  IF sy-subrc EQ 0.
    IF lt_filename IS NOT INITIAL.
      p_load = lt_filename[ 1 ].
    ENDIF.

  ELSE.

    WRITE 'Fichero no encontrado. '.

  ENDIF.
ENDFORM.                    " get_file

" Check path empty
FORM path_empty.

  IF p_load IS INITIAL.

    MESSAGE 'No se han seleccionado datos' TYPE 'E'.

  ENDIF.

ENDFORM.


FORM load_path .

  DATA: lt_table TYPE TABLE OF string,
        ls_row   TYPE string.

  CALL METHOD cl_gui_frontend_services=>gui_upload
    EXPORTING
      filename                = p_load
      filetype                = 'ASC'
*     has_field_separator     = ';'
    CHANGING
      data_tab                = lt_table
    EXCEPTIONS
      file_open_error         = 1
      file_read_error         = 2
      no_batch                = 3
      gui_refuse_filetransfer = 4
      invalid_type            = 5
      no_authority            = 6
      unknown_error           = 7
      bad_data_format         = 8
      header_not_allowed      = 9
      separator_not_allowed   = 10
      header_too_long         = 11
      unknown_dp_error        = 12
      access_denied           = 13
      dp_out_of_memory        = 14
      disk_full               = 15
      dp_timeout              = 16
      not_supported_by_gui    = 17
      error_no_gui            = 18
      OTHERS                  = 19.

  IF sy-subrc EQ 0.
    LOOP AT lt_table INTO ls_row.

      ge_file_alv-include-mandt = sy-mandt.

      SPLIT ls_row AT ';'
        INTO
          ge_file_alv-include-carrid
          ge_file_alv-include-carrname
          ge_file_alv-include-currcode
          ge_file_alv-include-url.

      " 2 Campos extras que se piden (icono y mensaje)
      ge_file_alv-t_ico = ''.
      ge_file_alv-t_msg(100) = ''.
      " Introducción de los datos a la tabla
      APPEND ge_file_alv TO gt_file.
    ENDLOOP.
  ENDIF.
ENDFORM.

FORM alv_path .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      it_fieldcat = gt_file_alv
    TABLES
      t_outtab    = gt_file_alv.

ENDFORM.