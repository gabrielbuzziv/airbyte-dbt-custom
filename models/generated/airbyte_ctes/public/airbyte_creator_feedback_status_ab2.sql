{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('airbyte_creator_feedback_status_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(user_id as {{ dbt_utils.type_string() }}) as user_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(creator_id as {{ dbt_utils.type_string() }}) as creator_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    watched_lessons_ids,
    cast({{ empty_string_to_null('feedback_modal_showed') }} as {{ type_timestamp_with_timezone() }}) as feedback_modal_showed,
    cast({{ empty_string_to_null('feedback_banner_showed') }} as {{ type_timestamp_with_timezone() }}) as feedback_banner_showed,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_creator_feedback_status_ab1') }}
-- airbyte_creator_feedback_status
where 1 = 1

