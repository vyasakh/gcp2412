# The name of this view in Looker is "Orders"
view: orders {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at;;
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

  parameter: num_check {
    type: number
    default_value: "100"

  }

  dimension: status_check {
    type: string
    sql:
    {% assign click_thru_attribution__numeric = num_check._parameter_value | plus: 0 %}
    {% if click_thru_attribution__numeric >= 100 %}
          1
          {% elsif click_thru_attribution__numeric > 0 %}
          {{click_thru_attribution__numeric}}/100.0
          {% else %}
          0
          {% endif %}
          ;;
  }


  dimension: dynamic_date{
      label_from_parameter: dynamic_date_selector
      type: string
      description: ""
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

      group_label: "usage_date"
      order_by_field: dynamic_date_sort
    }


  dimension: dynamic_date_sort {
    hidden:  yes
    type: string
    sql:
            {% if dynamic_date_selector._parameter_value == 'day' %}
            ${created_date}
            {% elsif dynamic_date_selector._parameter_value == 'week' %}
            ${created_week}
            {% elsif dynamic_date_selector._parameter_value == 'month' %}
            ${created_month}
            {% elsif dynamic_date_selector._parameter_value == 'year'  %}
            ${created_year}
            {% else %}
            ${created_year}
            {% endif %}
            ;;
    group_label: "usage_date"

  }

  dimension: status {
    type: string

    sql: ${TABLE}.status ;;
    order_by_field: status_order
    html:
    {% if value == 'COMPLETED' %}
    <span style="color: #a0db8e; font-size:111%; text-align:center"> <b> {{ rendered_value }} </b> </span>
    {% elsif value == 'PENDING' %}
    <span style="color: #E2DF78; font-size:111%; text-align:center"> <b> {{ rendered_value }} </b> </span>
    {% elsif value == 'CANCELLED' %}
    <span style="color: #EB9474;font-size:111%; text-align:center"> <b> {{ rendered_value }} </b> </span>
    {% else %}
    <span style="color: #ff0000; font-size:111%; text-align:center"> <b> {{ rendered_value }} </b> </span>
    {% endif %} ;;
  }


  dimension: status_order {
    type: number
    sql:CASE WHEN ${TABLE}.status = "CANCELLED" then 1
            WHEN ${TABLE}.status="PENDING" then 2
            WHEN ${TABLE}.status="COMPLETED" then 3
            ELSE 4
            END;;
  }

  dimension: alerts_dim{
    label:  "The \"official\" metric"
    # drill_fields: [distributor_site_cd,inv_item_sku_id,secondary_sales_current_no_html,secondary_sales_previous_parameter]
    sql:
          {% if alerts_parameter._parameter_value == '"PENDING"' %}
          ("${status}")
          {% elsif alerts_parameter._parameter_value == 'COMPLETED' %}
          (${status})
          {% else %}
          (${status})
          {% endif %};;
  }

  parameter: alerts_parameter {
    type: unquoted
    default_value: "nothing"

    allowed_value: {
      label: "Pending_check"
      value: "PENDING"
    }
    allowed_value: {
      label: "Completed_check"
      value: "COMPLETED"
    }
    allowed_value: {
      label: "Cancelled_check"
      value: "CANCELLED"
    }
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }
  measure: count {
    type: count

    drill_fields: [detail*]
  }
  measure: sum_ID {
    type: sum
    sql: ${id};;
    value_format_name: gbp_0
  }
  measure: sum_ID_kmk{
    type: number
    sql: ((1.0* ${sum_ID}) / 1000.0);;
    value_format_name: percent_1

  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  users.id,
  users.first_name,
  users.last_name,
  billion_orders.count,
  fakeorders.count,
  hundred_million_orders.count,
  hundred_million_orders_wide.count,
  order_items.count,
  order_items_vijaya.count,
  ten_million_orders.count
  ]
  }

}
