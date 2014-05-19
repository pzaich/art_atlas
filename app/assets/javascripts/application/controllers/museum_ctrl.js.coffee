@MuseumCtrl = ($scope, Museum) ->
  $scope.activeMuseum = null

  $scope.museums = Museum.query (response) ->
    A.loadMarkers(response)

  $scope.loadMuseums = ->
    $scope.museums = Museum.query $scope.search, (response) ->
      A.loadMarkers(response)
  $scope.loadmuseum = (museum) ->
    activeMuseum = Museum.get({ id: museum.id })

