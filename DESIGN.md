## Design

- https://en.wikipedia.org/wiki/Comparison_of_JavaScript-based_source_code_editors

## textarea

Monaco editor exposes an API which you can use to edit the text area http://stackoverflow.com/questions/40830303/how-to-insert-code-in-monaco-editor-using-the-protractor

## Syntax highlighting

- http://stackoverflow.com/questions/30687783/create-custom-language-in-visual-studio-code/32996211#32996211
- using a .tmLanguage file is optional. Using a regular .json is a perfectly valid and in my opinion better readable alternative. http://stackoverflow.com/questions/30687783/create-custom-language-in-visual-studio-code/42595036#42595036
- https://github.com/edubkendo/atom-elm/tree/master/grammars
- https://codemirror.net/mode/elm/index.html
  - https://codemirror.net/mode/elm/elm.js
  - https://github.com/codemirror/CodeMirror/tree/master/mode/elm
- https://stackoverflow.com/questions/38489158/use-monaco-editor-in-web-application
- https://microsoft.github.io/monaco-editor/monarch.html

https://github.com/sbrink/vscode-elm/blob/master/package.json#L77

```
"configuration": "./elm.configuration.json"
```

https://github.com/sbrink/vscode-elm/blob/master/package.json#L145

```
"grammars": [
  {
    "language": "elm",
    "scopeName": "source.elm",
    "path": "./syntaxes/elm.json"
  }
```

## Tokenizer

###

I too support being able to replace the tokenizer implementation. For example, since I was working on first-class features for a language that I wanted to implement, I had to create an AST and its associated lexer/parser (which was based on flex/bison by the way). It's a shame that I can't reuse the lexer for syntax highlighting as well. Returning the token/position and saving the lexer state doesn't seem that difficult.

https://github.com/Microsoft/vscode/issues/1967#issuecomment-171171262

###

TypeScript and JavaScript tokenization are today implemented by using the TypeScript lexer API (the same that TypeScript uses to parse TS/JS code).

I do not think the TypeScript team would want to enhance their lexer.

You could implement a custom colorizer in Monarch from scratch (it is not that hard) and use that instead of the one we ship with. VS Code uses a TextMate grammar for TypeScript.

Comparing the standalone editor TypeScript tokenization with VS Code TypeScript tokenization is comparing apples and oranges.

We cannot use TM grammars in the standalone editor. The reason for that is documented in the README. To get standalone editor tokenization on-par (or similar) to VS Code, one would need to create a Monarch tokenizer for TypeScript, because we "cheat" and simply use the lexer that comes with the compiler today.

https://github.com/Microsoft/monaco-editor/issues/316

##  Why doesn't the editor support TextMate grammars?

all the regular expressions in TM grammars are based on oniguruma, a regular expression library written in C.
the only way to interpret the grammars and get anywhere near original fidelity is to use the exact same regular expression library (with its custom syntax constructs)
in VSCode, our runtime is node.js and we can use a node native module that exposes the library to JavaScript
in Monaco, we are constrained to a browser environment where we cannot do anything similar
we have experimented with Emscripten to compile the C library to asm.js, but performance was very poor even in Firefox (10x slower) and extremely poor in Chrome (100x slower).
we can revisit this once WebAssembly gets traction in the major browsers, but we will still need to consider the browser matrix we support. i.e. if we support IE11 and only Edge will add WebAssembly support, what will the experience be in IE11, etc.

https://github.com/Microsoft/monaco-editor

## VSCode

Syntax Highlighting usually consists of two phases. Tokens are assigned to source code, and then they are targeted by a theme, assigned colors, and voilà, your source code is rendered with colors.

Over time, we have phased out our hand-written tokenizers (the last one, for HTML, only a couple months ago). So, in VS Code today, all the files get tokenized with TextMate grammars. For the Monaco Editor, we've migrated to using Monarch (a descriptive tokenization engine similar at heart with TextMate grammars, but a bit more expressive and that can run in a browser) for most of the supported languages, and we've added a wrapper for manual tokenizers. All in all, that means supporting a new tokenization format would require changing 3 tokens providers (TextMate, Monarch and the manual wrapper) and not more than 10.

https://code.visualstudio.com/blogs/2017/02/08/syntax-highlighting-optimizations

## Character

width 7px

height 19px

## Cursor

https://github.com/Microsoft/vscode/blob/master/src/vs/editor/browser/viewParts/viewCursors/viewCursors.css

## Monarch

So… does the "Monarch" syntax declaration work well? Actually, it works quite well. It's basically a declarative state machine syntax so it allows some pretty nice stuff that is either extremely difficult or just impossible to do with regex. For instance, string interpolation highlighting was fairly straight-forward and you can push and pop states on the syntax highlighting stack.

https://owensd.io/2015/05/23/vs-code-swift-colorizer/
