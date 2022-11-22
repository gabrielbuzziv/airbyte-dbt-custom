{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_airbyte_plan_subscriptions') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['coupon'], ['coupon']) }} as coupon,
    {{ json_extract_scalar('_airbyte_data', ['ends_at'], ['ends_at']) }} as ends_at,
    {{ json_extract_scalar('_airbyte_data', ['plan_id'], ['plan_id']) }} as plan_id,
    {{ json_extract_scalar('_airbyte_data', ['team_id'], ['team_id']) }} as team_id,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['canceled'], ['canceled']) }} as canceled,
    {{ json_extract_scalar('_airbyte_data', ['untagged'], ['untagged']) }} as untagged,
    {{ json_extract_scalar('_airbyte_data', ['starts_at'], ['starts_at']) }} as starts_at,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['purchase_id'], ['purchase_id']) }} as purchase_id,
    {{ json_extract_scalar('_airbyte_data', ['pluto_invoice_id'], ['pluto_invoice_id']) }} as pluto_invoice_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_airbyte_plan_subscriptions') }} as table_alias
-- airbyte_plan_subscriptions
where 1 = 1

