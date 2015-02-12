ANM.controller 'SearchCtrl', ($scope, $location, $rootScope, $state, Museum) ->
  $scope.search =
    query: $location.search().query
    location: $location.search().location || $rootScope.userLocation.city || $rootScope.userLocation.country
  $scope.loadMuseums = ->
    $scope.loading = true
    Museum.query $scope.search, (museums) ->
      $scope.museums = museums
      $scope.loading = false;
    $location.search 'query', $scope.search.query if $scope.search.query
    $location.search 'location', $scope.search.location if $scope.search.location
    $scope.pushQuery()

  $scope.homeReset = ->
    $state.go 'home', {}, reload: true

  $scope.pushQuery = () ->
    $rootScope.search =
      query: $scope.search.query

  $scope.museums = []
  $scope.loadMuseums()
