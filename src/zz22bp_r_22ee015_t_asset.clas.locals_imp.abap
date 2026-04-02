CLASS LHC_ZZ22R_22EE015_T_ASSET DEFINITION
  INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.

  PRIVATE SECTION.

    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
          REQUEST requested_authorizations FOR Zz22r22ee015TAsset
        RESULT result,

      mark_maintenance FOR MODIFY
        IMPORTING keys FOR ACTION Zz22r22ee015TAsset~mark_maintenance
        RESULT result,

      set_status FOR DETERMINE ON MODIFY
        IMPORTING keys FOR Zz22r22ee015TAsset~set_status,

      check_dates FOR VALIDATE ON SAVE
        IMPORTING keys FOR Zz22r22ee015TAsset~check_dates.

ENDCLASS.



CLASS LHC_ZZ22R_22EE015_T_ASSET IMPLEMENTATION.

  METHOD GET_GLOBAL_AUTHORIZATIONS.
    " Allow all operations
  ENDMETHOD.


  " 🔥 ACTION: Mark Maintenance
METHOD mark_maintenance.

  MODIFY ENTITIES OF ZZ22R_22EE015_T_ASSET
    IN LOCAL MODE
    ENTITY Zz22r22ee015TAsset
    UPDATE FIELDS ( Status )
    WITH VALUE #(
      FOR key IN keys
      ( %tky = key-%tky
        Status = 'MAINTENANCE' )
    ).

ENDMETHOD.



  " 🔥 DETERMINATION: Auto Status
  METHOD set_status.

    READ ENTITIES OF ZZ22R_22EE015_T_ASSET
      IN LOCAL MODE
      ENTITY Zz22r22ee015TAsset
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_data).

    LOOP AT lt_data INTO DATA(ls_data).

      IF ls_data-WarrantyEndDate < sy-datum.
        ls_data-Status = 'EXPIRED'.
      ELSE.
        ls_data-Status = 'ACTIVE'.
      ENDIF.

      MODIFY ENTITIES OF ZZ22R_22EE015_T_ASSET
        IN LOCAL MODE
        ENTITY Zz22r22ee015TAsset
        UPDATE FIELDS ( Status )
        WITH VALUE #(
          ( %tky = ls_data-%tky
            Status = ls_data-Status )
        ).

    ENDLOOP.

  ENDMETHOD.



  " 🔥 VALIDATION: Date Check
  METHOD check_dates.

    READ ENTITIES OF ZZ22R_22EE015_T_ASSET
      IN LOCAL MODE
      ENTITY Zz22r22ee015TAsset
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_data).

    LOOP AT lt_data INTO DATA(ls_data).

      IF ls_data-WarrantyEndDate < ls_data-PurchaseDate.

        APPEND VALUE #(
          %tky = ls_data-%tky
          %msg = new_message(
            id       = 'ZMSG'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = 'Warranty must be after purchase date'
          )
        ) TO reported-Zz22r22ee015TAsset.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
