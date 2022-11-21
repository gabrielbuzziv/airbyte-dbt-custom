{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        adapter.quote('atlas_user_id'),
        adapter.quote('name'),
        'slug',
        'about',
        'avatar_url',
        'company_id',
        'occupation',
        'created_at',
        'updated_at',
    ]) }} as _airbyte_users_hashid,
    tmp.*
from {{ ref('members_ab2') }} tmp
-- members
where 1 = 1

