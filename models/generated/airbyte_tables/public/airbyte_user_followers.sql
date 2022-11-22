{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_user_followers_ab3') }}
select
    {{ adapter.quote('id') }},
    created_at,
    updated_at,
    followed_id,
    follower_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_user_followers_hashid
from {{ ref('airbyte_user_followers_ab3') }}
-- airbyte_user_followers from {{ source('public', '_airbyte_raw_airbyte_user_followers') }}
where 1 = 1

