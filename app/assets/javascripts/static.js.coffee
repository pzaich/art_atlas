$ ->
  $('.nav-utils').tooltip()
  $('.current-location').click( (e) ->
    if (navigator.geolocation)
      navigator.geolocation.getCurrentPosition( (position) ->
        if $('#location').val() == ''
          $('#location').val([position.coords.latitude, position.coords.longitude].join(','))

      )
    e.preventDefault()
  )
    