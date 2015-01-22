window.ANM = angular.module('ANM', ['ngResource', 'ngRoute'])

# routers
window.ANM.config ($routeProvider) ->
  $routeProvider.
    when('/',
      template: 'assets/templates/static/home',
      controller: 'MuseumCtrl'
    ).when('/museums',
      template: '/assets/templates/museums/show'
      controller: 'MuseumCtrl'
    ).otherwise redirectTo: '/'

