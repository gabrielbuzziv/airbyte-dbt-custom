{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}

WITH user_technologies AS (
  SELECT * FROM {{ ref('airbyte_user_technologies_ab3') }}
), plan_subscriptions AS (
  SELECT * FROM {{ ref('airbyte_plan_subscriptions_ab3') }}
), plans AS (
  SELECT * FROM {{ ref('airbyte_plans_ab3') }}
), users AS (
  SELECT * FROM {{ ref('airbyte_users_ab3') }}
)

SELECT 
    {{ adapter.quote('id') }},
    user_id as creator_id,
    technology_id as expertise_id,
    CASE
      WHEN created_at IS NULL THEN now()
      ELSE created_at
    END as created_at,
    CASE
      WHEN updated_at IS NULL THEN now()
      ELSE updated_at
    END as updated_at,
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid() as _airbyte_creator_expertises_hashid
FROM user_technologies
WHERE user_id IN (
    SELECT
        u.id
    FROM plan_subscriptions ps
        inner join plans p on p.id = ps.plan_id
        inner join users u on ps.user_id = u.id
    WHERE
        p.type = 'expertsclub'
        AND plan_id = '77053ad2-b904-48bc-921f-decc7ee82638'
        AND ps.canceled is false
        AND ps.active is true
        AND ps.ends_at > now()
)