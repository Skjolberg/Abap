CLASS z_class DEFINITION.

  PUBLIC SECTION.
    DATA:
          ls_log TYPE ty_log.
    METHODS:

*      set_zemple IMPORTING VALUE(set_value) TYPE ZDVM-zemple,
*      get_zemple IMPORTING VALUE(get_value) TYPE ZDVM-zemple,
*
*      set_name1 IMPORTING VALUE(set_value) TYPE ZDVM-name1,
*      get_name1 IMPORTING VALUE(set_value) TYPE ZDVM-name1,
*
*      set_stras IMPORTING VALUE(set_value) TYPE ZDVM-stras,
*      get_stras IMPORTING VALUE(get_value) TYPE ZDVM-stras,
*
*      set_ort01 IMPORTING VALUE(set_value) TYPE ZDVM-ort01,
*      get_ort01 IMPORTING VALUE(get_value) TYPE ZDVM-ort01,
*
*      set_regio IMPORTING VALUE(set_value) TYPE ZDVM-regio,
*      get_regio IMPORTING VALUE(get_value) TYPE ZDVM-ort01,

      constructor,
      insert,
      modify,
      delete,
      vista,
      on_double_click FOR EVENT double_click OF cl_salv_events_table
        IMPORTING row column.

  PRIVATE SECTION.
    DATA: ls_emple TYPE zdvm.
*          ls_log   TYPE ty_log.

ENDCLASS.

CLASS z_class IMPLEMENTATION.

  METHOD constructor.
    ls_emple-zemple = p_zemple.
    ls_emple-name1 = p_name1.
    ls_emple-stras = p_stras.
    ls_emple-ort01 = p_ort01.
    ls_emple-regio = p_regio.
  ENDMETHOD.

  METHOD insert.
    INSERT zdvm
    FROM ls_emple.
    IF sy-subrc = 0.
      DATA ls_log TYPE ty_log.
      ls_log-log = |{ sy-datum } / { sy-uzeit } DVM: Se ha insertado el empleado { ls_emple-zemple }|.
      APPEND ls_log TO gt_log.
    ENDIF.
  ENDMETHOD.

  METHOD modify.
    MODIFY zdvm
    FROM ls_emple.
    IF sy-subrc = 0.
      DATA ls_log TYPE ty_log.
      ls_log-log = |{ sy-datum } / { sy-uzeit } DVM: Se ha modificado el empleado { ls_emple-zemple }|.
      APPEND ls_log TO gt_log.
    ENDIF.
  ENDMETHOD.

  METHOD delete.
    DELETE FROM zdvm
    WHERE zemple = ls_emple-zemple.
    IF sy-subrc = 0.
      DATA ls_log TYPE ty_log.
      ls_log-log = |{ sy-datum } / { sy-uzeit } DVM: Se ha borrado el empleado { ls_emple-zemple }|.
      APPEND ls_log TO gt_log.
    ENDIF.
  ENDMETHOD.

  METHOD vista.
    SELECT * INTO TABLE gt_data
   FROM zdvm
   WHERE zemple IN p_zemple.
  ENDMETHOD.

METHOD on_double_click.
  DATA: lt_aux TYPE STANDARD TABLE OF zdvm.
  "lt_aux = gt_data[ row ].
  APPEND gt_data[ row ] TO lt_aux.


TYPE-POOLS: slis.
    DATA: gt_outtab   TYPE TABLE OF ZDVM INITIAL SIZE 0,
          gs_private  TYPE slis_data_caller_exit,
          gs_selfield TYPE slis_selfield,
          gt_fieldcat TYPE slis_t_fieldcat_alv,
          g_exit(1)   TYPE c.

    CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'ZT15RDH'
      CHANGING
        ct_fieldcat      = gt_fieldcat[].


    CALL FUNCTION 'REUSE_ALV_POPUP_TO_SELECT'
      EXPORTING
        i_title       = 'popuozt15rdh'
*       I_SELECTION   = 'X'
*       I_ZEBRA       = ' '
*       I_SCREEN_START_COLUMN   = 0
*       I_SCREEN_START_LINE     = 0
*       I_SCREEN_END_COLUMN     = 80
*       I_SCREEN_END_LINE       = 0
*       I_CHECKBOX_FIELDNAME    =
*       I_LINEMARK_FIELDNAME    =
*       I_SCROLL_TO_SEL_LINE    = 'X'
        i_tabname     = 'ZDVM'
        it_fieldcat   = gt_fieldcat[]
*       IT_EXCLUDING  =
*       I_CALLBACK_PROGRAM      =
*       I_CALLBACK_USER_COMMAND =
        is_private    = gs_private
      IMPORTING
        es_selfield   = gs_selfield
        e_exit        = g_exit
      TABLES
        t_outtab      = lt_aux
      EXCEPTIONS
        program_error = 1
        OTHERS        = 2.

  ENDMETHOD.

ENDCLASS.