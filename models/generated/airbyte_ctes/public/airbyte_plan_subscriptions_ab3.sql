{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_plan_subscriptions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        boolean_to_string('active'),
        'coupon',
        'ends_at',
        'plan_id',
        'team_id',
        'user_id',
        boolean_to_string('canceled'),
        boolean_to_string('untagged'),
        'starts_at',
        'created_at',
        'updated_at',
        'purchase_id',
        'pluto_invoice_id',
    ]) }} as _airbyte_airbyte_plan_subscriptions_hashid,
    tmp.*
from {{ ref('airbyte_plan_subscriptions_ab2') }} tmp
-- airbyte_plan_subscriptions
where 1 = 1

