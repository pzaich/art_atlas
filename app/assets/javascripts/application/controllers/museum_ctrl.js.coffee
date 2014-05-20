ANM.controller 'MuseumCtrl', ($scope, Museum) ->
  $scope.activeMuseum = null

  $scope.museums = Museum.query (museums) ->
    A.loadMarkers(museums)
    A.setMapCenter(museums)

  $scope.loadMuseums = ->
    $scope.museums = Museum.query $scope.search, (museums) ->
      A.loadMarkers(museums)
      A.setMapCenter(museums)

  $scope.showMuseum = (museum) ->
    activeMuseum = Museum.get { id: museum.id }
