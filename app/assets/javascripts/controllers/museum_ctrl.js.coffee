@MuseumCtrl = ($scope, Museum) ->
  $scope.museums = Museum.query (response) -> 
    A.loadMarkers(response)

  $scope.loadMuseums = ->
