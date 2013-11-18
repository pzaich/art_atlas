$ ->
  A.loadMap()
  $(window).resize () ->
      A.updateMapDimensions()
  $('#search-form').on 'ajax:beforeSend', () ->
    $('.loading').removeClass('hide')
  $('#search-form').on 'ajax:success', (status, xhr) ->
    A.updateUrl xhr.url, xhr.title 
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
        properties: {
          dialogLink: museum.dialog_link
          id : museum.id
          title : museum.name
        }
      })
      A.loadMarker(marker)
    this.markerLayer = L.featureGroup(this.markers)
    this.markerLayer.addTo(map)
    $('.loading').addClass('hide')
    $.each museums, (index, museum) ->
      A.loadMuseum(museum)
  loadMarker : (marker) ->
    this.markers.push marker
    marker.on 'click', () ->
      A.carousel.setActive(marker)
      console.log(this.options.properties.dialogLink)
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
    map.fitBounds this.markerLayer.getBounds(), ->
      map.zoomOut()
  scrollToRelatedMarker: (museum) ->
    $(museum).data('markerID')
  updateUrl : (url, title) ->
    history.pushState window.reload, title, url
}

window.A.carousel = {
  setActive : (marker) ->
    $('.museum-list > li').removeClass('active')
    $('.museum-' + marker.options.id).addClass('active')
  scrollLeft : () ->

  scrollRight : () -> 

  scrollToActive : () ->


}