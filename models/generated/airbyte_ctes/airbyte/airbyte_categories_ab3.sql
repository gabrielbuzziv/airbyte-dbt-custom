{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_categories_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        adapter.quote('type'),
        'title',
        'icon_id',
        'parent_id',
        'created_at',
        boolean_to_string('is_enabled'),
        'updated_at',
    ]) }} as _airbyte_airbyte_categories_hashid,
    tmp.*
from {{ ref('airbyte_categories_ab2') }} tmp
-- airbyte_categories
where 1 = 1

