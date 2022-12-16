{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH creator_feedback_status AS (
  SELECT * FROM {{ ref('airbyte_creator_feedback_status_ab3') }}
)

SELECT
    {{ adapter.quote('id') }},
    user_id as member_id,
    creator_id,
    CASE
        WHEN status = 'waiting-banner-three-days' THEN 'WAITING_BANNER_MORE_THREE_DAYS'
        WHEN status = 'waiting-user-watch-two-more-lessons' THEN 'WAITING_WATCH_TWO_MORE_VIDEOS'
        WHEN status = 'feedback-received' THEN 'RECEIVED'
        ELSE 'WAITING_FEEDBACK'
    END as status,
    feedback_modal_showed as modal_showed,
    feedback_banner_showed as banner_showed,
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
    gen_random_uuid() as _airbyte_creator_feedback_status_hashid
FROM creator_feedback_status