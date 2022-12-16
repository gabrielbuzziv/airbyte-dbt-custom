{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_lesson_history_feedbacks_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        adapter.quote('type'),
        boolean_to_string(adapter.quote('content')),
        'user_id',
        boolean_to_string('approach'),
        'created_at',
        'updated_at',
        'lesson_history_id',
        boolean_to_string('content_organization'),
        boolean_to_string('instructor_knowledge'),
        'additional_information',
    ]) }} as _airbyte_airbyte_les__tory_feedbacks_hashid,
    tmp.*
from {{ ref('airbyte_lesson_history_feedbacks_ab2') }} tmp
-- airbyte_lesson_history_feedbacks
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

