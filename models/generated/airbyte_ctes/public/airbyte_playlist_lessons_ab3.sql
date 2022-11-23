{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_playlist_lessons_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        'lesson_id',
        'created_at',
        'updated_at',
        'playlist_id',
    ]) }} as _airbyte_airbyte_playlist_lessons_hashid,
    tmp.*
from {{ ref('airbyte_playlist_lessons_ab2') }} tmp
-- airbyte_playlist_lessons
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

