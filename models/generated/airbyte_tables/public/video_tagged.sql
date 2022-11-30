{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH lesson_history AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_ab3') }}
), lesson_history_lesson_history_tags AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_lesson_history_tags_ab3') }}
)

SELECT 
    lht.id, 
    lht.lesson_history_id as video_id, 
    lht.lesson_history_tag_id as tag_id,
    CASE
      WHEN lht.created_at IS NULL THEN now()
      ELSE lht.created_at
    END as created_at,
    CASE
      WHEN lht.updated_at IS NULL THEN now()
      ELSE lht.updated_at
    END as updated_at,
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid() as _airbyte_video_tags_hashid
FROM lesson_history lh
    INNER JOIN lesson_history_lesson_history_tags lht ON lh.id = lht.lesson_history_id 
WHERE
    lh.default_experts_content = true
    AND lh.is_expert_content = true