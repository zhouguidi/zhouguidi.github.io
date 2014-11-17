---
---

maketoc = ->
    h3list = $(".entry h3")
    if h3list.length is 0
        $(".table-of-contents").hide()
    else
        for h3 in h3list
            $("#toc").append("<li><a href='#" + $(h3).attr("id") + "'>" + $(h3).text() + "</a></li>")

toggletoc = ->
    toc = $("#toc")
    icon = $("#toggle-icon")
    if toc.is(":visible")
        icon.removeClass("fa-minus-circle").addClass("fa-plus-circle")
        toc.hide()
    else
        icon.removeClass("fa-plus-circle").addClass("fa-minus-circle")
        toc.show()

$ ->
    maketoc()
    $("nav.table-of-contents h5").click -> toggletoc()
    $("#toc").hide()
