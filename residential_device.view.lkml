view: residential_device {
  sql_table_name: demo_db.order_items ;;

  filter: date {
    label: "date"
    datatype:timestamp
    type: date
  }

  dimension: id {
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

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;  }

  }
