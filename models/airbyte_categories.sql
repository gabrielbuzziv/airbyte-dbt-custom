create table airbyte.`airbyte_categories__dbt_tmp` as (
    with __dbt__cte__airbyte_categories_ab1 as (
        -- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
        -- depends_on: airbyte._airbyte_raw_airbyte_categories
        select
            json_value(_airbyte_data, '$."id"' RETURNING CHAR) as id,
            json_value(_airbyte_data, '$."type"' RETURNING CHAR) as `type`,
            json_value(_airbyte_data, '$."title"' RETURNING CHAR) as title,
            json_value(_airbyte_data, '$."icon_id"' RETURNING CHAR) as icon_id,
            json_value(
                _airbyte_data,
                '$."parent_id"' RETURNING CHAR
            ) as parent_id,
            json_value(
                _airbyte_data,
                '$."created_at"' RETURNING CHAR
            ) as created_at,
            json_value(
                _airbyte_data,
                '$."is_enabled"' RETURNING CHAR
            ) as is_enabled,
            json_value(
                _airbyte_data,
                '$."updated_at"' RETURNING CHAR
            ) as updated_at,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            CURRENT_TIMESTAMP as _airbyte_normalized_at
        from
            airbyte._airbyte_raw_airbyte_categories as table_alias -- airbyte_categories
        where
            1 = 1
    ),
    __dbt__cte__airbyte_categories_ab2 as (
        -- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
        -- depends_on: __dbt__cte__airbyte_categories_ab1
        select
            cast(id as signed) as id,
            cast(`type` as char(1024)) as `type`,
            cast(title as char(1024)) as title,
            cast(icon_id as signed) as icon_id,
            cast(parent_id as signed) as parent_id,
            cast(nullif(created_at, '') as char(1024)) as created_at,
            IF(lower(is_enabled) = 'true', true, false) as is_enabled,
            cast(nullif(updated_at, '') as char(1024)) as updated_at,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            CURRENT_TIMESTAMP as _airbyte_normalized_at
        from
            __dbt__cte__airbyte_categories_ab1 -- airbyte_categories
        where
            1 = 1
    ),
    __dbt__cte__airbyte_categories_ab3 as (
        -- SQL model to build a hash column based on the values of this record
        -- depends_on: __dbt__cte__airbyte_categories_ab2
        select
            md5(
                cast(
                    concat(
                        coalesce(cast(id as char), ''),
                        '-',
                        coalesce(cast(`type` as char), ''),
                        '-',
                        coalesce(cast(title as char), ''),
                        '-',
                        coalesce(cast(icon_id as char), ''),
                        '-',
                        coalesce(cast(parent_id as char), ''),
                        '-',
                        coalesce(cast(created_at as char), ''),
                        '-',
                        coalesce(cast(is_enabled as char), ''),
                        '-',
                        coalesce(cast(updated_at as char), '')
                    ) as char
                )
            ) as _airbyte_airbyte_categories_hashid,
            tmp.*
        from
            __dbt__cte__airbyte_categories_ab2 tmp -- airbyte_categories
        where
            1 = 1
    ) -- Final base SQL model
    -- depends_on: __dbt__cte__airbyte_categories_ab3


    SELECT
        id,
        CASE
            WHEN "type" = 'default' THEN false
            ELSE true
        END as is_residence,
        title,
        CASE
            WHEN parent_id IS NOT NULL THEN true
            ELSE false
        END as has_parent,
        _airbyte_ab_id,
        _airbyte_emitted_at,
        CURRENT_TIMESTAMP as _airbyte_normalized_at,
        _airbyte_airbyte_categories_hashid
    from
        __dbt__cte__airbyte_categories_ab3 -- airbyte_categories from airbyte._airbyte_raw_airbyte_categories
    where
        1 = 1
)

