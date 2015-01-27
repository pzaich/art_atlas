ANM.controller 'MuseumCtrl', ($scope, Museum) ->
  # $scope.activeMuseum = null
  # $scope.isActiveMuseum = ->
  #   $scope.activeMuseum

  $scope.loadMuseums = ->
    $scope.museums = Museum.query $scope.search, (museums) ->
      A.loadMarkers(museums)
      A.setMapCenter(museums)
  $scope.loadMuseums()

  # $scope.showMuseum = (museum) ->
  #   $scope.activeMuseum = Museum.get { id: museum.id }
