# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
  $("#publish").click (event) ->
    event.preventDefault()
    $("#user_published").val("t")
    $("form:first").submit()

  $("#delete_selected").click (event) ->
    event.preventDefault()
    if (!confirm("Are you sure?"))
      return
    selected = []
    c = 0
    form = $('#bulk_delete_form')

    $('#clients_table input:checked').each ->
      field = $('<input name="user_ids[]" id="user_ids_" type="hidden">').val($(this).val())
      form.append(field)
      c = c + 1
    if c > 0
      form.submit()
#  data = $("#index_graph").data("var")
#  new Chart($("#index_graph").get(0).getContext("2d")).Radar(data)
#
#  pie_data = $("#perf_index_graph").data("var")
#  new Chart($("#perf_index_graph").get(0).getContext("2d")).Doughnut(pie_data)
#
#  ankle_data = $("#ankle_graph").data("var")
#  new Chart($("#ankle_graph").get(0).getContext("2d")).Line(ankle_data, {
#    pointDot : false,
#    scaleShowVerticalLines: false,
#    datasetStroke : false,
#    datasetFill : false,
#    responsive: true
#  })
#
#  bar_data = $("#bar_graph").data("var")
#  bar_chart = new Chart($("#bar_graph").get(0).getContext("2d")).Bar(bar_data, {
#    responsive: true
#  })
#  bar_chart.resize()
