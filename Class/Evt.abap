*&---------------------------------------------------------------------*
*&  Include           Z_TEST_DVM_EVT
*&---------------------------------------------------------------------*

INITIALIZATION.

  PERFORM f01_load_log.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_path.
  PERFORM f_get_path.

START-OF-SELECTION.

  PERFORM f01_startflow.

PERFORM f01_write_log.
