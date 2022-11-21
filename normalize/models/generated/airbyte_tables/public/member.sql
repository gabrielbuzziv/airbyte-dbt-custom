{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('users_ab3') }}

select
    {{ adapter.quote('id') }},
    {{ adapter.quote('id') }} as atlas_user_id,
    name,
    slug,
    avatar as avatar_url,
    company_id as company,
    occupation,
    about,
    created_at,
    updated_at
from {{ ref('users_ab3') }}
where 1 = 1

