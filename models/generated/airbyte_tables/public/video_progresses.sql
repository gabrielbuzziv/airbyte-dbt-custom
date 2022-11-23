{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH lesson_history AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_ab3') }}
), creator_feedback_status AS (
  SELECT * FROM {{ ref('airbyte_creator_feedback_status_ab3') }}
), watched_lessons AS (
    SELECT id, user_id, UNNEST(watched_lessons_ids) as lesson_id, created_at, updated_at FROM creator_feedback_status
)

SELECT
    gen_random_uuid() as id,
    lh.id as video_id,
    wl.user_id as member_id,
    wl.created_at as watched_at,
    wl.created_at,
    wl.updated_at,
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid() as _airbyte_video_progresses_hashid
FROM watched_lessons wl
INNER JOIN lesson_history lh ON lh.lesson_id::uuid = wl.lesson_id::uuid
