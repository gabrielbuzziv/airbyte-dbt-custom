{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_plans_ab3') }}
select
    {{ adapter.quote('id') }},
    {{ adapter.quote('type') }},
    title,
    team_id,
    created_at,
    hotmart_id,
    updated_at,
    duration_in_months,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_plans_hashid
from {{ ref('airbyte_plans_ab3') }}
-- airbyte_plans from {{ source('public', '_airbyte_raw_airbyte_plans') }}
where 1 = 1

