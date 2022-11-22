{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_lesson_lists_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        'slug',
        'title',
        'created_at',
        'updated_at',
        'description',
    ]) }} as _airbyte_airbyte_lesson_lists_hashid,
    tmp.*
from {{ ref('airbyte_lesson_lists_ab2') }} tmp
-- airbyte_lesson_lists
where 1 = 1

