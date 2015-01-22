# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('body').on 'click', '.artist-specific', ->
    $('.loading').removeClass('hide')
  $('body').on 'click', '#toggle-other-artists', (e) ->
    e.preventDefault()
    currentText = $(this).text()
    $(this).text($(this).data('alt-text'))
    $(this).data('alt-text', currentText)
    if $(this).data('toggled') == false
      $('.other-artist').removeClass('hidden-phone')
      $(this).data('toggled', true)
    else
      $('.other-artist').addClass('hidden-phone')
      $(this).data('toggled', false)
