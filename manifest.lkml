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
visualization: {
  id: "Collapsible"
  label: "Collapsible"
  file: "visualization/Collapsible.js"
}

visualization: {
  id: "spider-marketplace-dev"
  label: "Spider Viz"
  url: "https://marketplace-api.looker.com/viz-dist/spider.js"
 # sri_hash: "oqVuAfXRKap7fdgcCY5uykM6+R9GqQ8K/uxy9rx7HNQlGYl1kPzQho1wx4JwY8wC"
  #dependencies: ["https://code.jquery.com/jquery-2.2.4.min.js","https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.9.1/underscore-min.js","https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.6/d3.min.js","https://cdnjs.cloudflare.com/ajax/libs/d3-legend/1.13.0/d3-legend.min.js"]
}
visualization: {
  id: "Liquid_fill"
  label: "Liquid_fill"
  url: "https://looker-custom-viz-a.lookercdn.com/master/liquid_fill_gauge.js"
  #sri_hash: "oqVuAfXRKap7fdgcCY5uykM6+R9GqQ8K/uxy9rx7HNQlGYl1kPzQho1wx4JwY8wC"
  #dependencies: ["https://code.jquery.com/jquery-2.2.4.min.js","https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.9.1/underscore-min.js","https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.6/d3.min.js","https://cdnjs.cloudflare.com/ajax/libs/d3-legend/1.13.0/d3-legend.min.js"]
}
visualization: {
  id: "Sankeyyyyy"
  label: "Sankeyyyyyy"
  url: "https://looker-custom-viz-a.lookercdn.com/master/sankey.js"
  #sri_hash: "oqVuAfXRKap7fdgcCY5uykM6+R9GqQ8K/uxy9rx7HNQlGYl1kPzQho1wx4JwY8wC"
  #dependencies: ["https://code.jquery.com/jquery-2.2.4.min.js","https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.9.1/underscore-min.js","https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.6/d3.min.js","https://cdnjs.cloudflare.com/ajax/libs/d3-legend/1.13.0/d3-legend.min.js"]
}
visualization: {
  id: "Sunburst"
  label: "Sunbursty"
  url: "https://looker-custom-viz-a.lookercdn.com/master/sunburst.js"
  #sri_hash: "oqVuAfXRKap7fdgcCY5uykM6+R9GqQ8K/uxy9rx7HNQlGYl1kPzQho1wx4JwY8wC"
  #dependencies: ["https://code.jquery.com/jquery-2.2.4.min.js","https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.9.1/underscore-min.js","https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.6/d3.min.js","https://cdnjs.cloudflare.com/ajax/libs/d3-legend/1.13.0/d3-legend.min.js"]
}

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }
