{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH lesson_history AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_ab3') }}
), lesson_history_sections AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_sections_ab3') }}
)

SELECT
    lhs.id,
    lhs.lesson_history_id as video_id,
    lhs.title,
    lhs.time,
    CASE
      WHEN lhs.created_at IS NULL THEN now()
      ELSE lhs.created_at
    END as created_at,
    CASE
      WHEN lhs.updated_at IS NULL THEN now()
      ELSE lhs.updated_at
    END as updated_at,
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid() as _airbyte_video_sections_hashid
FROM lesson_history lh
INNER JOIN lesson_history_sections lhs ON lh.id = lhs.lesson_history_id
WHERE
    lh.default_experts_content = true
    AND lh.is_expert_content = true
