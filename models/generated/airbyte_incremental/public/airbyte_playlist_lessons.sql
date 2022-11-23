{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_playlist_lessons_ab3') }}
select
    {{ adapter.quote('id') }},
    lesson_id,
    created_at,
    updated_at,
    playlist_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_playlist_lessons_hashid
from {{ ref('airbyte_playlist_lessons_ab3') }}
-- airbyte_playlist_lessons from {{ source('public', '_airbyte_raw_airbyte_playlist_lessons') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}
