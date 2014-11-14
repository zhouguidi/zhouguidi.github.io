---
---

$ ->
    #
    # in-site search functionality
    # input box initial hide
    $("#searchinput").hide()
    # input box auto hides when losing focus and empty
    $("#searchinput").blur =>
        if $("#searchinput").val() is ""
            $("#searchinput").hide()
    # search button hover -> bring out the input box
    $("#searchbutton").mouseenter =>
        $("#searchinput").show().focus()
    # search button leave -> hide the input box if empty
    $("#searchbutton").mouseleave =>
        if $("#searchinput").val() is ""
            $("#searchinput").hide()

    #
    # make sure the footer stays at bottom for short pages
    $(document).resize =>
        $(".footer").css("position", "relative")
        if $(document).height() <= $(window).height()
            $(".footer").css("position", "absolute").css("bottom", "0").css("left", "0").css("right", "0")
    $(document).resize()
