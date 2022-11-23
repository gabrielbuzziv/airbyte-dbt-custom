{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH lesson_history AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_ab3') }}
), lesson_history_tag_users AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_tag_users_ab3') }}
), lesson_history_lesson_history_tags AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_lesson_history_tags_ab3') }}
)

SELECT
    lhtu.id,
    lhtu.user_id as member_id,
    lhtu.tag_id,
    lhtu.created_at,
    lhtu.updated_at,
    null as deleted_at,
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid() as _airbyte_video_tag_followers_hashid
FROM lesson_history_tag_users lhtu
INNER JOIN lesson_history_lesson_history_tags lht ON lht.lesson_history_tag_id = lhtu.tag_id
INNER JOIN lesson_history lh ON lh.id = lht.lesson_history_id
WHERE
    lh.default_experts_content = true
    AND lh.is_expert_content = true
