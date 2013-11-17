$ ->
  A.loadMap()
  $(window).resize () ->
      A.updateMapDimensions()
  $('#search-form').on 'ajax:beforeSend', () -> 
    $('.loading').removeClass('hide')
  $('#search-form').on 'ajax:success', (status, xhr) ->
    $('.loading').addClass('hide')
    A.loadMarkers(xhr.museums)
    A.setMapCenter(xhr.museums)
    A.setMuseumListWidth()
    
  $('body').on 'click', '.museum-list > li', () ->
    A.scrollToRelatedMarker(this)

window.A = {
  markers : []
  markerLayer : null
  updateMapDimensions : () ->
    $('#map-container')
      .height($(window).height() - $('.navbar').height() - 140)
      .width($(window).width())
  loadMap : () ->
    this.updateMapDimensions()
    window.map = L.map('map-container').setView([51.505, -0.09], 3)
    map.addLayer new L.StamenTileLayer('toner-lite')
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
    this.markerLayer = L.layerGroup(this.markers)
    this.markerLayer.addTo(map)
  loadMarker : (marker) ->
    this.markers.push marker
    marker.on 'click', () ->
      A.carousel.setActive(marker)
  clearMarkers : () ->
    map.removeLayer(this.markerLayer) if this.markerLayer != null
    this.markers = []      
  loadMuseum : (museum) ->
    $('#museum-carousel').append museum.infobox
  setMuseumListWidth: () ->
    totalWidth = 0
    $('#museum-carousel > li').each (index) ->
        totalWidth += parseInt($(this).width(), 10)
    $('#museum-carousel').width(totalWidth)
  setMapCenter: (museums) ->
    # bounds = $.map museums, (museum, i) -> 
    #   return [museum.latitude, museum.longitude ]
    # bounds = new L.LatLngBounds bounds
    # map.fitBounds bounds
    #need markerCluster group http://stackoverflow.com/questions/15206863/centering-map-on-array-of-markers-bounds-leaflet
    #scroll to center http://stackoverflow.com/questions/12735303/how-to-change-the-map-center-in-leaflet
  scrollToRelatedMarker: (museum) ->
    $(museum).data('markerID')
}

window.A.carousel = {
  setActive : (marker) ->
    $('.museum-list > li').removeClass('active')
    $('.museum-' + marker.options.id).addClass('active')
  scrollLeft : () ->

  scrollRight : () -> 

  scrollToActive : () ->


}