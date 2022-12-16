{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_lesson_history_sections_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        adapter.quote('time'),
        'title',
        'created_at',
        'updated_at',
        'lesson_history_id',
    ]) }} as _airbyte_airbyte_les__story_sections_hashid,
    tmp.*
from {{ ref('airbyte_lesson_history_sections_ab2') }} tmp
-- airbyte_lesson_history_sections
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

