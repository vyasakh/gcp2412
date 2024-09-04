view: sweta_test {

    dimension: test_id {
      primary_key: yes
      type: number
      sql: ${TABLE}.id ;;
    }

    dimension: sale_price {
      type: number
      sql: ${TABLE}.sale_price ;;
    }


    measure: average_sale_price {
      type: average
      sql: ${sale_price} ;;
    }


  }
