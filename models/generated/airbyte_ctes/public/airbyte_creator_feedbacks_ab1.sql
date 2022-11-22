{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_airbyte_creator_feedbacks') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['didactic'], ['didactic']) }} as didactic,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['creator_id'], ['creator_id']) }} as creator_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['oratory_diction'], ['oratory_diction']) }} as oratory_diction,
    {{ json_extract_scalar('_airbyte_data', ['subject_mastery'], ['subject_mastery']) }} as subject_mastery,
    {{ json_extract_scalar('_airbyte_data', ['content_arrangement'], ['content_arrangement']) }} as content_arrangement,
    {{ json_extract_scalar('_airbyte_data', ['production_equipment'], ['production_equipment']) }} as production_equipment,
    {{ json_extract_scalar('_airbyte_data', ['additional_information'], ['additional_information']) }} as additional_information,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_airbyte_creator_feedbacks') }} as table_alias
-- airbyte_creator_feedbacks
where 1 = 1

