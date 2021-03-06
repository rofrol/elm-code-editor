# Elm code editor


## How to run

To set up on your own computer, you will need `git`, `elm-0.18`, `node.js`, `yarnpkg`.

Also web browser with support of [Object.assign](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Object/assign) for loading `env.js`. There is also [polyfill](https://github.com/sindresorhus/object-assign).

Simply clone the repository and:


```bash
$ git clone https://github.com/rofrol/elm-navigation-example.git
$ cd elm-navigation-example
$ yarn
$ cp .env.example .env
$ ./tools/build-dev.sh
$ ./tools/server.js
```

In another terminal run:

```bash
$ ./tools/browsersync.js
```

Then navigate your browser to [http://localhost:8000](http://localhost:8000).

## Configuration

Based on https://12factor.net/config

```bash
cp .env.example .env
./tools/generate-env.js
```

You will get `dist/js/env.js` which is loaded to elm through flags.

## Linter elm make - don't compile twice

https://gist.github.com/rofrol/98e8a788b3866493f53ad25f38563675
