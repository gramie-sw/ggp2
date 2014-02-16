#make row clickable with changing the mouse cursor to pointer
$(document).ready ->
  $('.link-row-js').css('cursor', 'pointer')
  $('.link-row-js').click (event) ->
    clicked_element = $(event.target)
    if(!clicked_element.is('input') && !clicked_element.is('a') && clicked_element.closest('a').length is 0)
      window.location = $(this).attr("data-href")


window.checkAllCheckboxes = (container_id) ->
  $('#' + container_id + ' input[type =checkbox]').attr 'checked', true
  return