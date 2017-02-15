# Import file "scroll-n-click"
sketch = Framer.Importer.load("imported/scroll-n-click@1x")

scroll = new ScrollComponent
	width: Screen.width
	height: Screen.height
	y: 128, superLayer: sketch.content
	scrollHorizontal: false
	contentInset: {top: 32, bottom: 32}
	
allLayers = []
	
for i in [0...10]
	layer = new Layer
		backgroundColor: "#fff"
		width: scroll.width-48, height: 400
		x: 24, y:(400 + 32) * i
		borderRadius: 6, superLayer: scroll.content
	
	layer.style.boxShadow = "0 1px 6px rgba(0,0,0,0.2)"
	
	fav = new Layer image:"images/fav.png", superLayer: layer
	favActive = new Layer image:"images/favActive.png",superLayer: layer, opacity: 0, scale: 0.25
	fav.center()
	favActive.center()
	
	fav.states.add
		active: 
			opacity: 0
			scale: 1
	favActive.states.add(active: {opacity: 1, scale: 1})
	
	fav.states.animationOptions = time: 0.5
# 	favActive.states.animationOptions = curve: "spring(500, 30, 0)"
	
	allLayers.push(layer)
	
	scroll.on Events.ScrollMove, ->
		layer.ignoreEvents = true for layer in allLayers
		
	scroll.on Events.ScrollAnimationDidEnd, ->
		this.on Events.TouchEnd, ->
			layer.ignoreEvents = false for layer in allLayers
			
for layer in allLayers
		layer.on Events.TouchEnd, ->
			unless scroll.isMoving
				# Why is this the case that you need to put fav inside layer again? The app stops working if you don't specify them.
				# Answer: these two are only selection methods, the fav and favActive names here have nothing to do with what's outside, since the names are not unique, the program has to select from the "layer" obj, which is denoted by "this". Then the two sublayers can be selected by their id.
				fav = this.subLayers[0]
				favActive = this.subLayers[1]
				fav.states.next()
				favActive.states.next()
				fav.center()
				favActive.center()
			
