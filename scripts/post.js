$(document).ready(function() {
    maketoc();
    $("nav.table-of-contents h5").click(function() {
        toggletoc();
    });
    $("#toc").hide();
});

function maketoc() {
    var toc = $("#toc");
    var h3list = $(".entry h3");
    if (h3list.length == 0)
        $(".table-of-contents").hide()
    else
        h3list.each(function() {
            var el = $(this);
            var title = el.text();
            var link = "#" + el.attr("id");
            toc.append("<li><a href='" + link + "'>" + title + "</a></li>");
        });
};

function toggletoc() {
    var toc = $("#toc");
    var icon = $("#toggle-icon");
    if (toc.is(":visible")) {
        icon.removeClass("fa-minus-circle").addClass("fa-plus-circle");
        toc.hide()
    } else {
        icon.removeClass("fa-plus-circle").addClass("fa-minus-circle");
        toc.show();
    }
}
