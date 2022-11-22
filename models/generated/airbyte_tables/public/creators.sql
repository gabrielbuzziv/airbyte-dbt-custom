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
    u.updated_at
from {{ ref('airbyte_plan_subscriptions_ab3') }} ps
    inner join {{ ref('airbyte_plans_ab3') }} p on p.id = ps.plan_id
    inner join {{ ref('airbyte_users_ab3') }} u on ps.user_id = u.id
where
    p.type = 'expertsclub'
    and plan_id = '77053ad2-b904-48bc-921f-decc7ee82638'
    and ps.canceled is false
    and ps.active is true
    and ps.ends_at > now();