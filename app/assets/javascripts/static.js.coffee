$ ->
  $('.nav-utils').tooltip()
  $('.current-location').click( (e) ->
    if (navigator.geolocation)
      navigator.geolocation.getCurrentPosition( (position) ->
        $('#location').val([position.coords.latitude, position.coords.longitude].join(','))
      )
    e.preventDefault()
  )

  $('.gmaps4rails_map')
    