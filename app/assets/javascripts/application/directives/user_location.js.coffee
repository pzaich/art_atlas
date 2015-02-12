ANM.directive 'userLocation', ($rootScope) ->
  scope:
    currentLocation: '='
  controller: ($scope, $element, $attrs) ->
    console.log $scope.currentLocation
    $rootScope.userLocation = $scope.currentLocation #refactor to integrate into future searchState service