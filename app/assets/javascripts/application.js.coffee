#= require jquery
#= require plugins/jquery.mobile.custom.min
#= require rails-ujs
#= require turbolinks
#= require bootstrap-sprockets

root = exports ? this
if !root.TBL
    root.TBL = {}

TBL.scrollTo = (destination) ->
    $target = $(destination)
    if $target.length
        currentPosition = $(document).scrollTop()
        destinationPostion = Math.ceil $target.offset().top
        if destinationPostion > $('#menu').offset().top
            destinationPostion -= $('#menu').height()
        speed = Math.floor(Math.abs(currentPosition - destinationPostion) / 2)
        $('html,body').animate { scrollTop: destinationPostion }, speed
    return

watchMenuLinks = ->
    $('a[href^="#"]').off('click').click ->
        TBL.scrollTo $(this).attr('href')
        closeMenu()
        false

noSpam = ->
    $('a[data-mail]').off('click').click ->
        href = 'mailto:' + $(this).data('mail') + '@' + $(this).data('domain')
        $(this).attr('href', href)
    return

setMenuFixation = ->
    $('#menu').affix offset:
        top: $('#menu').offset().top
        bottom: null
    
resetMenuFixation = ->
    $('#menu').data('bs.affix').options.offset.top = $('#menu').offset().top
    $('#menu').affix 'checkPosition'

reInitBootStrap = ->
    $(document).off('.data-api')
    $('[data-toggle="collapse"][data-target]').off('click').click ->
        target = $(this).data 'target'
        $('.collapse.in:not(' + target + ')' ).collapse 'hide'
        $(target).collapse 'toggle'


burgerMenu = ->
    $menu = TBL.menu
    menuWidth = 250
    breakPoint = 992

    $(window).resize ->
        if $(window).width() >= breakPoint and $menu.attr('style')
            $menu.stop().removeAttr 'style'
            $(document).off('click').off('swiperight')
        else if $(window).width() < breakPoint and !$menu.attr('style')
            $menu.stop().css width: 0
        return

    $('a#burger-menu').off('click').click ->
        if $menu.width() == 0
            $menu.stop().animate { width: menuWidth }, ->
                $menu.addClass 'open'
                $(document).on 'swiperight', ->
                    $(document).off('click')
                    $menu.stop().animate width: 0, 200
                    $menu.removeClass 'open'
                    return
                $(document).one 'click', ->
                    $(document).off('swiperight')
                    $menu.stop().animate width: 0
                    $menu.removeClass 'open'
                    return
                return
        return
    return

closeMenu = ->
    $menu = TBL.menu
    if $menu.hasClass('open') and $menu.width() > 0
        $(document).off('click')
        $menu.stop().animate width: 0
        $menu.removeClass 'open'
        reInitBootStrap
        return


init = ->
    TBL.menu = $('#menu > .main > nav')

    watchMenuLinks()
    noSpam()
    setMenuFixation()
    reInitBootStrap()
    burgerMenu()

    $(window).resize ->
        resetMenuFixation()

        

$(document).on 'turbolinks:load', init