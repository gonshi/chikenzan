###
_req = new XMLHttpRequest()
_req.onreadystatechange = ->
    if _req.readyState == XMLHttpRequest.DONE
        if _req.status == 200
            console.log _req.responseText

_req.open(
    "get",
    "https://ja.wikipedia.org/w/api.php?format=json&action=query&list=random&rnnamespace=0&rnlimit=1",
    true
)
_req.send()
###

$.ajax
    dataType: 'jsonp'
    url: "https://ja.wikipedia.org/w/api.php?format=json&action=query&list=random&rnnamespace=0&rnlimit=1"
.done (data) ->
    $("<iframe>").addClass("wiki").
    attr(src: "http://ja.wikipedia.org/w/index.php?curid=#{data.query.random[0].id}").
    appendTo ".contents"
    console.log data.query.random[0].title
