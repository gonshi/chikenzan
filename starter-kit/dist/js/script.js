var Main;new(Main=function(){function t(){this.head=document.querySelector("head"),this.social_txt=document.querySelector(".social_txt"),this.social=document.querySelector(".social"),this.social_btns={tweet:document.querySelector(".tweet"),facebook:document.querySelector(".facebook"),hatena:document.querySelector(".hatena"),gplus:document.querySelector(".gplus"),link:document.querySelector(".link")},this.social_btn=document.querySelector(".social_btn"),this.link_balloon=document.querySelector(".link_balloon"),this.exec()}return t.prototype.popup=function(t){var e,n,i,o,c,r,a,l,s;return null!=window.screenLeft?(e=window.screenLeft,n=window.screenTop):(e=window.screen.left,n=window.screen.top),null!=window.innerWidth?(l=window.innerWidth,a=window.innerHeight):null!=(null!=(s=document.documentElement)?s.clientWidth:void 0)?(l=document.documentElement.clientWidth,l=document.documentElement.clientHeight):(l=window.screen.width,l=window.screen.height),c=800,o=600,i=l/2-c/2+e,r=a/2-o/2+n,window.open(t,"popup","width="+c+", height="+o+", "+("top="+r+", left="+i))},t.prototype.setSocial=function(){var t,e,n;return t=469711053215641,e=document.getElementsByTagName("script")[0],n=document.createElement("script"),n.id="facebook-jssdk",n.src="//connect.facebook.net/ja_JP/sdk.js#xfbml=1&"+("appId="+t+"&version=v2.0"),e.parentNode.insertBefore(n,e),this.social_btns.facebook.addEventListener("click",function(t){return function(){return FB.ui({method:"share",href:t.url})}}(this)),this.social_btns.tweet.addEventListener("click",function(t){return function(){var e;return t.extract.length>80-t.title.length&&(t.extract=t.extract.slice(0,80-t.title.length)+"..."),e=t.title+" - "+t.extract,t.popup("http://twitter.com/share?url="+t.url+"&text="+encodeURIComponent(e)+"&hashtags=知見山")}}(this)),this.social_btns.hatena.addEventListener("click",function(t){return function(){return t.popup("http://b.hatena.ne.jp/add?url="+t.url+"&title="+t.title)}}(this)),this.social_btns.gplus.addEventListener("click",function(t){return function(){return t.popup("https://plus.google.com/share?url="+t.url)}}(this))},t.prototype.exec=function(){var t,e;return this.social_btn.addEventListener("click",function(t){return function(){return t.social.getAttribute("class").match("is_show")?t.social.classList.remove("is_show"):(t.social.classList.add("is_show"),t.social_txt.select())}}(this)),this.social_btns.link.addEventListener("click",function(t){return function(){var e,n,i;if(t.social_btns.link.getAttribute("class").match("is_active"))t.social_btns.link.classList.remove("is_active");else{t.social_btns.link.classList.add("is_active"),t.social_btns.link.innerHTML=t.url,e=document.createRange(),e.selectNode(t.social_btns.link),window.getSelection().addRange(e);try{document.execCommand("copy"),t.link_balloon.classList.add("is-show"),clearTimeout(t.balloon_timer),t.balloon_timer=setTimeout(function(){return t.link_balloon.classList.remove("is-show")},3e3)}catch(i){n=i,console.log(n)}window.getSelection().removeAllRanges()}return t.social_txt.select()}}(this)),window.detail_callback=function(t){return function(e){var n;for(n in e.query.pages)return t.extract=e.query.pages[n].extract.replace(/[\n\r]/g,""),t.title=e.query.pages[n].title,void t.social_txt.setAttribute("value",t.title+" - "+t.url)}}(this),window.list_callback=function(t){return function(e){var n,i;return t.url="http://"+t.lang+".wikipedia.org/w/index.php?curid="+e.query.random[0].id,n=document.createElement("iframe"),n.setAttribute("src",t.url),n.onload=function(){return t.social_btn.style.display="block"},document.body.appendChild(n),i=document.createElement("script"),i.setAttribute("src","https://"+t.lang+".wikipedia.org/w/api.php?format=json&action=query&"+("titles="+e.query.random[0].title+"&prop=extracts&redirects=1&")+"exchars=130&explaintext=1&callback=detail_callback"),t.head.appendChild(i)}}(this),t=window.navigator.userLanguage||window.navigator.language||window.navigator.browserLanguage,this.lang=t.match("ja")?"ja":"en","en"===this.lang&&document.body.classList.add("is_en"),e=document.createElement("script"),e.setAttribute("src","https://"+this.lang+".wikipedia.org/w/api.php?format=json&action=query&list=random&rnnamespace=0&rnlimit=1&callback=list_callback"),this.head.appendChild(e),this.setSocial()},t}());