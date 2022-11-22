{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_lesson_history_impression_ab3') }}
select
    {{ adapter.quote('id') }},
    ack,
    {{ adapter.quote('type') }},
    user_id,
    reference,
    created_at,
    updated_at,
    lesson_history_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_les__ory_impression_hashid
from {{ ref('airbyte_lesson_history_impression_ab3') }}
-- airbyte_lesson_history_impression from {{ source('public', '_airbyte_raw_airbyte_lesson_history_impression') }}
where 1 = 1

