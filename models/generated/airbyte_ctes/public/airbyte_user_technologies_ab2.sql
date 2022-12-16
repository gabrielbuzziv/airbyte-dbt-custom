{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('airbyte_user_technologies_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast({{ adapter.quote('order') }} as {{ dbt_utils.type_bigint() }}) as {{ adapter.quote('order') }},
    cast(user_id as {{ dbt_utils.type_string() }}) as user_id,
    {{ cast_to_boolean('featured') }} as featured,
    cast(relevance as {{ dbt_utils.type_string() }}) as relevance,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(technology_id as {{ dbt_utils.type_string() }}) as technology_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_user_technologies_ab1') }}
-- airbyte_user_technologies
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

