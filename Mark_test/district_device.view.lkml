view: district_device {
  sql_table_name: demo_db.orders ;;

  parameter: dynamic_date_selector {
    type: string

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


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      test_id,
      users.id,
    ]
  }


  }
