{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_lesson_history_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        adapter.quote('link'),
        'slug',
        'tags',
        'title',
        boolean_to_string('is_free'),
        'plan_id',
        'download',
        'duration',
        'platform',
        'resource',
        boolean_to_string('unlisted'),
        'author_id',
        'lesson_id',
        boolean_to_string('processed'),
        'created_at',
        'release_at',
        'station_id',
        'updated_at',
        'description',
        'featured_at',
        boolean_to_string('has_caption'),
        'challenge_id',
        boolean_to_string('is_searchable'),
        boolean_to_string('special_event'),
        'resource_input',
        boolean_to_string('is_expert_content'),
        'short_description',
        'related_journey_id',
        boolean_to_string('default_experts_content'),
        'self_evaluation_step_id',
    ]) }} as _airbyte_airbyte_lesson_history_hashid,
    tmp.*
from {{ ref('airbyte_lesson_history_ab2') }} tmp
-- airbyte_lesson_history
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

