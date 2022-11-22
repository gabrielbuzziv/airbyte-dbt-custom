{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_plan_subscriptions_ab3') }}
select
    {{ adapter.quote('id') }},
    active,
    coupon,
    ends_at,
    plan_id,
    team_id,
    user_id,
    canceled,
    untagged,
    starts_at,
    created_at,
    updated_at,
    purchase_id,
    pluto_invoice_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_plan_subscriptions_hashid
from {{ ref('airbyte_plan_subscriptions_ab3') }}
-- airbyte_plan_subscriptions from {{ source('public', '_airbyte_raw_airbyte_plan_subscriptions') }}
where 1 = 1

