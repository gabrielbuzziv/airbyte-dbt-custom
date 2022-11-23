{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH lesson_history AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_ab3') }}
), lesson_history_impression AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_impression_ab3') }}
)

SELECT
    lhi.id,
    lhi.lesson_history_id as video_id,
    lhi.user_id as member_id,
    CASE
        WHEN lhi.type = 'search' THEN 'SEARCH'
        WHEN 
            lhi.type = 'catalog'
            OR lhi.type ilike 'feed%'
            THEN 'CATALOG'
        WHEN lhi.type = 'history' THEN 'HISTORY'
        WHEN lhi.type = 'playlist' OR lhi.type = 'playlist-minha-lista' OR lhi.type = 'player-playlist' THEN 'PLAYLIST'
        WHEN lhi.type = 'bookmark' THEN 'BOOKMARK'
        WHEN lhi.type = 'profile' OR lhi.type = 'self-profile' THEN 'PROFILE'
        WHEN lhi.type = 'tag' THEN 'TAG'
        WHEN lhi.type = 'my-tags' THEN 'FOLLOWING_TAGS'
    END as "type",
    CASE
        WHEN 
            lhi.type ilike 'feed%' 
            OR lhi.type IN('self-profile', 'playlist-minha-lista')
        THEN lhi.type
        ELSE lhi.reference
    END as reference,
    lhi.ack as clicked,
    lhi.created_at,
    lhi.updated_at,
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid() as _airbyte_impressions_hashid
FROM lesson_history lh
INNER JOIN lesson_history_impression lhi ON lhi.lesson_history_id = lh.id
WHERE
    lh.default_experts_content = true
    AND lh.is_expert_content = true