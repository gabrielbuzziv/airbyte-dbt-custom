{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_lesson_history_impression_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        boolean_to_string('ack'),
        adapter.quote('type'),
        'user_id',
        'reference',
        'created_at',
        'updated_at',
        'lesson_history_id',
    ]) }} as _airbyte_airbyte_les__ory_impression_hashid,
    tmp.*
from {{ ref('airbyte_lesson_history_impression_ab2') }} tmp
-- airbyte_lesson_history_impression
where 1 = 1

