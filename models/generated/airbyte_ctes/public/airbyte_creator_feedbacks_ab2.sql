{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('airbyte_creator_feedbacks_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast(user_id as {{ dbt_utils.type_string() }}) as user_id,
    cast(didactic as {{ dbt_utils.type_string() }}) as didactic,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(creator_id as {{ dbt_utils.type_string() }}) as creator_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(oratory_diction as {{ dbt_utils.type_string() }}) as oratory_diction,
    cast(subject_mastery as {{ dbt_utils.type_string() }}) as subject_mastery,
    cast(content_arrangement as {{ dbt_utils.type_string() }}) as content_arrangement,
    cast(production_equipment as {{ dbt_utils.type_string() }}) as production_equipment,
    cast(additional_information as {{ dbt_utils.type_string() }}) as additional_information,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_creator_feedbacks_ab1') }}
-- airbyte_creator_feedbacks
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

