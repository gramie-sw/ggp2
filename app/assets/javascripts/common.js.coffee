#make row clickable with changing the mouse cursor to pointer
$(document).ready ->
  $('.link-row').click (event) ->
    clicked_element = $(event.target)
    if(!clicked_element.is('input') && !clicked_element.is('a') && clicked_element.closest('a').length is 0)
      window.location = $(this).attr("data-href")

window.toggleAllCheckboxes = (link_id, container_id) ->
  link = $('#' + link_id)
  old_label = link.text()
  new_label = link.data('toggle-label')
  link.data('toggle-label', old_label)
  link.html(new_label)
  current_checked_state = !!link.data('checked-state')
  new_checked_state = !current_checked_state
  link.data('checked-state', new_checked_state)
  $('#' + container_id + ' input[type=checkbox]').prop 'checked', new_checked_state
  return