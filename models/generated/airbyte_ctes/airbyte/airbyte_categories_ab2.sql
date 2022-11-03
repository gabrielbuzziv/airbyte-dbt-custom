{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('airbyte_categories_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('type') }},
    cast(title as {{ dbt_utils.type_string() }}(1024)) as title,
    cast(icon_id as {{ dbt_utils.type_bigint() }}) as icon_id,
    cast(parent_id as {{ dbt_utils.type_bigint() }}) as parent_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    {{ cast_to_boolean('is_enabled') }} as is_enabled,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_categories_ab1') }}
-- airbyte_categories
where 1 = 1

