{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_airbyte_creator_feedback_status') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['creator_id'], ['creator_id']) }} as creator_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_array('_airbyte_data', ['watched_lessons_ids'], ['watched_lessons_ids']) }} as watched_lessons_ids,
    {{ json_extract_scalar('_airbyte_data', ['feedback_modal_showed'], ['feedback_modal_showed']) }} as feedback_modal_showed,
    {{ json_extract_scalar('_airbyte_data', ['feedback_banner_showed'], ['feedback_banner_showed']) }} as feedback_banner_showed,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_airbyte_creator_feedback_status') }} as table_alias
-- airbyte_creator_feedback_status
where 1 = 1
