{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH lesson_history AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_ab3') }}
), lesson_list_lessons AS (
  SELECT * FROM {{ ref('airbyte_lesson_list_lessons_ab3') }}
)

SELECT 
    lll.id,
    lll.lesson_list_id as playlist_id,
    lh.id as video_id,
    lll."order",
    CASE
      WHEN lll.created_at IS NULL THEN now()
      ELSE lll.created_at
    END as created_at,
    CASE
      WHEN lll.updated_at IS NULL THEN now()
      ELSE lll.updated_at
    END as updated_at,
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid() as _airbyte_playlist_videos_hashid
FROM lesson_history lh
INNER JOIN lesson_list_lessons lll ON lll.lesson_id = lh.lesson_id
WHERE
    lh.default_experts_content = true
    AND lh.is_expert_content = true