{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_creator_feedback_status_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        'status',
        'user_id',
        'created_at',
        'creator_id',
        'updated_at',
        array_to_string('watched_lessons_ids'),
        'feedback_modal_showed',
        'feedback_banner_showed',
    ]) }} as _airbyte_airbyte_cre__eedback_status_hashid,
    tmp.*
from {{ ref('airbyte_creator_feedback_status_ab2') }} tmp
-- airbyte_creator_feedback_status
where 1 = 1

