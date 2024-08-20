view: rm_interval_reads {
  derived_table: {
    publish_as_db_view: yes
    sql:
    SELECT
      user_id,
      status,
      CASE
        WHEN {{ dynamic_date_selector._parameter_value }} = 'day' THEN DATE_TRUNC('day', created_at)
        WHEN {{ dynamic_date_selector._parameter_value }} = 'week' THEN DATE_TRUNC('week', created_at)
        WHEN {{ dynamic_date_selector._parameter_value }} = 'month' THEN DATE_TRUNC('month', created_at)
        WHEN {{ dynamic_date_selector._parameter_value }} = 'year' THEN DATE_TRUNC('year', created_at)
      END AS period,
      COUNT(id) AS order_count
    FROM
      demo_db.orders
    GROUP BY
      user_id, status, period;;
      }

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  parameter: dynamic_date_selector {
    type: unquoted

    default_value: "day"
    allowed_value: {
      label: "By Day"
      value: "day"
    }
    allowed_value: {
      label: "By Week"
      value: "week"
    }
    allowed_value: {
      label: "By Month"
      value: "month"
    }
    allowed_value: {
      label: "By Year"
      value: "year"

    }
  }


  dimension: dynamic_date{
    label_from_parameter: dynamic_date_selector
    type: string
    sql:
          {% if dynamic_date_selector._parameter_value == 'day' %}
          ${created_date}
          {% elsif dynamic_date_selector._parameter_value == 'week' %}
          ${created_week}
          {% elsif dynamic_date_selector._parameter_value == 'month' %}
          (DATE_FORMAT(${created_date}, '%b %y'))
          {% elsif dynamic_date_selector._parameter_value == 'year'  %}
          ${created_year}
          {% else %}
          ${created_year}
          {% endif %}
          ;;
          }

  dimension: test_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: phones {
    type: string
    sql: ${TABLE}.phones ;;
  }


  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;  }

  measure: Max_sale_price {
    type: max
    sql: ${sale_price} ;;  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;  }

  measure: count {
    type: count
    drill_fields: [test_id, orders.id, inventory_items.id]
  }

  }
