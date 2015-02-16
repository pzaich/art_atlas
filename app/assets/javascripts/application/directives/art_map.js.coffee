ANM.directive 'artMap', ($window, $state, mapState) ->
  scope: true
  controller: ($scope, $element, $attrs) ->
  link: (scope,element, attrs) ->
    mapHeight = () ->
      $(window).height() - $('.navbar').height()
    updateMapDimensions = () ->
      width = $($window).width()
      element.height(mapHeight())
      if width > 768
        element
          .width(width - 0.3 * width)
      else
        element.width(width)
    loadMap = () ->
      updateMapDimensions()
      scope.map = L.map('map-container')
      layer = L.tileLayer 'http://{s}.tiles.mapbox.com/v3/' + 'pzaich.gip3m4eo' + '/{z}/{x}/{y}.png'
      ,
        attribution : '<a href="http://www.openstreetmap.org/">Open Street Maps</a>'
        maxZoom: 18
      .addTo(scope.map)
      scope.map.setView([51.505, -0.09], 3)

      scope.map.on 'zoomend', () ->
        mapState.setState(scope.map)

      scope.map.on 'dragend', () ->
        mapState.setState(scope.map)

    loadMarkers = (museums) ->
      clearMarkers()
      $.each museums, (index, museum) ->
        marker = L.marker [museum.latitude, museum.longitude]
        ,
          clickable : true
          title: museum.name
          properties:
            id : museum.id
            title : museum.name

        loadMarker(marker)
      if (scope.markers.length > 0)
        scope.markerLayer = L.featureGroup(scope.markers)
        scope.markerLayer.addTo(scope.map)
        setMapCenter()
    loadMarker = (marker) ->
      scope.markers.push marker
      marker.on 'click', () ->
        $state.go('museum', { id: this.options.properties.id})
    clearMarkers = () ->
      scope.map.removeLayer(scope.markerLayer) if scope.markerLayer
      scope.markers = []
    setMapCenter = () ->
      # need to update mapcenter only on new queries
      if scope.markerLayer && scope.markerLayer._map && mapState.current
        scope.map.setView([mapState.current.coords.lat, mapState.current.coords.lng] , mapState.current.zoom)
      else if scope.markerLayer && scope.markerLayer._map
        scope.map.fitBounds scope.markerLayer.getBounds()
        scope.map.setZoom(scope.map.getZoom() - 1)
        scope.map.setZoom(14) if scope.map.getZoom() > 14

    scope.map = null
    scope.markerLayer = null
    scope.markers = []

    loadMap()

# TODO clean up listeners when scope destroyed
    $($window).resize () ->
      updateMapDimensions()

    scope.$watchCollection 'museums'
    , (newMuseums) ->
      loadMarkers(newMuseums)
    # scrollToRelatedMarker: (museum) ->
    #   museumId = museum.data('id')
    #   $.each scope.markers, (index, marker) ->
    #     if marker.options.properties.id == museumId
    #       scope.map.setView marker._latlng, 13

