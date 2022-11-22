{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_users_ab3') }}

select
    u.id,
    u.id as atlas_user_id,
    u.name,
    u.slug,
    concat('https://xesque.rocketseat.dev/users/avatar/', u.avatar) as avatar_url,
    u.company_name as company,
    u.occupation,
    u.about,
    u.created_at,
    u.updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_users_hashid
from {{ ref('airbyte_plans_subscription_ab3') }} ps
    inner join plans p on p.id = ps.plan_id
    inner join users u on ps.user_id = u.id
where
    p.type = 'expertsclub'
    and plan_id = '77053ad2-b904-48bc-921f-decc7ee82638'
    and ps.canceled is false
    and ps.active is true
    and ps.ends_at > now();