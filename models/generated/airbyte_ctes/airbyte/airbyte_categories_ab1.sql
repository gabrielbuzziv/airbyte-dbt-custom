{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('airbyte', '_airbyte_raw_airbyte_categories') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as {{ adapter.quote('type') }},
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['icon_id'], ['icon_id']) }} as icon_id,
    {{ json_extract_scalar('_airbyte_data', ['parent_id'], ['parent_id']) }} as parent_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['is_enabled'], ['is_enabled']) }} as is_enabled,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('airbyte', '_airbyte_raw_airbyte_categories') }} as table_alias
-- airbyte_categories
where 1 = 1

