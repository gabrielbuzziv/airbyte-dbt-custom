{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH technologies AS (
  SELECT * FROM {{ ref('airbyte_technologies_ab3') }}
)

SELECT 
    {{ adapter.quote('id') }},
    {{ adapter.quote('name') }},
    slug,
    concat('https://xesque.rocketseat.dev/platform/tech/', image) as image_url,
    created_at,
    updated_at,
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid() as _airbyte_expertises_hashid
FROM technologies