WITH raw_json AS (
  SELECT 
    {{ json_extract_scalar('_airbyte_data', ['id', 'id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['title', 'title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['created_at', 'created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at', 'updated_at']) }} as updated_at,
  FROM {{ source('airbyte', '_airbyte_raw_airbyte_categories') }}
)

SELECT 
  CAST(id as {{ dbt_utils.type_bigint }}) as id,
  CAST(title as {{ dbt_utils.type_string() }}(1024)) as title,
  CAST({{ empty_string_to_null('created_at') as {{ type_timestamp_with_timezone }} }}) as created_at
  CAST({{ empty_string_to_null('updated_at') as {{ type_timestamp_with_timezone }} }}) as updated_at
FROM raw_json
