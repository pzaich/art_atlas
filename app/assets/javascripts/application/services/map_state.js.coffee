ANM.factory "mapState", () ->
  mapState = {}

  mapState.setState = (map) ->
    this.current =
      coords: map.getCenter()
      zoom: map.getZoom()

  mapState.clear = () ->
    delete this.current;

  mapState