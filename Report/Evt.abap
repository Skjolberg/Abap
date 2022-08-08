*&---------------------------------------------------------------------*
*&  Include           ZEXAMEN_DVM_EVT
*&---------------------------------------------------------------------*

" Limpieza de variables, estructuras y tablas internas

INITIALIZATION.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_load.
  PERFORM help_search.

AT SELECTION-SCREEN.
  PERFORM path_empty.

START-OF-SELECTION.
  PERFORM load_path.

END-OF-SELECTION.
  PERFORM alv_path.