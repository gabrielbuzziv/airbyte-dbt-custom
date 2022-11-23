{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH lesson_history AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_ab3') }}
), lesson_downloads AS (
  SELECT * FROM {{ ref('airbyte_lesson_downloads_ab3') }}
)

SELECT
    ld.id,
    ld.lesson_history_id as video_id,
    ld.title,
    concat('https://xesque.rocketseat.dev/platform/', file ) as file,
    ld.created_at,
    ld.updated_at,
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid() as _airbyte_video_files_hashid
FROM lesson_downloads ld
INNER JOIN lesson_history lh ON ld.lesson_history_id = lh.id
WHERE
    lh.default_experts_content = true
    AND lh.is_expert_content = true
