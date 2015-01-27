# $ ->
#   A.loadMap()
#   $(window).resize () ->
#       A.updateMapDimensions()

#   $('.btn-left').on 'click', () ->
#     A.carousel.scrollLeft()
#   $('.btn-right').on 'click', () ->
#     A.carousel.scrollRight()

window.A = {

}

window.A.carousel = {
  setActive : (marker) ->
    $('.museum-list > li').removeClass('active')
    $('.museum-' + marker.options.properties.id).addClass('active')
  setMuseumListWidth: () ->
    totalWidth = 0
    $('#museum-carousel > li').each (index) ->
        totalWidth += parseInt($(this).outerWidth(), 10)
    $('#museum-carousel').width(totalWidth)
  scrollLeft : () ->
    offset = - $('#museum-carousel').position().left
    width = $(window).width()
    if offset > 0 && offset > width
      $('#museum-carousel').css({left: -(offset - width)})
    else
      $('#museum-carousel').css({left: 0})
  scrollRight : () ->
    offset = - $('#museum-carousel').position().left
    carouselWidth = $('#museum-carousel').width()
    width = $(window).width()
    if offset < carouselWidth
      $('#museum-carousel').css({left: -(offset + width)})
    else
      $('#museum-carousel').css({left: 0})
}