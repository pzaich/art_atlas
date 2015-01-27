ANM.controller 'SearchCtrl', ($scope, Museum) ->
  $scope.loadMuseums = ->
    $scope.museums = Museum.query $scope.search
  $scope.loadMuseums()
