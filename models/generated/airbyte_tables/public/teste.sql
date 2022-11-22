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
        title
    from {{ ref('airbyte_plans_ab3') }}
)

select
    {{ adapter.quote('id') }},
    {{ adapter.quote('type') }} as tipo_do_plano
from plans
where title = 'ExpertsClub - Creators'

