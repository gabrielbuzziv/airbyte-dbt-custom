{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH lesson_history AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_ab3') }}
)

SELECT 
    lh.id, 
    lh.resource as jupiter_video_id, 
    lh.author_id as creator_id, 
    lh.title, 
    lh.slug, 
    lh.description, 
    CONCAT('https://xesque.rocketseat.dev/outputs/', lh.resource, '/poster-25_0-experts.jpg') as thumbnail_url,
    lh.is_free,
    lh.unlisted as is_listed,
    lh.is_searchable,
    lh.released_at,
    lh.created_at,
    lh.updated_at,
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid() as _airbyte_videos_hashid
FROM lesson_history lh
WHERE
    lh.default_experts_content = true
    AND lh.is_expert_content = true