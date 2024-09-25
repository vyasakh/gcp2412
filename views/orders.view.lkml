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
  dimension: test {
    type: string
    sql: ${TABLE}.status ;;
    html: <img src="https://www.facebook.com/ads/image/?d=AQJ3ecD9LH5MdmtKWIwpMb4-Fh7KTTc_f-MscjG1zaB60GqKpXaF2HBUSH6fjVEzoZ3GR0OVpOCCPERTlMTSrNjRPW8O2oP18FwCUxaBjzlk36AHP3eWXug630iGqNgVU_0cioFIq81VLEwcNaJCdtoW"/> ;;
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
