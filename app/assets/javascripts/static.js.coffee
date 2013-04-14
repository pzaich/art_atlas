$ ->
  $('.nav-utils').tooltip()
  do ->
    if (navigator.geolocation)
      navigator.geolocation.getCurrentPosition( (position) ->
        if $('#location').val() == ''
          $('#location').val([position.coords.latitude, position.coords.longitude].join(','))

      )