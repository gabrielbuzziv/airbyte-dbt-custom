{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_lesson_history_tag_users_ab3') }}
select
    {{ adapter.quote('id') }},
    tag_id,
    user_id,
    created_at,
    updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_les__tory_tag_users_hashid
from {{ ref('airbyte_lesson_history_tag_users_ab3') }}
-- airbyte_lesson_history_tag_users from {{ source('public', '_airbyte_raw_airbyte_lesson_history_tag_users') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

