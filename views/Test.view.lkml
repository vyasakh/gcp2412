# If necessary, uncomment the line below to include explore_source.
# include: "0_vysakh_thelook.model.lkml"

view: add_a_unique_name_1723701937 {
  derived_table: {
    explore_source: orders {

      dev_filters: [orders.created_date: "10 years"]
      filters: [orders.created_date: "15 years",orders.status: "COMPLETE"]
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
