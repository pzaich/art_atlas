$ ->
  A.loadMap()
  $(window).resize () ->
      A.updateMapDimensions()

  $('#search-form').bind 'ajax:success', (status, xhr) ->
    A.loadMarkers(xhr.museums)

A = {
  updateMapDimensions : () ->
    $('#map-container')
      .height($(window).height() - $('.navbar').height())
      .width($(window).width())
  loadMap : () ->
    this.updateMapDimensions()
    window.map = L.map('map-container').setView([51.505, -0.09], 4)
    L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution : '<a href="http://www.openstreetmap.org/">Open Street Maps</a>'
      maxZoom: 18
    }).addTo(map)
    #map.addLayer new L.StamenTileLayer('watercolor')
    $('#search-form').trigger('submit')
  loadMarkers : (museums) ->
    window.markers = []
    $.each museums, (index, museum) ->
      markers.push L.marker([museum.latitude, museum.longitude]).addTo(map)

}