{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('airbyte_plan_subscriptions_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    {{ cast_to_boolean('active') }} as active,
    cast(coupon as {{ dbt_utils.type_string() }}) as coupon,
    cast({{ empty_string_to_null('ends_at') }} as {{ type_timestamp_with_timezone() }}) as ends_at,
    cast(plan_id as {{ dbt_utils.type_string() }}) as plan_id,
    cast(team_id as {{ dbt_utils.type_string() }}) as team_id,
    cast(user_id as {{ dbt_utils.type_string() }}) as user_id,
    {{ cast_to_boolean('canceled') }} as canceled,
    {{ cast_to_boolean('untagged') }} as untagged,
    cast({{ empty_string_to_null('starts_at') }} as {{ type_timestamp_with_timezone() }}) as starts_at,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(purchase_id as {{ dbt_utils.type_string() }}) as purchase_id,
    cast(pluto_invoice_id as {{ dbt_utils.type_string() }}) as pluto_invoice_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_plan_subscriptions_ab1') }}
-- airbyte_plan_subscriptions
where 1 = 1

