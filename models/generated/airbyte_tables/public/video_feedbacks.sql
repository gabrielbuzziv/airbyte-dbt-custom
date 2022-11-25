{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH lesson_history AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_ab3') }}
), lesson_history_feedback_stars AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_feedback_stars_ab3') }}
), lesson_history_feedbacks AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_feedbacks_ab3') }}
)

SELECT
    lhfs.id,
    lhfs.lesson_history_id as video_id,
    lhfs.user_id as member_id,
    lhfs.stars as reaction,
    CASE
        WHEN lhfs.stars = 5 THEN 'VERY_GOOD'
        WHEN lhfs.stars = 4 THEN 'GOOD'
        WHEN lhfs.stars = 2 THEN 'BAD'
        WHEN lhfs.stars = 1 THEN 'TOO_BAD'
        ELSE 'REGULAR'
    END as reaction,
    lhfs.time,
    lhf.additional_information as comment,
    CASE
      WHEN lhfs.created_at IS NULL THEN now()
      ELSE lhfs.created_at
    END as created_at,
    CASE
      WHEN lhfs.updated_at IS NULL THEN now()
      ELSE lhfs.updated_at
    END as updated_at,
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid() as _airbyte_video_feedbacks_hashid
FROM lesson_history lh
INNER JOIN lesson_history_feedback_stars lhfs ON lhfs.lesson_history_id = lh.id
LEFT JOIN lesson_history_feedbacks lhf ON lhf.lesson_history_id = lhfs.lesson_history_id 
                                       AND lhf.user_id = lhfs.user_id
WHERE
    lh.default_experts_content = true
    AND lh.is_expert_content = true
    AND lhf.additional_information IS NOT NULL
