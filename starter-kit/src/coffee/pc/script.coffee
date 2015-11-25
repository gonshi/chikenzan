class Main
    constructor: ->
        @head = document.querySelector "head"
        @social_txt = document.querySelector ".social_txt"
        @social = document.querySelector ".social"
        @social_btns =
            tweet: document.querySelector ".tweet"
            facebook: document.querySelector ".facebook"
            gplus: document.querySelector ".gplus"
            link: document.querySelector ".link"
        @social_btn = document.querySelector ".social_btn"
        @exec()

    setSocial: ->
        _fb_appId = 469711053215641

        window.twttr = (->
            fjs = document.getElementsByTagName("script")[ 0 ]
            return if document.getElementById "twitter-wjs"
            js = document.createElement "script"
            js.id = "twitter-wjs"
            js.src = "https://platform.twitter.com/widgets.js"
            fjs.parentNode.insertBefore js, fjs
            if window.twttr?
                return window.twttr
            else
                return (t =
                    _e: []
                    ready: (f) -> t._e.push(f)
                )
            )()

        ###
        j = document.createElement "script"
        j.type = "text/javascript"
        j.src = "https://b.st-hatena.com/js/bookmark_button.js"
        j.async = "async"
        j.charset = "utf-8"
        s = document.getElementsByTagName("script")[0]
        s.parentNode.insertBefore j, s
        ###

        # gplus
        ###
        po = document.createElement "script"
        po.type = "text/javascript"
        po.async = true
        po.src = "https://apis.google.com/js/plusone.js"
        s = document.getElementsByTagName("script")[0]
        s.parentNode.insertBefore po, s
        ###

        # fb-share
        fjs = document.getElementsByTagName("script")[0]
        js = document.createElement "script"
        js.id = "facebook-jssdk"
        js.src = "//connect.facebook.net/ja_JP/sdk.js#xfbml=1&" +
                 "appId=#{_fb_appId}&version=v2.0"
        fjs.parentNode.insertBefore js, fjs

        # fb-share
        @social_btns.facebook.addEventListener "click", (e) =>
            FB.ui
                method: "share"
                href: @url

        # tweet
        @social_btns.tweet.addEventListener "click", (e) =>
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

            _popupWidth = 650
            _popupHeight = 450

            _left = ((_windowWidth / 2) - (_popupWidth / 2)) + _dualScreenLeft
            _top = ((_windowHeight / 2) - (_popupHeight / 2)) + _dualScreenTop

            if @extract.length > 80 - @title.length
                @extract = "#{@extract.slice(0, 80 - @title.length)}..."
            _txt = "#{@title} - #{@extract}"

            window.open(
                "http://twitter.com/share?url=#{@url}&text=#{encodeURIComponent(_txt)}&hashtags=知見山",
                "twitter", "width=#{_popupWidth}, height=#{_popupHeight}, top=#{_top}, left=#{_left}"
            )

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
            document.body.appendChild _iframe

            _script = document.createElement "script"
            _script.setAttribute(
                "src", "https://#{@lang}.wikipedia.org/w/api.php?format=json&action=query&" +
                       "titles=#{data.query.random[0].title}&prop=extracts&redirects=1&" +
                       "exchars=130&explaintext=1&callback=detail_callback"
            )
            @head.appendChild _script

            @social_btn.style.display = "block"

        ###########################
        #   INIT
        ###########################

        _lang = window.navigator.userLanguage ||
                window.navigator.language ||
                window.navigator.browserLanguage

        @lang = if _lang.match "ja" then "ja" else "en"

        _script = document.createElement "script"
        _script.setAttribute(
            "src", "https://#{@lang}.wikipedia.org/w/api.php?format=json&action=query&list=random&" +
                   "rnnamespace=0&rnlimit=1&callback=list_callback"
        )
        @head.appendChild _script

        @setSocial()

        console.log window.parent.document.querySelector "title"

new Main()
