# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
  data = $("#index_graph").data("var")
  new Chart($("#index_graph").get(0).getContext("2d")).Radar(data)

  pie_data = $("#perf_index_graph").data("var")
  new Chart($("#perf_index_graph").get(0).getContext("2d")).Doughnut(pie_data)
