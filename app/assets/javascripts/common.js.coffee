#make row clickable with changing the mouse cursor to pointer
$(document).ready ->
  $('.link-row-js').css('cursor', 'pointer')
  $('.link-row-js').click (event) ->
    clicked_element = $(event.target)
    window.location = $(this).attr("data-href") if not clicked_element.is("a") and clicked_element.closest("a").length is 0

window.checkAllCheckboxes = (container_id) ->
  $('#' + container_id + ' input[type =checkbox]').attr 'checked', true
  return