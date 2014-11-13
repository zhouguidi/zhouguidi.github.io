$(document).ready(function(){
    //
    // in-site search functionality
    // input box initial hide
    $("#searchinput").hide();
    // input box auto hides when losing focus and empty
    $("#searchinput").blur(function() {
        if ($("#searchinput").val() == "")
            $("#searchinput").hide();
    });
    // search button hover -> bring out the input box
    $("#searchbutton").mouseenter(function() {
        $("#searchinput").show().focus();
    });
    // search button leave -> hide the input box if empty
    $("#searchbutton").mouseleave(function() {
        if ($("#searchinput").val() == "" )
            $("#searchinput").hide();

    });

    //
    // make sure the footer stays at bottom for short pages
    anchor_bottom();
});

//
// anchor the footer to page bottom if document is smaller
function anchor_bottom() {
    if ($(document).height() <= $(window).height())
        $(".footer").css("position", "absolute").css("bottom", "0").css("left", "0").css("right", "0");
}
