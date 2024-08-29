
view: sql_runner1 {
  derived_table: {
    sql: SELECT
          (DATE(CONVERT_TZ(orders.created_at,'UTC','Asia/Kolkata'))) AS `orders.created_month`,
          order_items.sale_price  AS `order_items.sale_price`,
          orders.status  AS `orders.status`,
              (DATE(CONVERT_TZ(inventory_items.created_at ,'UTC','Asia/Kolkata'))) AS `inventory_items.date_start`,
              (DATE(CONVERT_TZ(inventory_items.sold_at ,'UTC','Asia/Kolkata'))) AS `inventory_items.date_end`,
          COUNT(DISTINCT orders.id ) AS `orders.count`,
          COUNT(DISTINCT products.id ) AS `products.count`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
      LEFT JOIN demo_db.inventory_items  AS inventory_items ON order_items.inventory_item_id = inventory_items.id
      LEFT JOIN demo_db.products  AS products ON inventory_items.product_id = products.id
      WHERE orders.created_at > date({% date_start  period %}) and date({% date_end period %})
      GROUP BY
          1,
          2,
          3,
          4
      ORDER BY
          5 DESC
      LIMIT 500 ;;
  }

  filter: period {  label: "Period Date" type: date }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_items_sale_price {
    type: number
    sql: ${TABLE}.`order_items.sale_price` ;;
  }

  dimension: orders_status {
    type: string
    sql: ${TABLE}.`orders.status` ;;
  }

  dimension_group: billing {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql:${TABLE}.`orders.created_month` ;;
  }


  dimension: inventory_items_start_date {
    type: date
    sql: ${TABLE}.`inventory_items.date_start` ;;
  }

  dimension: inventory_items_end_date {
    type: date
    sql: ${TABLE}.`inventory_items.date_end` ;;
  }

  dimension: orders_count {
    type: number
    sql: ${TABLE}.`orders.count` ;;
  }

  dimension: products_count {
    type: number
    sql: ${TABLE}.`products.count` ;;
  }

  set: detail {
    fields: [
        order_items_sale_price,
  orders_status,
  inventory_items_start_date,
  inventory_items_end_date,
  orders_count,
  products_count
    ]
  }
}
