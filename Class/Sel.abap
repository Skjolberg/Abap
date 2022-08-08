*&---------------------------------------------------------------------*
*&  Include           Z_TEST_DVM_SEL
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK bloque1 WITH FRAME." TITLE TEXT-001.
SELECT-OPTIONS: p_zemple FOR zdvm-zemple NO INTERVALS.
PARAMETERS: "p_zemple TYPE zdvm-zemple,
            p_name1  TYPE zdvm-name1,
            p_stras  TYPE zdvm-stras,
            p_ort01  TYPE zdvm-ort01,
            p_regio  TYPE zdvm-regio,
            p_land   TYPE zdvm-land1.
SELECTION-SCREEN END OF BLOCK bloque1.

SELECTION-SCREEN BEGIN OF BLOCK bloque2 WITH FRAME. "TITLE TEXT-002.
PARAMETERS: p_log AS CHECKBOX.
SELECTION-SCREEN END OF BLOCK bloque2.

SELECTION-SCREEN BEGIN OF BLOCK bloque3 WITH FRAME. "TITLE TEXT-003.
PARAMETERS: rb_ins RADIOBUTTON GROUP rbg DEFAULT 'X',
            rb_upd RADIOBUTTON GROUP rbg,
            rb_del RADIOBUTTON GROUP rbg,
            rb_vis RADIOBUTTON GROUP rbg.
SELECTION-SCREEN END OF BLOCK bloque3.

SELECTION-SCREEN BEGIN OF BLOCK bloque4 WITH FRAME.

PARAMETERS: p_path TYPE ibipparms-path.
SELECTION-SCREEN END OF BLOCK bloque4.
