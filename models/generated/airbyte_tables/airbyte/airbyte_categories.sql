{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "airbyte",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_categories_ab3') }}
select
    id,
    title,
    created_at,
    is_enabled,
    updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_categories_hashid
from {{ ref('airbyte_categories_ab3') }}
-- airbyte_categories from {{ source('airbyte', '_airbyte_raw_airbyte_categories') }}
where 1 = 1

