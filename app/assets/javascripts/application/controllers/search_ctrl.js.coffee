ANM.controller 'SearchCtrl', ($scope, $location, $state, mapState, searchState, Museum) ->
  $scope.loadMuseums =  () ->
    searchState.saveSearch($scope.search)
    $scope.loading = true
    Museum.query $scope.search, (museums) ->
      $scope.museums = museums
      $scope.loading = false;

  $scope.homeReset = () ->
    $state.go 'home', {}, reload: true

  $scope.search = angular.copy(searchState.getCurrent())
  $scope.museums = []
  $scope.loadMuseums()
