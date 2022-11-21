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
    {{ adapter.quote('atlas_user_id') }},
    {{ adapter.quote('name') }},
    slug,
    about,
    avatar_url,
    company_id,
    occupation,
    created_at,
    updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_users_hashid
from {{ ref('members_ab3') }}
-- users from {{ source('public', '_airbyte_raw_users') }}
where 1 = 1

