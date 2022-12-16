{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_airbyte_users') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('_airbyte_data', ['slug'], ['slug']) }} as slug,
    {{ json_extract_scalar('_airbyte_data', ['about'], ['about']) }} as about,
    {{ json_extract_scalar('_airbyte_data', ['cover'], ['cover']) }} as cover,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as {{ adapter.quote('state') }},
    {{ json_extract_scalar('_airbyte_data', ['token'], ['token']) }} as {{ adapter.quote('token') }},
    {{ json_extract_scalar('_airbyte_data', ['avatar'], ['avatar']) }} as avatar,
    {{ json_extract_scalar('_airbyte_data', ['github'], ['github']) }} as github,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['utm_id'], ['utm_id']) }} as utm_id,
    {{ json_extract_scalar('_airbyte_data', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('_airbyte_data', ['discord'], ['discord']) }} as discord,
    {{ json_extract_scalar('_airbyte_data', ['pioneer'], ['pioneer']) }} as pioneer,
    {{ json_extract_scalar('_airbyte_data', ['twitter'], ['twitter']) }} as twitter,
    {{ json_extract_scalar('_airbyte_data', ['apple_id'], ['apple_id']) }} as apple_id,
    {{ json_extract_scalar('_airbyte_data', ['document'], ['document']) }} as {{ adapter.quote('document') }},
    {{ json_extract_scalar('_airbyte_data', ['linkedin'], ['linkedin']) }} as linkedin,
    {{ json_extract_scalar('_airbyte_data', ['og_image'], ['og_image']) }} as og_image,
    {{ json_extract_scalar('_airbyte_data', ['password'], ['password']) }} as {{ adapter.quote('password') }},
    {{ json_extract_scalar('_airbyte_data', ['timezone'], ['timezone']) }} as timezone,
    {{ json_extract_scalar('_airbyte_data', ['utm_term'], ['utm_term']) }} as utm_term,
    {{ json_extract_scalar('_airbyte_data', ['verified'], ['verified']) }} as verified,
    {{ json_extract_scalar('_airbyte_data', ['github_id'], ['github_id']) }} as github_id,
    {{ json_extract_scalar('_airbyte_data', ['onboarded'], ['onboarded']) }} as onboarded,
    {{ json_extract_scalar('_airbyte_data', ['blocked_at'], ['blocked_at']) }} as blocked_at,
    {{ json_extract_scalar('_airbyte_data', ['company_id'], ['company_id']) }} as company_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['discord_id'], ['discord_id']) }} as discord_id,
    {{ json_extract_scalar('_airbyte_data', ['has_credit'], ['has_credit']) }} as has_credit,
    {{ json_extract_scalar('_airbyte_data', ['is_visible'], ['is_visible']) }} as is_visible,
    {{ json_extract_scalar('_airbyte_data', ['last_login'], ['last_login']) }} as last_login,
    {{ json_extract_scalar('_airbyte_data', ['occupation'], ['occupation']) }} as occupation,
    {{ json_extract_scalar('_airbyte_data', ['station_id'], ['station_id']) }} as station_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['utm_medium'], ['utm_medium']) }} as utm_medium,
    {{ json_extract_scalar('_airbyte_data', ['utm_source'], ['utm_source']) }} as utm_source,
    {{ json_extract_scalar('_airbyte_data', ['utm_content'], ['utm_content']) }} as utm_content,
    {{ json_extract_scalar('_airbyte_data', ['company_name'], ['company_name']) }} as company_name,
    {{ json_extract_scalar('_airbyte_data', ['github_token'], ['github_token']) }} as github_token,
    {{ json_extract_scalar('_airbyte_data', ['utm_campaign'], ['utm_campaign']) }} as utm_campaign,
    {{ json_extract_scalar('_airbyte_data', ['utm_saved_at'], ['utm_saved_at']) }} as utm_saved_at,
    {{ json_extract_scalar('_airbyte_data', ['subscriber_id'], ['subscriber_id']) }} as subscriber_id,
    {{ json_extract_scalar('_airbyte_data', ['blocked_status'], ['blocked_status']) }} as blocked_status,
    {{ json_extract_scalar('_airbyte_data', ['recovery_token'], ['recovery_token']) }} as recovery_token,
    {{ json_extract_scalar('_airbyte_data', ['onboarded_hubble'], ['onboarded_hubble']) }} as onboarded_hubble,
    {{ json_extract_scalar('_airbyte_data', ['token_created_at'], ['token_created_at']) }} as token_created_at,
    {{ json_extract_scalar('_airbyte_data', ['registration_token'], ['registration_token']) }} as registration_token,
    {{ json_extract_scalar('_airbyte_data', ['use_shipping_as_billing'], ['use_shipping_as_billing']) }} as use_shipping_as_billing,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_airbyte_users') }} as table_alias
-- airbyte_users
where 1 = 1

