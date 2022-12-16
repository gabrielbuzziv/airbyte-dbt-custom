{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH lesson_history_tag_users AS (
  SELECT * FROM {{ ref('airbyte_lesson_history_tag_users_ab3') }}
)

SELECT
    DISTINCT ON (user_id, tag_id)
    {{ adapter.quote('id') }},
    user_id as member_id,
    tag_id,
    CASE
      WHEN created_at IS NULL THEN now()
      ELSE created_at
    END as created_at,
    CASE
      WHEN updated_at IS NULL THEN now()
      ELSE updated_at
    END as updated_at,
    gen_random_uuid() as _airbyte_ab_id,
    {{ current_timestamp() }} as _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    gen_random_uuid() as _airbyte_video_tag_followers_hashid
FROM lesson_history_tag_users
