# If necessary, uncomment the line below to include explore_source.
# include: "0_vysakh_thelook.model.lkml"

view: add_a_unique_name_1723701937 {
  derived_table: {
    explore_source: orders {

      dev_filters: [orders.created_year: "2023"]
      filters: [orders.created_date: "900 days",orders.status: "COMPLETE"]
      column: status {}
      column: count {}
    }
  }
  dimension: status {
    description: ""

  }
  dimension: count {
    description: ""
    type: number
  }
}
