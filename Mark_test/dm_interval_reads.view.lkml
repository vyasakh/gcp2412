view: dm_interval_reads {

  derived_table: {
    publish_as_db_view: yes
    sql:
    SELECT
      order_id,
     order_status,
      total_sale_price
    FROM
      demo_db.orders dd
    ;;

  }


  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  parameter: dynamic_date {
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

  dimension: dynamic_date1{
    type: string
    sql:
          {% if dynamic_date._parameter_value == 'day' %}
          ${created_date}
          {% elsif dynamic_date._parameter_value == 'week' %}
          ${created_week}
          {% elsif dynamic_date._parameter_value == 'month' %}
          (DATE_FORMAT(${created_date}, '%b %y'))
          {% elsif dynamic_date._parameter_value == 'year'  %}
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

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
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


