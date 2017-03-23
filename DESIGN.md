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

I too support being able to replace the tokenizer implementation. For example, since I was working on first-class features for a language that I wanted to implement, I had to create an AST and its associated lexer/parser (which was based on flex/bison by the way). It's a shame that I can't reuse the lexer for syntax highlighting as well. Returning the token/position and saving the lexer state doesn't seem that difficult.

https://github.com/Microsoft/vscode/issues/1967#issuecomment-171171262
