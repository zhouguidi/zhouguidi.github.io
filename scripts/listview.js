$(document).ready(function() {
    //
    // table-sort functionality using jquery.tablesort
    $("#posttable").tablesorter({theme: "blue", sortList: [[1, 1]]});
    //
    // table-filtering functionality
    // input tags change -> filter
    $("#input-tags").bind("input change", function(){filter("tags")}).trigger("input");
    // input policy change -> filter
    $("#input-policy").bind("input change", function(){filter("policy")}).trigger("input");
    // input start date change -> filter
    $("#input-start-date").bind("input change", function(){filter("start-date")}).trigger("input");
    // input end date change -> filter
    $("#input-end-date").bind("input change", function(){filter("end-date")}).trigger("input");
    // clear button click -> reset
    $("#button-clear").click(function(){
        $("#input-tags").val("");
        $("#input-start-date").val("");
        $("#input-end-date").val("");
        filter(); // filter again to bring out all posts
    }).click();  // initial filter by calling click
});

// test native datepicker support
$(function() {
    if (!Modernizr.inputtypes['date']) {
        $('input[type=date]').datepicker({
            dateFormat: 'yy-mm-dd'
        });
    }
});

// filter posts according to tags, start and end time
function filter(origin) {
    // get user-input tags
    // seperater is [ ,;] -- blank, comma and semicolon
    // empty string removed by .filter(Boolean)
    var tags = $("#input-tags").val().split(/[ ,;]/g).filter(Boolean);
    // get tag combination policy
    // if only one tag, use the easier "or" policy
    var tagpolicy = tags.length == 1 ? "or" : $("#input-tags-policy").val();
    // get tag/date combination policy
    var policy = $("#input-policy").val();
    // get start and end date
    // don't have to worry about format, since either native or jquery-ui datepicker takes care of it
    var startdate = Date.parse($("#input-start-date").val());
    var enddate = Date.parse($("#input-end-date").val());
    if (isNaN(startdate) && isNaN(enddate)) policy = "and";
    
    // clear error message
    $("#error-text").html("");
    // output error message if start and end dates conflict
    if (startdate > enddate)
        $("#error-text").html("start date is later than end date")
    // output error message if start and end dates are invalid (just in case)
    if ($.trim($("#input-start-date").val()) != "" && isNaN(startdate))
        $("#error-text").html("invalid start date")
    if ($.trim($("#input-end-date").val()) != "" && isNaN(enddate))
        $("#error-text").html("invalid end date")

    // loop through every post item
    $("tr.post-list").each(function() {
        // get the post's tags. same role as above
        var thistags = $(this).data("tags").split(/[ ,;]/g).filter(Boolean);
        // flag: whether the post should be selected by tag matching
        var tagsel = false;
        // flag: whether the post should be selected by date interval
        var datesel = false;
        // flag: whether the post should be selected by both/either of the critiera
        var sel = false;

        // if no tags are input -> select all
        if (tags.length == 0 || tags.length == 1 && tags[0] == "")
            tagsel = true
        // if there are indeed some tags input
        else
            // determine whether current post's tags match user input
            // if any of the input tags should appear
            if (tagpolicy == "or") {
                // build a regex like /^(tag1|tag2|...)/i
                // to match any of the input tags case-insensitively
                var re = new RegExp("^(" + tags.join("|") + ")", "i");
                // test all the current post's tags against the regex
                // if any of the tags matches the regex, select the post
                tagsel = $.inArray(true, $.map(thistags, function(t) { 
                    return re.test(t); 
                })) != -1;
            // if all of the input tags should appear
            } else {
                // build a series of regex like /^tag1/i, /^tag2/i, ...
                var regs = $.map(tags, function(t) { return new RegExp("^" + t, "i"); });
                // for each of the regexs, test all the current post's tags, if any of them matchs,
                // consider this regex to be "successful". if all regexes are successful, select
                // the post
                tagsel = $.inArray(false, $.map(regs, function(r) {
                    return $.inArray(true, $.map(thistags, function(t) { 
                        return r.test(t); 
                    })) != -1;
                })) == -1;
            }

        // when policy is "and", a failure in tagsel is already enough to determine a total failure
        // this should save time
        if (policy == "and" && tagsel == false)
            datesel = false
        // when policy is "or", a success in tagsel is already enough to determine a total success
        // this should also save time
        else if (policy == "or" && tagsel == true)
            datesel = true
        else {
            // get the current post's date
            var thisdate = Date.parse($(this).data("date"));
            // flag: the post's date is later than start date?
            var later; 
            // flag: the post's date is earlier than end date?
            var earlier;
            // if startdate not given, assume thousands of years ago
            later = isNaN(startdate) ? true : thisdate >= startdate;
            // if enddate not given, assume thousands of years later
            earlier = isNaN(enddate) ? true : thisdate <= enddate;
            if (later && earlier)
                datesel = true;
        }

        // combine the two flags according to the policy
        sel = policy == "or" ? tagsel || datesel : tagsel && datesel
        // hide or show the current post
        if (sel)
            $(this).show();
        else
            $(this).hide();
    });

    // sometimes the result page gets smaller, so have to anchor the footer again
    anchor_bottom();
}
