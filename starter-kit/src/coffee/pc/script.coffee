window.callback = (data) ->
    console.log data.query.random[0].title

    _iframe = document.createElement("iframe")
    _iframe.setAttribute(
        "src", "http://ja.wikipedia.org/w/index.php?curid=#{data.query.random[0].id}"
    )
    document.body.appendChild _iframe

_script = document.createElement("script")
_script.setAttribute(
    "src", "https://ja.wikipedia.org/w/api.php?format=json&action=query&list=random&" +
           "rnnamespace=0&rnlimit=1&callback=callback"
)

document.querySelector("head").appendChild _script
