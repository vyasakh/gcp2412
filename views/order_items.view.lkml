# The name of this view in Looker is "Order Items"
view: order_items {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Inventory Item ID" in Explore.

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
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: level_1 {
    label: "Level 1"
    view_label: "Level"
    sql: ${products.brand};;
    #order_by_field: dim_subtotal_measure_map.subtotal_index
    html: @{bold_detailed} ;;
  }

  dimension_group: yearmonth_dg {
    label: "Year & Month"
    view_label: "Dates"
    type: time
    datatype: date
    timeframes: [month, month_name, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }
  dimension: level_2_index {
    hidden: yes
    label: "Level 2 Index"
    view_label: "Level"
    sql:
    CASE
      WHEN ${products.category} = "Pants & Capris" THEN 1
      WHEN ${products.category} = " Skirts" THEN 2
      WHEN ${products.category} = "Tops & Tees" THEN 3
      WHEN ${products.category} = "Accessories" THEN 4
      WHEN ${products.category} = "Maternity" THEN 5
    ELSE null
    END;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  parameter: currency_selection {
    label: "Currency selection"
    description: "Allows choosing between USD, Local, AED. Use as a dashboard toggle for switching between currencies. Use with the Net Sales (Currency Combined) measure."
    view_label: "- Parameters"
    type: string
    default_value: "USD"
    allowed_value: {
      label: "USD"
      value: "USD"
    }

    allowed_value: {
      label: "Local"
      value: "Local"
    }
  }
  measure: actuals {
    label: "Actuals MTD"
    view_label: "Actuals"
    group_label: "MTD"
    type: sum
    sql:
    {% if currency_selection._parameter_value == "'Local'" %}
      ${returned_week}
    {% else %}
      ${returned_month}
    {% endif %} ;;
    value_format: "###,###,\" K\""
  }

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;  }
  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;  }
  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}
