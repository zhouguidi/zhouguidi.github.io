---
---

# filter posts according to tags, start and end time
filter = ->
    # get user-input tags
    # seperater is [ ,;] -- blank, comma and semicolon
    # empty string removed by .filter(Boolean)
    tags = $("#input-tags").val().split(/[ ,;]/g).filter Boolean
    # get tag combination policy
    # if only one tag, use the easier "or" policy
    tagpolicy = if tags.length is 1 then "or" else $("#input-tag-policy").val()
    # get tag/date combination policy
    policy = $("#input-policy").val()
    # get start and end date
    # don't have to worry about format, since either native or jquery-ui datepicker takes care of it
    startdate = Date.parse $("#input-start-date").val()
    enddate = Date.parse $("#input-end-date").val()
    policy = "and" if isNaN(startdate) and isNaN(enddate)

    # clear error message
    $("#error-text").html ""
    # output error message if start and end dates conflict
    if startdate > enddate
        $("#error-text").html "start date is later than end date"
    # output error message if start and end dates are invalid (just in case)
    if $.trim($("#input-start-date").val()) isnt "" and isNaN(startdate)
        $("#error-text").html "invalid start date"
    if $.trim($("#input-end-date").val()) isnt "" and isNaN(enddate)
        $("#error-text").html "invalid end date"

    # loop through every post item
    for post in $("tr.post-list")
        # get the post's tags. same role as above
        thistags = $(post).data("tags").split(/[ ,;]/g).filter Boolean
        # flag: whether the post should be selected by tag matching
        tagsel = false
        # flag: whether the post should be selected by date interval
        datesel = false
        # flag: whether the post should be selected by both/either of the critiera
        sel = false

        # if no tags are input -> select all
        if (tags.length is 0) or (tags.length is 1 and tags[0] is "")
            tagsel = true
        # if there are indeed some tags input
        else
            # determine whether current post's tags match user input
            # if any of the input tags should appear
            if tagpolicy is "or"
                # build a regex like /^(tag1|tag2|...)/i
                # to match any of the input tags case-insensitively
                re = new RegExp("^(" + tags.join("|") + ")", "i")
                # test all the current post's tags against the regex
                # if any of the tags matches the regex, select the post
                tagsel = thistags.some (tag) -> re.test tag
            # if all of the input tags should appear
            else
                # build a series of regex like /^tag1/i, /^tag2/i, ...
                regs = (new RegExp("^" + t, "i") for t in tags)
                # for each of the regexs, test all the current post's tags, if any of them matchs,
                # consider this regex to be "successful". if all regexes are successful, select
                # the post
                tagsel = regs.every (r) -> thistags.some (t) -> r.test t

        # when policy is "and", a failure in tagsel is already enough to determine a total failure
        # this should save time
        if policy is "and" and tagsel is false
            datesel = false
        # when policy is "or", a success in tagsel is already enough to determine a total success
        # this should also save time
        else
            if policy is "or" and tagsel is true
                datesel = true
            else
                # get the current post's date
                thisdate = Date.parse($(post).data("date"))
                # if startdate not given, assume thousands of years ago
                later = if isNaN(startdate) then true else thisdate >= startdate
                # if enddate not given, assume thousands of years later
                earlier = if isNaN(enddate) then true else thisdate <= enddate
                datesel = true if later and earlier

        # combine the two flags according to the policy
        sel = if policy is "or" then tagsel or datesel else tagsel and datesel
        # hide or show the current post
        if sel
            $(post).show()
        else
            $(post).hide()

    $(document).resize()

$ ->
    #
    # table-sort functionality using jquery.tablesort
    $("#posttable").tablesorter
        theme: "blue"
        sortList: [[1, 1]]
    #
    # table-filtering functionality
    # input tags change -> filter
    $("#input-tags").bind("input change", -> filter()).trigger "input"
    # input tag policy change -> filter
    $("#input-tag-policy").bind("input change", -> filter()).trigger "input"
    # input start date change -> filter
    $("#input-start-date").bind("input change", -> filter()).trigger "input"
    # input end date change -> filter
    $("#input-end-date").bind("input change", -> filter()).trigger "input"
    # input policy change -> filter
    $("#input-policy").bind("input change", -> filter()).trigger "input"
    # clear button click -> reset
    $("#button-clear").click ->
        $("#input-tags").val ""
        $("#input-start-date").val ""
        $("#input-end-date").val ""
        filter() # filter again to bring out all posts
    $("#button-clear").click()  # initial filter by calling click

    # test native datepicker support
    if not Modernizr.inputtypes['date']
        $('input[type=date]').datepicker dateFormat: 'yy-mm-dd'
