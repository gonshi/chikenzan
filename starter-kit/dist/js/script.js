var _script;window.callback=function(e){var t;return console.log(e.query.random[0].title),t=document.createElement("iframe"),t.setAttribute("src","http://ja.wikipedia.org/w/index.php?curid="+e.query.random[0].id),document.body.appendChild(t)},_script=document.createElement("script"),_script.setAttribute("src","https://ja.wikipedia.org/w/api.php?format=json&action=query&list=random&rnnamespace=0&rnlimit=1&callback=callback"),document.querySelector("head").appendChild(_script);