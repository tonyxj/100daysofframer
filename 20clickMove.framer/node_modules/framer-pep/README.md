A simple adapter to jquery's [PEP](https://github.com/jquery/PEP) for [FramerJS](http://framerjs.com/). A **P**ointer**E**vent **P**olyfill makes it possible to use the W3C's PointerEvent specification today. PointerEvents let you handle mouse, touch, and pen input through a single set of event handlers.

# Example Usage

Tested in [Framer Studio](http://framerjs.com) and [framer-cli](https://github.com/peteschaffner/framer-cli).

1. Run `npm install framer-pep` in your prototype's directory (usually MyPrototype.framer/)
2. Add a reference framer-pep by adding `pep = require("framer-pep")`. Where you do this dependson whether you're using Framer Studio or framer-cli

## Framer Studio

If you're using Framer Studio, you need to create an `npm.coffee` file in your modules folder, per [these instructions](http://framerjs.com/docs/#modules-npm-example).

`MyPrototype.framer/modules/npm.coffee`

```coffeescript
# npm.coffee is a simple module wrapper
exports.pep = require("framer-pep")
# You could require more npm modules that you have installed on additional lines. For example, assuming you have backbone installed:
#exports.backbone = require("backbone")
```

`MyPrototype.framer/app.coffee`

```coffeescript
npm = require("npm") # reference to your npm wrapper module
pep = npm.pep # now you have direct access to the framer-pep npm module
```

## framer-cli

`index.coffee` (or index.js)

```coffeescript
pep = require("framer-pep")
```

# Features

framer-pep exposes two properties, `pep.PointerEvents` and `pep.PointerEventLayer`

Here's how I like to use it:

```coffeescript
pep = require("framer-pep")

# Replace the standard Framer objects with PEP objects
window.Events = _.extend(Events, pep.PointerEvents)
window.Layer = pep.PointerEventLayer

TestLayer = new Layer
TestLayer.center()

TestLayer.on Events.PointerDown, (e) ->
    # Will print on mouse, touch, and pen
    print "Hello from pointerdown!"
```

# Known Issues

Dragging and ScrollComponents don't work because they're hard-coded to use touch events. You can get dragging to work (hackily) like so:

```coffeescript
window.Events.TouchStart = Events.PointerDown
window.Events.TouchMove = Events.PointerMove
window.Events.TouchEnd = Events.PointerUp
```

# Building

Just use `npm run build`. That will generate the compiled `index.js` from `index.coffee`.