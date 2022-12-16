{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH plan_subscriptions AS (
  SELECT * FROM {{ ref('airbyte_plan_subscriptions_ab3') }}
), plans AS (
  SELECT * FROM {{ ref('airbyte_plans_ab3') }}
), users AS (
  SELECT * FROM {{ ref('airbyte_users_ab3') }}
), user_followers AS (
  SELECT * FROM {{ ref('airbyte_user_followers_ab3') }}
)

SELECT
    uf.id,
    uf.followed_id as member_id,
    uf.follower_id as creator_id,
    CASE
      WHEN uf.created_at IS NULL THEN now()
      ELSE uf.created_at
    END as created_at,
    CASE
      WHEN uf.updated_at IS NULL THEN now()
      ELSE uf.updated_at
    END as updated_at,
    null as deleted_at,
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid() as _airbyte_creator_followers_hashid
FROM plan_subscriptions ps
INNER JOIN plans p ON p.id = ps.plan_id
INNER JOIN users u ON ps.user_id = u.id
INNER JOIN user_followers uf ON uf.followed_id = u.id
WHERE
    p.type = 'expertsclub'
    AND plan_id = '77053ad2-b904-48bc-921f-decc7ee82638'
    AND ps.canceled IS false
    AND ps.active IS true
    AND ps.ends_at > NOW()