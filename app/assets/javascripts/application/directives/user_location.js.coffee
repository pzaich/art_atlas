ANM.directive 'userLocation', ($rootScope) ->
  scope:
    currentLocation: '='
  controller: ($scope, $element, $attrs) ->
    #refactor to integrate into future searchState service
    $rootScope.userLocation = $scope.currentLocation