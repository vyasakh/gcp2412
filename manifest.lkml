project_name: "0_vysakh_thelook"

constant: bold_detailed {
  value:
  "{% if financial_report.level_1._value == 'Net Sales'
  or financial_report.level_1._value == 'Shop Profit'
  or financial_report.level_1._value == 'Gross Margin'
  or financial_report.level_1._value == 'Contribution To Profit'
  or financial_report.level_1._value == 'Operating profit'
  or financial_report.level_1._value == 'GSOP'
  or financial_report.level_1._value == 'Profit Before Tax'
  or financial_report.level_1._value == 'Net Profit After Tax' %}
  <b> {{rendered_value}} </b>
  {% else %}
  {{rendered_value}}
  {% endif %}"
}





# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }
