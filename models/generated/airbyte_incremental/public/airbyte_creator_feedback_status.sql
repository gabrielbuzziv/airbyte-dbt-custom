{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_creator_feedback_status_ab3') }}
select
    {{ adapter.quote('id') }},
    status,
    user_id,
    created_at,
    creator_id,
    updated_at,
    watched_lessons_ids,
    feedback_modal_showed,
    feedback_banner_showed,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_cre__eedback_status_hashid
from {{ ref('airbyte_creator_feedback_status_ab3') }}
-- airbyte_creator_feedback_status from {{ source('public', '_airbyte_raw_airbyte_creator_feedback_status') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

