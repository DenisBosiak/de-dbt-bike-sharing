(#
    This macro return the description of the column "is_member"
#)

{% macro get_driver_type_description(is_member) %}

    CASE {{ is_member }}
        WHEN 0 THEN 'Guest'
        WHEN 1 THEN 'Member'
    END

{%- endmacro %}