ANM.controller 'SearchCtrl', ($scope, $location, Museum) ->
  $scope.search =
    query: $location.search().query
  $scope.loadMuseums = ->
    $scope.museums = Museum.query $scope.search
    $location.search 'query', $scope.search.query if $scope.search.query
    $location.search 'location', $scope.search.location if $scope.search.location

  $scope.loadMuseums()
