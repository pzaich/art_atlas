ANM.controller 'MuseumCtrl', ($scope, $state, $rootScope, Museum, Painting) ->
  $scope.getPaintings = (museum) ->
    options =
      museum_id: museum.id
    options.query = $rootScope.search.query if $rootScope.search && $rootScope.search.query

    $scope.paintings = Painting.query options

  Museum.get { id: $state.params.id }, (museum) ->
    $scope.museum = museum
    $scope.getPaintings museum
