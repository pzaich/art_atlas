$ ->
  A.loadMap()
  $(window).resize () ->
      A.updateMapDimensions()
  $('#search-form').on 'ajax:beforeSend', () -> 
    $('.loading').removeClass('hide')
  $('#search-form').on 'ajax:success', (status, xhr) ->
    $('.loading').addClass('hide')
    A.loadMarkers(xhr.museums)
    #A.setMapCenter()
    A.setMuseumListWidth()
    console.log "museums loaded"

window.A = {
  updateMapDimensions : () ->
    $('#map-container')
      .height($(window).height() - $('.navbar').height() - 260)
      .width($(window).width())
  loadMap : () ->
    this.updateMapDimensions()
    window.map = L.map('map-container').setView([51.505, -0.09], 2)
    L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution : '<a href="http://www.openstreetmap.org/">Open Street Maps</a>'
      maxZoom: 18
    }).addTo(map)
    #map.addLayer new L.StamenTileLayer('watercolor')
    $('#search-form').trigger('submit')
  loadMarkers : (museums) ->
    $('#museum-carousel').html('')
    this.clearMarkers()  
    $.each museums, (index, museum) ->
      marker = L.marker([museum.latitude, museum.longitude], {
        clickable : true
        id : museum.id
        title : museum.name
      })
      A.loadMarker(marker)
      A.loadMuseum(museum)
  loadMarker : (marker) ->
    marker.addTo(map)
    markers.push marker
    marker.on 'click', () ->
      $('.museum-' + marker.options.id).addClass('active')
      alert(marker.options.title)

  clearMarkers : () ->
    if typeof window.markers != 'undefined'
      $.each window.markers, (index, marker) -> 
        map.removeLayer(marker)
    window.markers = []
  loadMuseum : (museum) ->
    $('#museum-carousel').append museum.infobox
  setMuseumListWidth: () ->
    totalWidth = 0
    $('#museum-carousel > li').each (index) ->
        totalWidth += parseInt($(this).width(), 10)
    $('#museum-carousel').width(totalWidth)
  setMapCenter: () ->
    #need markerCluster group http://stackoverflow.com/questions/15206863/centering-map-on-array-of-markers-bounds-leaflet
    #scroll to center http://stackoverflow.com/questions/12735303/how-to-change-the-map-center-in-leaflet
} 