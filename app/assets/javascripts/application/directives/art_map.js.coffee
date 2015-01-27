ANM.directive 'artMap', ($window) ->
  scope: true
  controller: ($scope, $element, $attrs) ->
    $scope.goToMuseum = () ->
      # loadMuseumDialogue : (dialogueBody, museum) ->
      #   $('.dialogue-main').html(dialogueBody)
      #   $(window).scrollTop(0,0)
      #   imagesLoaded '.dialogue-main', () ->
      #     $('.loading').addClass('hide')
      #     A.scrollToRelatedMarker(museum)
  link: (scope,element, attrs) ->
    mapHeight = () ->
      $(window).height() - $('.navbar').height()
    updateMapDimensions = () ->
      width = $($window).width()
      element.height(mapHeight())
      if width > 768
        element
          .width(width - 0.2 * width)
      else
        element.width(width)
    loadMap = () ->
      updateMapDimensions()
      map = L.map('map-container').setView([51.505, -0.09], 3)
      L.tileLayer 'http://{s}.tiles.mapbox.com/v3/' + 'pzaich.gip3m4eo' + '/{z}/{x}/{y}.png'
      ,
        attribution : '<a href="http://www.openstreetmap.org/">Open Street Maps</a>'
        maxZoom: 18
      .addTo(map)

    loadMarkers = (museums) ->
      clearMarkers()
      $.each museums, (index, museum) ->
        marker = L.marker [museum.latitude, museum.longitude]
        ,
          clickable : true
          title: museum.name
          properties:
            dialogLink: museum.museum_url
            id : museum.id
            title : museum.name

        A.loadMarker(marker)
      markerLayer = L.featureGroup(markers)
      markerLayer.addTo(map)
      # $('.loading').addClass('hide')

    loadMarker = (marker) ->
      # TODO refactor leaflet to angular
      markers.push marker
      marker.on 'click', () ->
        # I think this is just used to load the museum data
        # $('.loading').removeClass('hide')
        # A.carousel.setActive(this)
        # $.ajax({
        #   url: this.options.properties.dialogLink
        #   dataType: 'script'
        # })

    clearMarkers = () ->
      map.removeLayer(this.markerLayer) if markerLayer
      markers = []
    # loadMuseum : (museum) ->
    #   $('#museum-carousel').append museum.infobox
    setMapCenter: (museums) ->
      map.fitBounds this.markerLayer.getBounds()
      map.setZoom(map.getZoom() - 1)
      map.setZoom(14) if map.getZoom() > 14
    scrollToRelatedMarker: (museum) ->
      museumId = museum.data('id')
      $.each this.markers, (index, marker) ->
        if marker.options.properties.id == museumId
          map.setView marker._latlng, 13

    map = null
    markerLayer = null
    markers = []

    loadMap()

    $($window).resize () ->
      updateMapDimensions()



