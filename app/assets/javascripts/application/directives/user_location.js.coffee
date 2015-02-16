ANM.directive 'userLocation', (searchState) ->
  scope:
    currentLocation: '='
  controller: ($scope, $element, $attrs) ->
    searchState.setUserLocation($scope.currentLocation)