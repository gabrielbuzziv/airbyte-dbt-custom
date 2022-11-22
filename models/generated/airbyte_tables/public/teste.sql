{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_plan_subscriptions_ab3') }}


with plans as (
    select
        {{ adapter.quote('id') }},
        {{ adapter.quote('type') }},
        title,
        _airbyte_ab_id,
        _airbyte_emitted_at,
        {{ current_timestamp() }} as _airbyte_normalized_at,
        _airbyte_airbyte_plans_hashid
    from {{ ref('airbyte_plans_ab3') }}
)

select
    {{ adapter.quote('id') }},
    {{ adapter.quote('type') }} as tipo_do_plano,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_plans_hashid
from plans
where title = 'ExpertsClub - Creators'

