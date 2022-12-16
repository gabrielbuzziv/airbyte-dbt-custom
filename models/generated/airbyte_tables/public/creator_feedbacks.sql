{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}


WITH creator_feedbacks AS (
  SELECT * FROM {{ ref('airbyte_creator_feedbacks_ab3') }}
)

SELECT
    {{ adapter.quote('id') }},
    null as creator_feedback_status_id,
    CASE
        WHEN subject_mastery = 'too-bad' THEN 'TOO_BAD'
        WHEN subject_mastery = 'bad' THEN 'BAD'
        WHEN subject_mastery = 'regular' THEN 'REGULAR'
        WHEN subject_mastery = 'good' THEN 'GOOD'
        WHEN subject_mastery = 'very-good' THEN 'VERY_GOOD'
    END as subject_mastery,
    CASE
        WHEN oratory_diction = 'too-bad' THEN 'TOO_BAD'
        WHEN oratory_diction = 'bad' THEN 'BAD'
        WHEN oratory_diction = 'regular' THEN 'REGULAR'
        WHEN oratory_diction = 'good' THEN 'GOOD'
        WHEN oratory_diction = 'very-good' THEN 'VERY_GOOD'
    END as oratory_diction,
    CASE
        WHEN didactic = 'too-bad' THEN 'TOO_BAD'
        WHEN didactic = 'bad' THEN 'BAD'
        WHEN didactic = 'regular' THEN 'REGULAR'
        WHEN didactic = 'good' THEN 'GOOD'
        WHEN didactic = 'very-good' THEN 'VERY_GOOD'
    END as didactic,
    CASE
        WHEN content_arrangement = 'too-bad' THEN 'TOO_BAD'
        WHEN content_arrangement = 'bad' THEN 'BAD'
        WHEN content_arrangement = 'regular' THEN 'REGULAR'
        WHEN content_arrangement = 'good' THEN 'GOOD'
        WHEN content_arrangement = 'very-good' THEN 'VERY_GOOD'
    END as content_arrangement,
    CASE
        WHEN production_equipment = 'too-bad' THEN 'TOO_BAD'
        WHEN production_equipment = 'bad' THEN 'BAD'
        WHEN production_equipment = 'regular' THEN 'REGULAR'
        WHEN production_equipment = 'good' THEN 'GOOD'
        WHEN production_equipment = 'very-good' THEN 'VERY_GOOD'
    END as production_equipment,
    additional_information as comment,
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
    gen_random_uuid() as _airbyte_impressions_hashid
FROM creator_feedbacks