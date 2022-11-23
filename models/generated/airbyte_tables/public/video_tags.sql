{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH lesson_history_tags AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_tags_ab3') }}
)

SELECT 
    {{ adapter.quote('id') }},
    {{ adapter.quote('name') }} as title,
    slug,
    created_at,
    updated_at,
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid() as _airbyte_video_tags_hashid
FROM lesson_history_tags