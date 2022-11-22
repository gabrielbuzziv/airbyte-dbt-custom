{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_creator_feedbacks_ab3') }}
select
    {{ adapter.quote('id') }},
    user_id,
    didactic,
    created_at,
    creator_id,
    updated_at,
    oratory_diction,
    subject_mastery,
    content_arrangement,
    production_equipment,
    additional_information,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_creator_feedbacks_hashid
from {{ ref('airbyte_creator_feedbacks_ab3') }}
-- airbyte_creator_feedbacks from {{ source('public', '_airbyte_raw_airbyte_creator_feedbacks') }}
where 1 = 1

