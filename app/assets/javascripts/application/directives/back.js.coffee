ANM.directive 'back', ($window) ->
  link: (scope, element, attrs) ->
    element.on 'click', () ->
      $window.history.back()