@MuseumCtrl = ($scope, Museum) ->
  $scope.museums = Museum.query (response) ->
    A.loadMarkers(response)

  $scope.loadMuseums = ->
    $scope.museums = Museum.query $scope.search, (response) ->
      A.loadMarkers(response)
  $scope.loadmuseum = -> (museum)

