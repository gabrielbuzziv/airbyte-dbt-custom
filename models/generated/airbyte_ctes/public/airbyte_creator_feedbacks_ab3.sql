{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_creator_feedbacks_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        'user_id',
        'didactic',
        'created_at',
        'creator_id',
        'updated_at',
        'oratory_diction',
        'subject_mastery',
        'content_arrangement',
        'production_equipment',
        'additional_information',
    ]) }} as _airbyte_airbyte_creator_feedbacks_hashid,
    tmp.*
from {{ ref('airbyte_creator_feedbacks_ab2') }} tmp
-- airbyte_creator_feedbacks
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

