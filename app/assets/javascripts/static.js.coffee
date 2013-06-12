$ ->
  $('.nav-utils').tooltip()
  $('.current-location').click( (e) ->
    if (navigator.geolocation)
      navigator.geolocation.getCurrentPosition( (position) ->
        $('#location').val([position.coords.latitude, position.coords.longitude].join(','))
      )
    e.preventDefault()
  )

  $('#query').typeahead( {
    source : (typehead, query) ->
      $.getJSON($('#query').data('autocomplete-src'), {query: $('#query').val() }, (data) ->
        query(data)
      )
    }
  )

$(window).load ->
