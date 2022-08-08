*&---------------------------------------------------------------------*
*&  Include           Z_TEST_DVM_F01
*&---------------------------------------------------------------------*

FORM f01_startflow.

  DATA: lo_class TYPE REF TO z_class.
  CREATE OBJECT lo_class.

  IF rb_ins IS NOT INITIAL.
    lo_class->insert( ).
  ELSEIF rb_upd IS NOT INITIAL.
    lo_class->modify( ).
  ELSEIF rb_del IS NOT INITIAL.
    lo_class->delete( ).
  ELSE.
    lo_class->vista( ).
    IF gt_data IS NOT INITIAL.
      PERFORM f01_visdata.
    ENDIF.
  ENDIF.

ENDFORM.

FORM f01_load_log.

  DATA: lv_path TYPE char50,
        lv_row  TYPE ty_log,
        ls_log  TYPE ty_log.
  lv_path = '.\Log.txt'.


  OPEN DATASET lv_path FOR INPUT IN TEXT MODE ENCODING DEFAULT.
  IF sy-subrc = 0.
    DO.
      READ DATASET lv_path INTO lv_row.
      IF sy-subrc = 0.
        APPEND lv_row TO gt_log.
      ELSE.
        EXIT.
      ENDIF.
    ENDDO.

    CLOSE DATASET lv_path.

  ENDIF.

ENDFORM.

FORM f01_write_log.

  DATA: lv_path TYPE char50,
        lv_row  TYPE ty_log,
        ls_log  TYPE ty_log.
  lv_path = '.\Log.txt'.


  OPEN DATASET lv_path FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.
  IF sy-subrc = 0.
    LOOP AT gt_log INTO lv_row.
      TRANSFER lv_row-log TO lv_path.

    ENDLOOP.

    CLOSE DATASET lv_path.

  ENDIF.

ENDFORM.

FORM f_get_path.
    CALL FUNCTION 'F4_FILENAME' "Read Local File
      EXPORTING
        program_name  = syst-repid
        dynpro_number = syst-dynnr
      IMPORTING
        file_name     = p_path.
*  ENDIF.
  IF sy-subrc NE 0.
    CLEAR p_path.
*    MESSAGE text-003 TYPE gc_error.
  ENDIF.
ENDFORM.


FORM f01_visdata.

  DATA: lo_table          TYPE REF TO cl_salv_table.
  DATA: lo_functions_list TYPE REF TO cl_salv_functions_list.
  DATA: lo_columns        TYPE REF TO cl_salv_columns_table.
  DATA: lr_column         TYPE REF TO cl_salv_column_table.
  DATA: lo_layout         TYPE REF TO cl_salv_layout.
  DATA: ls_key            TYPE salv_s_layout_key.
  DATA: lo_selection      TYPE REF TO cl_salv_selections.

  " Eventos
  DATA: lr_events TYPE REF TO cl_salv_events_table.
  DATA: gr_events TYPE REF TO z_class.

  TRY.
      cl_salv_table=>factory( IMPORTING r_salv_table = lo_table
                              CHANGING  t_table      = gt_data ).
      lo_functions_list = lo_table->get_functions( ).
      lo_functions_list->set_all( abap_true ).
      lo_columns = lo_table->get_columns( ).
      lo_columns->set_optimize( 'X' ).

*      lr_column ?= lo_columns->get_column( 'ZEMPLE' ).
*      lr_column->set_long_text( TEXT-001 ). lr_column->set_medium_text( TEXT-001 ). lr_column->set_short_text( TEXT-001 ).

*      lr_column ?= lo_columns->get_column( 'FILENAME' ).
*      lr_column->set_long_text( TEXT-005 ). lr_column->set_medium_text( TEXT-005 ). lr_column->set_short_text( TEXT-006 ).

*    register to the events of cl_salv_table

      lr_events = lo_table->get_event( ).

      CREATE OBJECT gr_events.
*... §6.1 register to the event USER_COMMAND
*    SET HANDLER gr_events->on_user_command FOR lr_events.
*... §6.2 register to the event BEFORE_SALV_FUNCTION
*    SET HANDLER gr_events->on_before_salv_function FOR lr_events.
*... §6.3 register to the event AFTER_SALV_FUNCTION
*    SET HANDLER gr_events->on_after_salv_function FOR lr_events.
*... §6.4 register to the event DOUBLE_CLICK
      SET HANDLER gr_events->on_double_click FOR lr_events.
*... §6.5 register to the event LINK_CLICK

*   Debe rellenar todos los campos de compañía aérea
*    SET HANDLER gr_events->on_link_click FOR lr_events.

      lo_layout = lo_table->get_layout( ).
      ls_key-report = sy-repid.
      lo_layout->set_key( ls_key ).
      lo_layout->set_save_restriction( cl_salv_layout=>restrict_none ).
      lo_selection = lo_table->get_selections( ).
* 1 = una selección. 2 = multiples selecciones con control + click. 3 = multiples selecciones con celda
      lo_selection->set_selection_mode( 3 ).
      lo_table->display( ).

    CATCH  cx_salv_msg .
      MESSAGE TEXT-008 TYPE 'E'.

    CATCH cx_salv_not_found.
      MESSAGE TEXT-008 TYPE 'E'.

  ENDTRY.


ENDFORM.
