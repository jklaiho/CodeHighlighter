(function() {
  var receiver;
  if (window.top !== window.self) {
    Zepto(document).ready(function() {
      return safari.self.tab.dispatchMessage('getSetting', 'theme');
    });
    receiver = function(msgEvent) {
      var code, style, table, tables, textRows, _i, _len, _results;
      if (msgEvent.name === 'setting') {
        safari.self.tab.dispatchMessage('getStyle', msgEvent.message);
      }
      if (msgEvent.name === 'style') {
        Zepto('#highlight-theme').remove();
        Zepto('head').append('<style>');
        style = Zepto('head').children('style').last();
        style.attr('id', 'highlight-theme');
        style.html(msgEvent.message);
        tables = Zepto('article div.codesample table');
        _results = [];
        for (_i = 0, _len = tables.length; _i < _len; _i++) {
          table = tables[_i];
          textRows = [];
          code = Zepto(table).after('<pre><code></code></pre>').next().children('code');
          Zepto(table).find('pre').each(function(index, elem) {
            return textRows.push($(elem).text());
          });
          code.text(textRows.join('\n'));
          hljs.highlightBlock(code.get(0));
          _results.push($(table).remove());
        }
        return _results;
      }
    };
    safari.self.addEventListener('message', receiver, false);
  }
}).call(this);
