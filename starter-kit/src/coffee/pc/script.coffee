class Main
    constructor: ->
        @head = document.querySelector "head"
        @social_txt = document.querySelector ".social_txt"
        @social = document.querySelector ".social"
        @social_btns =
            tweet: document.querySelector ".tweet"
            facebook: document.querySelector ".facebook"
            hatena: document.querySelector ".hatena"
            gplus: document.querySelector ".gplus"
            link: document.querySelector ".link"
        @social_btn = document.querySelector ".social_btn"
        @link_balloon = document.querySelector ".link_balloon"
        @exec()

    popup: (url) ->
        if window.screenLeft?
            _dualScreenLeft = window.screenLeft
            _dualScreenTop = window.screenTop
        else
            _dualScreenLeft = window.screen.left
            _dualScreenTop = window.screen.top

        if window.innerWidth?
            _windowWidth = window.innerWidth
            _windowHeight = window.innerHeight
        else if document.documentElement?.clientWidth?
            _windowWidth = document.documentElement.clientWidth
            _windowWidth = document.documentElement.clientHeight
        else
            _windowWidth = window.screen.width
            _windowWidth = window.screen.height

        _popupWidth = 800
        _popupHeight = 600

        _left = ((_windowWidth / 2) - (_popupWidth / 2)) + _dualScreenLeft
        _top = ((_windowHeight / 2) - (_popupHeight / 2)) + _dualScreenTop

        window.open(url, "popup",
            "width=#{_popupWidth}, height=#{_popupHeight}, " +
            "top=#{_top}, left=#{_left}"
        )

    setSocial: ->
        _fb_appId = 469711053215641

        # fb-share
        fjs = document.getElementsByTagName("script")[0]
        js = document.createElement "script"
        js.id = "facebook-jssdk"
        js.src = "//connect.facebook.net/ja_JP/sdk.js#xfbml=1&" +
                 "appId=#{_fb_appId}&version=v2.0"
        fjs.parentNode.insertBefore js, fjs

        # fb-share
        @social_btns.facebook.addEventListener "click", =>
            FB.ui
                method: "share"
                href: @url

        # tweet
        @social_btns.tweet.addEventListener "click", =>
            if @extract.length > 80 - @title.length
                @extract = "#{@extract.slice(0, 80 - @title.length)}..."
            _txt = "#{@title} - #{@extract}"

            @popup "http://twitter.com/share?url=#{@url}&text=#{encodeURIComponent(_txt)}&hashtags=知見山"

        # hatena
        @social_btns.hatena.addEventListener "click", =>
            @popup "http://b.hatena.ne.jp/add?url=#{@url}&title=#{@title}"

        # gplus
        @social_btns.gplus.addEventListener "click", =>
            @popup "https://plus.google.com/share?url=#{@url}"

    exec: ->
        ###########################
        #   EVENT LISTENER
        ###########################

        @social_btn.addEventListener "click", =>
            if @social.getAttribute("class").match "is_show"
                @social.classList.remove "is_show"
            else
                @social.classList.add "is_show"
                @social_txt.select()

        @social_btns.link.addEventListener "click", =>
            if @social_btns.link.getAttribute("class").match "is_active"
                @social_btns.link.classList.remove "is_active"
                @social_txt.setAttribute "value", "#{@title} - #{@url}"
            else
                @social_btns.link.classList.add "is_active"
                @social_txt.setAttribute "value", @url
                @social_btns.link.innerHTML = @url

                _range = document.createRange()
                _range.selectNode @social_btns.link
                window.getSelection().addRange _range

                try
                    document.execCommand "copy"
                    @link_balloon.classList.add "is-show"

                    clearTimeout @balloon_timer
                    @balloon_timer = setTimeout (=> @link_balloon.classList.remove "is-show"), 3000
                catch err
                    console.log err

                window.getSelection().removeAllRanges()

            @social_txt.select()

        window.detail_callback = (data) =>
            for page of data.query.pages
                @extract = data.query.pages[page].extract.replace /[\n\r]/g, "" # 改行を削除
                @title = data.query.pages[page].title
                @social_txt.setAttribute "value", "#{@title} - #{@url}"
                return

        window.list_callback = (data) =>
            @url = "http://#{@lang}.wikipedia.org/w/index.php?curid=#{data.query.random[0].id}"
            _iframe = document.createElement "iframe"
            _iframe.setAttribute "src", @url
            _iframe.onload = => @social_btn.style.display = "block"
            document.body.appendChild _iframe

            _script = document.createElement "script"
            _script.setAttribute(
                "src", "https://#{@lang}.wikipedia.org/w/api.php?format=json&action=query&" +
                       "titles=#{data.query.random[0].title}&prop=extracts&redirects=1&" +
                       "exchars=130&explaintext=1&callback=detail_callback"
            )
            @head.appendChild _script

        ###########################
        #   INIT
        ###########################

        _lang = window.navigator.userLanguage ||
                window.navigator.language ||
                window.navigator.browserLanguage

        @lang = if _lang.match "ja" then "ja" else "en"

        document.body.classList.add "is_en" if @lang == "en"

        _script = document.createElement "script"
        _script.setAttribute(
            "src", "https://#{@lang}.wikipedia.org/w/api.php?format=json&action=query&list=random&" +
                   "rnnamespace=0&rnlimit=1&callback=list_callback"
        )
        @head.appendChild _script

        @setSocial()

new Main()
