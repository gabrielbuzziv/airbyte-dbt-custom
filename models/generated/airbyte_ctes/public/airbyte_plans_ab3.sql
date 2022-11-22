{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_plans_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        adapter.quote('type'),
        'title',
        'team_id',
        'created_at',
        'hotmart_id',
        'updated_at',
        'duration_in_months',
    ]) }} as _airbyte_airbyte_plans_hashid,
    tmp.*
from {{ ref('airbyte_plans_ab2') }} tmp
-- airbyte_plans
where 1 = 1

