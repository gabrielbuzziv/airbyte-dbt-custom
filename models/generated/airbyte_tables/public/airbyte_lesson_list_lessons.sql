{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_lesson_list_lessons_ab3') }}
select
    {{ adapter.quote('id') }},
    {{ adapter.quote('order') }},
    lesson_id,
    created_at,
    updated_at,
    lesson_list_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_lesson_list_lessons_hashid
from {{ ref('airbyte_lesson_list_lessons_ab3') }}
-- airbyte_lesson_list_lessons from {{ source('public', '_airbyte_raw_airbyte_lesson_list_lessons') }}
where 1 = 1

