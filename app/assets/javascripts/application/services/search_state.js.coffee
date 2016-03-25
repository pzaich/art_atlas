ANM.factory "searchState", ($location, mapState, $rootScope) ->

  setLocation = (search) ->
    $location.search('query', search.query) if search.query
    $location.search('location', search.location) if search.location

  searchState = {}

  searchState.current = {}

  searchState.getCurrent = ->
    defaults =
      query: searchState.current.query
      location: this.getLocation()

    angular.copy(angular.extend(defaults, $location.search(), this.current))

  searchState.getLocation = ->
    searchState.current.location || this.locationFallback()

  searchState.locationFallback = ->
    (this._userLocation.city || this._userLocation.country_name) if this._userLocation

  searchState.setUserLocation = (userLocation) ->
    this._userLocation = userLocation

  searchState.saveSearch = (search) ->
    angular.extend(this.current, search)
    setLocation(search)

  $rootScope.$watch ->
    searchState.current
  , (newState, previousState) ->
    if !angular.equals(newState, previousState)
      mapState.clear()
  , true

  searchState