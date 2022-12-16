{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('airbyte_lesson_history_feedbacks_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    {{ cast_to_boolean(adapter.quote('content')) }} as {{ adapter.quote('content') }},
    cast(user_id as {{ dbt_utils.type_string() }}) as user_id,
    {{ cast_to_boolean('approach') }} as approach,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(lesson_history_id as {{ dbt_utils.type_string() }}) as lesson_history_id,
    {{ cast_to_boolean('content_organization') }} as content_organization,
    {{ cast_to_boolean('instructor_knowledge') }} as instructor_knowledge,
    cast(additional_information as {{ dbt_utils.type_string() }}) as additional_information,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_lesson_history_feedbacks_ab1') }}
-- airbyte_lesson_history_feedbacks
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

