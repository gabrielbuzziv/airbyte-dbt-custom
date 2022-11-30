{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH plan_subscriptions AS (
  SELECT * FROM {{ ref('airbyte_plan_subscriptions_ab3') }}
)

SELECT 
    {{ adapter.quote('id') }},
    user_id as member_id,
    CASE
        WHEN 
            ends_at::date - interval '1 month' >= starts_at::date
            AND ends_at::date - interval '3 month' < starts_at::date
            THEN '60365ecc-de91-42b5-96f1-4bd9b6aa870d'
        WHEN
            ends_at::date - interval '3 month' > starts_at::date
            AND ends_at::date - interval '1 year' < starts_at::date
            THEN 'cc787484-4a77-42bb-b5e5-d3775a3dd67f'
        WHEN 
            ends_at::date - interval '1 year' >= starts_at::date THEN '7f0f473c-4c43-4a43-a92b-f79b69f3fc08'
    END as pluto_plan_id,
    pluto_invoice_id,
    starts_at as start_date,
    ends_at as end_date,
    active,
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
    gen_random_uuid() as _airbyte_subscriptions_hashid
FROM plan_subscriptions