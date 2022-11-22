{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_users_ab3') }}
select
    {{ ref('airbyte_users_ab3') }}.{{ adapter.quote('id') }},
    {{ ref('airbyte_users_ab3') }}.{{ adapter.quote('name') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_users_hashid
from {{ ref('airbyte_users_ab3') }}
inner join {{ ref('airbyte_plan_subscriptions_ab3') }} on {{ ref('airbyte_plan_subscriptions_ab3') }}.user_id = {{ ref('airbyte_users_ab3') }}.id
-- airbyte_users from {{ source('public', '_airbyte_raw_airbyte_users') }}
where 1 = 1

