{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH users AS (
  SELECT
    {{ adapter.quote('id') }},
    {{ adapter.quote('name') }},
    slug,
    avatar,
    company_name,
    occupation,
    about,
    created_at,
    updated_at
  FROM {{ ref('airbyte_users_ab3') }}
),
plan_subscriptions AS (
  SELECT
    user_id,
    plan_id,
    canceled,
    active,
    ends_at
  FROM {{ ref('airbyte_plan_subscriptions_ab3') }}
),
plans AS (
  SELECT
    {{ adapter.quote('id') }},
    {{ adapter.quote('type') }}
  FROM {{ ref('airbyte_plans_ab3') }}
)

SELECT
    u.id,
    u.id as atlas_user_id,
    u.name,
    u.slug,
    CONCAT('https://xesque.rocketseat.dev/users/avatar/', u.avatar) as avatar_url,
    u.company_name as company,
    u.occupation,
    u.about,
    u.created_at,
    u.updated_at,
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid() as _airbyte_creators_hashid
FROM plan_subscriptions ps
    INNER JOIN plans p ON p.id = ps.plan_id
    INNER JOIN users u ON ps.user_id = u.id
WHERE
    p.type = 'expertsclub'
    AND plan_id = '77053ad2-b904-48bc-921f-decc7ee82638'
    AND ps.canceled is false
    AND ps.active is true
    AND ps.ends_at > now()

