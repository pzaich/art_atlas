ANM.controller 'MuseumCtrl', ($scope, $state, $rootScope, Museum, Painting) ->
  $scope.paintings = []
  $scope.page = 1

  $scope.getPaintings = (museum) ->
    options =
      museum_id: museum.id
      page: $scope.page
    options.query = $rootScope.search.query if $rootScope.search && $rootScope.search.query

    $scope.page++
    Painting.query options, (response) ->
      $scope.paintings =  $scope.paintings.concat(response)
      $scope.getPaintings($scope.museum) if response.length == 50


  Museum.get { id: $state.params.id }, (museum) ->
    $scope.museum = museum
    $scope.getPaintings museum
