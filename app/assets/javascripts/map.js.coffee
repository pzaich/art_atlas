$ ->
  A.loadMap()
  $(window).resize () ->
      A.updateMapDimensions()
  $('#search-form').on 'ajax:beforeSend', () ->
    $('.loading').removeClass('hide')
    $('.museum-list > li').remove()
  $('#search-form').on 'ajax:success', (status, xhr) ->
    $('.alert').remove()
    A.updateUrl xhr.url, xhr.title
    if xhr.museums.length > 0
      A.loadMarkers(xhr.museums)
      A.setMapCenter(xhr.museums)
    else
      A.clearMarkers()
      $('.loading').addClass('hide')
      $('body').prepend(xhr.flash_message)  
  $('body').on 'click', '.museum-list > li, .zoom-to-marker', (e) ->
    e.preventDefault()
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
        title: museum.name
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
    A.carousel.setMuseumListWidth()
  loadMarker : (marker) ->
    this.markers.push marker
    marker.on 'click', () ->
      $('.loading').removeClass('hide')
      A.carousel.setActive(this)
      $.ajax({
        url: this.options.properties.dialogLink
        dataType: 'script'
      })
  clearMarkers : () ->
    map.removeLayer(this.markerLayer) if this.markerLayer != null
    this.markers = []      
  loadMuseum : (museum) ->
    $('#museum-carousel').append museum.infobox
  setMapCenter: (museums) ->
    map.fitBounds this.markerLayer.getBounds()
    map.setZoom(14) if map.getZoom() > 14
  scrollToRelatedMarker: (museum) ->
    $('.museum-list > li').removeClass('active')
    $(museum).addClass('active')
    museumId = $(museum).data('id')
    $.each this.markers, (index, marker) ->
      if marker.options.properties.id == museumId
        map.panTo marker._latlng
        map.setZoom(16)
  updateUrl : (url, title) ->
    history.pushState window.reload, title, url
  loadMuseumDialogue : (dialogueBody) ->
    $('#full-map').addClass('blurred')
    $('.overlay, .dialogue').show()
    $('.dialogue-main').html(dialogueBody)
}

window.A.carousel = {
  setActive : (marker) ->
    $('.museum-list > li').removeClass('active')
    $('.museum-' + marker.options.properties.id).addClass('active')
  setMuseumListWidth: () ->
    totalWidth = 0
    $('#museum-carousel > li').each (index) ->
        totalWidth += parseInt($(this).outerWidth(), 10)
    $('#museum-carousel').width(totalWidth)
  scrollLeft : () ->
    $(window)

  scrollRight : () ->

  scrollToActive : () ->



}