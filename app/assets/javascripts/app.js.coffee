window.ANM = angular.module('artNear.me', ['ngResource', 'ui.router', 'ui.bootstrap', 'wu.masonry'])

# routes
.config ($stateProvider, $urlRouterProvider, $locationProvider) ->
  $stateProvider
    .state('home', {
      url: '/'
      templateUrl: '/static/home.html'
      controller: 'SearchCtrl'
    })
    .state('museum', {
      url: '/museums/:id'
      templateUrl: '/museums/show.html'
      controller: 'MuseumCtrl'
    })
  $locationProvider.html5Mode(true)

  $urlRouterProvider.rule ($injector, $location) ->
    path = $location.url()

    # check to see if the path has a trailing slash
    return path.replace(/\/$/, "")  if "/" is path[path.length - 1]
    return path.replace("/?", "?")  if path.indexOf("/?") > 0
    false
.run ($rootScope) ->
  $rootScope.loading = false