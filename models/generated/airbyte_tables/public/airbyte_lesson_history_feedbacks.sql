{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_lesson_history_feedbacks_ab3') }}
select
    {{ adapter.quote('id') }},
    {{ adapter.quote('type') }},
    {{ adapter.quote('content') }},
    user_id,
    approach,
    created_at,
    updated_at,
    lesson_history_id,
    content_organization,
    instructor_knowledge,
    additional_information,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_les__tory_feedbacks_hashid
from {{ ref('airbyte_lesson_history_feedbacks_ab3') }}
-- airbyte_lesson_history_feedbacks from {{ source('public', '_airbyte_raw_airbyte_lesson_history_feedbacks') }}
where 1 = 1

