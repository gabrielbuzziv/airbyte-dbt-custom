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

UNION

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
FROM users u
WHERE u.id IN ('8cd2a9c6-d97e-4dc0-b8bf-47f50b9e51fa',
'f3bbef98-9e01-4531-bd9d-1771a76f6154',
'fd7308ed-3d42-491c-974f-4d617db3ae40',
'6bf2d517-ea17-4096-a8a5-16a34b292d09',
'db67eb9c-03db-4436-8afb-b26f8cd61bc3',
'a34e8989-caf5-46bf-8ccb-d5a92f37be6b',
'7645f885-4a4a-47b2-955f-7ea5ee9fca84',
'ba083813-3e80-4ff0-ac4f-6cb6ca8b6ba4',
'e6a09c8d-b778-4473-b3c6-6edc5ccc1871',
'1fb7f6b9-0a08-4e3f-bb76-10b9b3391343',
'ae1d65ad-41d8-4848-aade-bee68a7c5e2e',
'0c10ae3b-1422-4325-9f29-149f2039282e',
'c9449cea-cb48-4335-914c-02de98203a46',
'6af6e450-1628-496a-934b-163b0da3206c',
'1396b2d9-90a9-4af5-81da-b309ee6c6b7a',
'dc337c98-9dce-4f86-9f35-206dc6c1b3a0',
'442c8855-2f1c-421e-b675-85ae8ee9b32b',
'ba7b7b9f-a32f-47fa-9b12-1f97d5192744',
'b59b9588-bc18-4071-8438-9e09a139bf00',
'910e4888-c87d-42af-a5c8-af7c51613300',
'94337fb1-8e46-428a-82af-210a78a26cbf',
'7c16a62a-2562-4f40-a8f7-d60f3ca445c3',
'eb1a63c6-ab2e-42f6-ad79-5f4890cff4a5',
'1c84fd48-ed43-4add-b8dd-49ea687835eb',
'7e36711a-78f3-4be7-9720-e2d5b132d23b',
'40936b6d-04ad-46e7-88a8-091863c8437f',
'24f3542b-8f01-42d3-8602-d659cb238150',
'02e5ba14-29eb-4d08-8bd9-985395386706',
'94d57cb4-027a-4bbe-820b-8d2c186d2329',
'9e5360d7-92fe-4ed6-b54e-87d848b492d8',
'ae87073e-1468-499d-a898-d2a0da4f28c1',
'a59b3fe9-cd57-4a27-9a99-38c35fb2f63a',
'ce3f70c6-0068-4f9d-a63d-94d784323b8b',
'36a7984d-00f5-4867-b89e-bc461a33acf2',
'25c80e90-8287-410f-aca6-e1264b56e6d7')

