{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}

SELECT
    {{ adapter.quote('id') }},
    {{ adapter.quote('id') }} as atlas_user_id,
    {{ adapter.quote('name') }},
    created_at,
    updated_at,
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid() as _airbyte_members_hashid
FROM {{ ref('airbyte_users_ab3') }}

