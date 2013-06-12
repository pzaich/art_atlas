$ ->
  A.loadMap()
  $(window).resize () ->
      A.updateMapDimensions()

  $('#search-form').bind 'ajax:success', (status, xhr) ->
    console.log(xhr)


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
    #map.addLayer 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png''
    $('#search-form').trigger('submit')


}