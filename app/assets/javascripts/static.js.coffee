$ ->
  $('.nav-utils').tooltip()

  $('.current-location').toggle (e) ->
    $('#detect_location').prop('checked', true)
    $('#location').val('').hide()
    e.preventDefault()
  , (e) ->
    $('#detect_location').prop('checked', true)
    $('#location').show()
    e.preventDefault()

  do -> 
    if ($('#detect_location').val() == 'on')
      $('.current-location').trigger('click');