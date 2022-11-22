{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_technologies_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        adapter.quote('name'),
        'slug',
        'image',
        'parent_id',
        'created_at',
        boolean_to_string('selectable'),
        'updated_at',
    ]) }} as _airbyte_airbyte_technologies_hashid,
    tmp.*
from {{ ref('airbyte_technologies_ab2') }} tmp
-- airbyte_technologies
where 1 = 1

