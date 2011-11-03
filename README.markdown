CodeHighlighter
===============

CodeHighlighter is an extension for Safari and Chrome that does syntax
coloring for the code examples contained in Apple's developer documentation
under developer.apple.com. This is done using [Zepto.js][1] and
[highlight.js][2].

To build the extension, you need Node.js and CoffeeScript. Run `cake` at the
root of the cloned repo (where `Cakefile` resides) for the available commands.
The build products will go in their respective locations under `safari/` and
`chrome/`.

You will have to package the build products into distributable form by using
Extension Builder (Safari) and Extension Management (Chrome). See Apple's and
Google's developer documentation for details.

For more information and a downloadable version of the extension, go to
[http://jklaiho.net/CodeHighlighter/][3].

[1]: http://zeptojs.com/
[2]: http://softwaremaniacs.org/soft/highlight/en/
[3]: http://jklaiho.net/CodeHighlighter/