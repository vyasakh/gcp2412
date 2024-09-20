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


  parameter: order_granularity {
    type: unquoted

    allowed_value: {
      value: "Date_Only"
    }
    allowed_value: {
      value: "Date_and_Source"
    }
    default_value: "Date_Only"
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Status" in Explore.
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    }


  dimension: statusassign {
    type: string
    sql: ${TABLE}.status ;;
    html: {% assign total_id = user_id._value %}
          {% if total_id < 2000 %} Hidden {% else %} {{rendered_value}} {% endif %} ;;

  }
  dimension: statushtml {
    type: string
    sql: ${TABLE}.status ;;
    html:
        {% if status._value == 'pending' %}
        <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
        {% elsif status._value == 'complete' %}
        <p style="color: black; background-color: green; font-size:100%; text-align:center">{{ rendered_value }}</p>
        {% elsif status._value == 'cancelled' %}
        <p style="color: black; background-color: pink; font-size:100%; text-align:center">{{ rendered_value }}</p>
        {% else %}
        <p style="color: black; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
        {% endif %}
        ;;
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
