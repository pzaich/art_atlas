# $ ->
#   A.loadMap()
#   $(window).resize () ->
#       A.updateMapDimensions()

#   $('.btn-left').on 'click', () ->
#     A.carousel.scrollLeft()
#   $('.btn-right').on 'click', () ->
#     A.carousel.scrollRight()

window.A = {
  markers : []
  markerLayer : null
  mapHeight : () ->
    if $(window).width() < 768
      $(window).height() - $('.navbar').height()
    else
      $(window).height() - $('.navbar').height() - 140
  updateMapDimensions : () ->
    $('#map-container')
      .height(A.mapHeight())
      .width($(window).width())
  loadMap : () ->
    this.updateMapDimensions()
    console.log $('#map-container')
    window.map = L.map('map-container').setView([51.505, -0.09], 3)
    L.tileLayer('http://{s}.tiles.mapbox.com/v3/' + 'pzaich.gip3m4eo' + '/{z}/{x}/{y}.png', {
          attribution : '<a href="http://www.openstreetmap.org/">Open Street Maps</a>'
          maxZoom: 18
        }).addTo(map)
  loadMarkers : (museums) ->
    this.clearMarkers()
    $.each museums, (index, museum) ->
      marker = L.marker([museum.latitude, museum.longitude], {
        clickable : true
        title: museum.name
        properties: {
          dialogLink: museum.museum_url
          id : museum.id
          title : museum.name
        }
      })
      A.loadMarker(marker)
    this.markerLayer = L.featureGroup(this.markers)
    this.markerLayer.addTo(map)
    $('.loading').addClass('hide')
  loadMarker : (marker) ->
    # TODO refactor leaflet to angular
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
    map.setZoom(map.getZoom() - 1)
    map.setZoom(14) if map.getZoom() > 14
  scrollToRelatedMarker: (museum) ->
    $('.museum-list > li').removeClass('active')
    museum.addClass('active')
    museumId = museum.data('id')
    $.each this.markers, (index, marker) ->
      if marker.options.properties.id == museumId
        map.setView marker._latlng, 13
  loadMuseumDialogue : (dialogueBody, museum) ->
    $('.dialogue-main').html(dialogueBody)
    $(window).scrollTop(0,0)
    imagesLoaded '.dialogue-main', () ->
      $('.loading').addClass('hide')
      A.scrollToRelatedMarker(museum);
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
    offset = - $('#museum-carousel').position().left
    width = $(window).width()
    if offset > 0 && offset > width
      $('#museum-carousel').css({left: -(offset - width)})
    else
      $('#museum-carousel').css({left: 0})
  scrollRight : () ->
    offset = - $('#museum-carousel').position().left
    carouselWidth = $('#museum-carousel').width()
    width = $(window).width()
    if offset < carouselWidth
      $('#museum-carousel').css({left: -(offset + width)})
    else
      $('#museum-carousel').css({left: 0})
}