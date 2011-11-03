# Only run this inside the content iframe
if window.top != window.self
    Zepto(document).ready(->
        # TODO
        # safari.self.tab.dispatchMessage('getSetting', 'font')
        
        # The callback for this dispatches the message for theme CSS
        # retrieval, whose callback applies the styles and starts the
        # DOM modification/syntax highlighting process
        safari.self.tab.dispatchMessage('getSetting', 'theme')
    )
    
    receiver = (msgEvent) ->
        if msgEvent.name == 'setting'
            # The event's message is the id of the style element in
            # global.html
            safari.self.tab.dispatchMessage('getStyle', msgEvent.message)
        
        if msgEvent.name == 'style'
            # msgEvent.message is the innerHTML of the element defined in
            # global.html, inject that into the document
            Zepto('#highlight-theme').remove()
            Zepto('head').append('<style>')
            style = Zepto('head').children('style').last()
            style.attr('id', 'highlight-theme')
            style.html(msgEvent.message)
            
            # With the styles available, convert the listing tables into
            # proper code blocks and apply the highlighting
            tables = Zepto('article div.codesample table')
            for table in tables
                textRows = []
                code = Zepto(table).after('<pre><code></code></pre>').next().children('code')
                Zepto(table).find('pre').each((index, elem) ->
                    textRows.push($(elem).text())
                )
                code.text(textRows.join('\n'))
                hljs.highlightBlock(code.get(0))
                $(table).remove()
    
    safari.self.addEventListener('message', receiver, false)