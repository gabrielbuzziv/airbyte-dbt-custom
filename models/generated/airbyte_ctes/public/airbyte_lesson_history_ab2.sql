{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('airbyte_lesson_history_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast({{ adapter.quote('link') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('link') }},
    cast(slug as {{ dbt_utils.type_string() }}) as slug,
    cast(tags as {{ dbt_utils.type_string() }}) as tags,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    {{ cast_to_boolean('is_free') }} as is_free,
    cast(plan_id as {{ dbt_utils.type_string() }}) as plan_id,
    cast(download as {{ dbt_utils.type_string() }}) as download,
    cast(duration as {{ dbt_utils.type_bigint() }}) as duration,
    cast(platform as {{ dbt_utils.type_string() }}) as platform,
    cast(resource as {{ dbt_utils.type_string() }}) as resource,
    {{ cast_to_boolean('unlisted') }} as unlisted,
    cast(author_id as {{ dbt_utils.type_string() }}) as author_id,
    cast(lesson_id as {{ dbt_utils.type_string() }}) as lesson_id,
    {{ cast_to_boolean('processed') }} as processed,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast({{ empty_string_to_null('release_at') }} as {{ type_date() }}) as release_at,
    cast(station_id as {{ dbt_utils.type_string() }}) as station_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast({{ empty_string_to_null('featured_at') }} as {{ type_timestamp_with_timezone() }}) as featured_at,
    {{ cast_to_boolean('has_caption') }} as has_caption,
    cast(challenge_id as {{ dbt_utils.type_string() }}) as challenge_id,
    {{ cast_to_boolean('is_searchable') }} as is_searchable,
    {{ cast_to_boolean('special_event') }} as special_event,
    cast(resource_input as {{ dbt_utils.type_string() }}) as resource_input,
    {{ cast_to_boolean('is_expert_content') }} as is_expert_content,
    cast(short_description as {{ dbt_utils.type_string() }}) as short_description,
    cast(related_journey_id as {{ dbt_utils.type_string() }}) as related_journey_id,
    {{ cast_to_boolean('default_experts_content') }} as default_experts_content,
    cast(self_evaluation_step_id as {{ dbt_utils.type_string() }}) as self_evaluation_step_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_lesson_history_ab1') }}
-- airbyte_lesson_history
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

