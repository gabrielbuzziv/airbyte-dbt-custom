SELECT
  id,
  CASE
    WHEN "type" = 'default' THEN false
    ELSE true
  END as is_residence,
  title
FROM {{ ref('airbyte_categories_ab3') }}