{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_plan_subscriptions_ab3') }}


with plans as (
    select
        {{ adapter.quote('id') }},
        {{ adapter.quote('type') }}
    from {{ ref('airbyte_plans_ab3') }}
), plan_subscriptions as (
    select
        canceled,
        active,
        ends_at,
        plan_id
    from {{ ref('airbyte_plan_subscriptions_ab3') }}
),
users as (
    select
        {{ adapter.quote('id') }},,
        {{ adapter.quote('name') }},,
        slug,
        avatar,
        company_name,
        occupation,
        about,
        created_at,
        updated_at
    from {{ ref('airbyte_users_ab3') }}
)

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
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid()::text as _airbyte_airbyte_users_hashid
from plan_subscriptions ps
    inner join plans p on p.id = ps.plan_id
    inner join users u on ps.user_id = u.id
where
    p.type = 'expertsclub'
    and plan_id = 'd9648630-7d8f-418a-be27-285f9e7d4c0f'
    and ps.canceled is false
    and ps.active is true
    and ps.ends_at > now();
