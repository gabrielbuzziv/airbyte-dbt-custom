{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH lesson_history AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_ab3') }}
), playlists AS (
  SELECT * FROM {{ ref('airbyte_playlists_ab3') }}
), playlist_lessons AS (
  SELECT * FROM {{ ref('airbyte_playlist_lessons_ab3') }}
)

SELECT 
    pl.id,
    lh.id as video_id,
    p.user_id as member_id,
    now() as created_at,
    now() as updated_at,
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid() as _airbyte_bookmarks_hashid
FROM playlists p 
INNER JOIN playlist_lessons pl ON p.id = pl.playlist_id
INNER JOIN lesson_history lh ON pl.lesson_id = lh.lesson_id
WHERE
    p.slug = 'minha-lista'
    AND lh.default_experts_content = true
    AND lh.is_expert_content = true