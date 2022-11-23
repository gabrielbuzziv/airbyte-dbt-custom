{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_lesson_history_ab3') }}
select
    {{ adapter.quote('id') }},
    {{ adapter.quote('link') }},
    slug,
    tags,
    title,
    is_free,
    plan_id,
    download,
    duration,
    platform,
    resource,
    unlisted,
    author_id,
    lesson_id,
    processed,
    created_at,
    release_at,
    station_id,
    updated_at,
    description,
    featured_at,
    has_caption,
    challenge_id,
    is_searchable,
    special_event,
    resource_input,
    is_expert_content,
    short_description,
    related_journey_id,
    default_experts_content,
    self_evaluation_step_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_lesson_history_hashid
from {{ ref('airbyte_lesson_history_ab3') }}
-- airbyte_lesson_history from {{ source('public', '_airbyte_raw_airbyte_lesson_history') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

