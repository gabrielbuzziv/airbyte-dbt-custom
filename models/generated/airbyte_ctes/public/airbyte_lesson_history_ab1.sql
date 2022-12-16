{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_airbyte_lesson_history') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('_airbyte_data', ['link'], ['link']) }} as {{ adapter.quote('link') }},
    {{ json_extract_scalar('_airbyte_data', ['slug'], ['slug']) }} as slug,
    {{ json_extract_scalar('_airbyte_data', ['tags'], ['tags']) }} as tags,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['is_free'], ['is_free']) }} as is_free,
    {{ json_extract_scalar('_airbyte_data', ['plan_id'], ['plan_id']) }} as plan_id,
    {{ json_extract_scalar('_airbyte_data', ['download'], ['download']) }} as download,
    {{ json_extract_scalar('_airbyte_data', ['duration'], ['duration']) }} as duration,
    {{ json_extract_scalar('_airbyte_data', ['platform'], ['platform']) }} as platform,
    {{ json_extract_scalar('_airbyte_data', ['resource'], ['resource']) }} as resource,
    {{ json_extract_scalar('_airbyte_data', ['unlisted'], ['unlisted']) }} as unlisted,
    {{ json_extract_scalar('_airbyte_data', ['author_id'], ['author_id']) }} as author_id,
    {{ json_extract_scalar('_airbyte_data', ['lesson_id'], ['lesson_id']) }} as lesson_id,
    {{ json_extract_scalar('_airbyte_data', ['processed'], ['processed']) }} as processed,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['release_at'], ['release_at']) }} as release_at,
    {{ json_extract_scalar('_airbyte_data', ['station_id'], ['station_id']) }} as station_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['featured_at'], ['featured_at']) }} as featured_at,
    {{ json_extract_scalar('_airbyte_data', ['has_caption'], ['has_caption']) }} as has_caption,
    {{ json_extract_scalar('_airbyte_data', ['challenge_id'], ['challenge_id']) }} as challenge_id,
    {{ json_extract_scalar('_airbyte_data', ['is_searchable'], ['is_searchable']) }} as is_searchable,
    {{ json_extract_scalar('_airbyte_data', ['special_event'], ['special_event']) }} as special_event,
    {{ json_extract_scalar('_airbyte_data', ['resource_input'], ['resource_input']) }} as resource_input,
    {{ json_extract_scalar('_airbyte_data', ['is_expert_content'], ['is_expert_content']) }} as is_expert_content,
    {{ json_extract_scalar('_airbyte_data', ['short_description'], ['short_description']) }} as short_description,
    {{ json_extract_scalar('_airbyte_data', ['related_journey_id'], ['related_journey_id']) }} as related_journey_id,
    {{ json_extract_scalar('_airbyte_data', ['default_experts_content'], ['default_experts_content']) }} as default_experts_content,
    {{ json_extract_scalar('_airbyte_data', ['self_evaluation_step_id'], ['self_evaluation_step_id']) }} as self_evaluation_step_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_airbyte_lesson_history') }} as table_alias
-- airbyte_lesson_history
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

