connection: "thelook"
include: "/Mark_test/district_device.view.lkml"
include: "/Mark_test/residential_device.view.lkml"
include: "/Mark_test/rm_interval_reads.view.lkml"
include: "/Mark_test/orders1.view.lkml"
include: "/Mark_test/dm_interval_reads.view.lkml"

  explore: district_device {
    join: dm_interval_reads {
      type: left_outer
      relationship: one_to_many
      sql_on: ${district_device.test_id} = ${dm_interval_reads.test_id};;
    }

    join: residential_device {
      type: inner
      relationship: one_to_many
      sql_on: ${district_device.test_id}=${residential_device.test_id} ;;
    }

    join: rm_interval_reads {
      type: inner
      relationship: one_to_many
      sql_on: ${residential_device.test_id} = ${rm_interval_reads.test_id};;
    }

    join: orders1 {
      type: left_outer
      relationship: one_to_many
      sql_on: ${orders1.id} = ${dm_interval_reads.test_id};;
    }

   }
