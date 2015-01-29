ANM.directive 'sticky-top', ($window, $document, $timeout) ->
  link: (scope, element, attrs) ->
    # element $window is not binding
    # todo come back
    angular.element($window).bind 'scroll', ->
      if $window.scrollTop() >= verticalDistance
        element.addClass('fixed')
      else
        element.removeClass('fixed')