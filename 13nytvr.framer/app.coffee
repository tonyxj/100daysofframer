# Import file "nytvr"
sketch = Framer.Importer.load("imported/nytvr@1x")


scroll = new ScrollComponent
	width: Screen.width
	height: Screen.height
	x: 0
	y: 0
scroll.scrollHorizontal = false

layerH = 900
imageH = 750
gradientH = 400
fadeTime = 0.35
Layers = []
Texts = []
Shares = []
Ts = []

sketch.options.y = 1400
sketch.options.centerX()
sketch.options.states.add
	fade:
		y: 800
sketch.options.states.animationOptions = curve: "ease", time: fadeTime * 2

sketch.question.y = 1400
sketch.question.centerX()
sketch.question.scale = 1.2
sketch.question.states.add
	fade:
		y: 670
sketch.question.states.animationOptions = curve: "ease-in-out", time: fadeTime

sketch.line.y = 1400
sketch.line.centerX()
sketch.line.opacity = 0.5
sketch.line.states.add
	fade:
		y: 480
sketch.line.states.animationOptions = curve: "ease-in-out", time: fadeTime * 2

sketch.back.y = 38
sketch.back.x = 28
sketch.back.scale = 0.9
sketch.back.opacity = 0
sketch.back.states.add
	fade:
		opacity: 0.7
sketch.back.states.animationOptions = curve: "ease", time: fadeTime * 2

for i in [0...4]
	layer = new Layer
		width: Screen.width
		height: layerH
		x: 0
		y: layerH * i
		backgroundColor: "null"
		superLayer: scroll.content
	Layers.push(layer)
	layer.states.add
		fade:
			height: Screen.height
			z: 10
			opacity: 1
		gone: 
			opacity: 0
	layer.states.animationOptions = curve: "linear", time: fadeTime
	
	bgLayer = new Layer
		width: Screen.width
		height: Screen.height
		backgroundColor: "black"
		superLayer: layer
		opacity: 0
	bgLayer.states.add
		fade:
			opacity: 1
	bgLayer.states.animationOptions = curve: "ease", time: fadeTime

	image = new Layer
		width: Screen.width
		height: imageH
		image: "images/" + (i + 1)  + ".jpg"
		y: 0
		superLayer: layer
	image.states.add
		fade:
			y: 290
			scale: 1.8
			blur: 20
			opacity: 0.4
	image.states.animationOptions = curve: "ease", time: fadeTime
	
	gradient = new Layer
		width: Screen.width
		height: gradientH
		y: imageH - gradientH + 5
		superLayer: image
		style:
			background: "linear-gradient(180deg, rgba(0,0,0,0) 0%, black 100%)"
	
	Layers[i].addSubLayer sketch["text#{i+1}"]
	sketch["text#{i+1}"].y = 520
	Texts.push(sketch["text#{i+1}"])
	sketch["text#{i+1}"].states.add
		fade:
			y: 263
	sketch["text#{i+1}"].states.animationOptions = curve: "ease", time: fadeTime * 2
	
	Layers[i].addSubLayer sketch["share#{i+1}"]
	sketch["share#{i+1}"].y = imageH + 10
	Shares.push(sketch["share#{i+1}"])
	sketch["share#{i+1}"].states.add
		fade:
			opacity: 0
	sketch["share#{i+1}"].states.animationOptions = curve: "linear", time: fadeTime
	
	Layers[i].addSubLayer sketch["t#{i+1}"]
	sketch["t#{i+1}"].centerY(-150)
	sketch["t#{i+1}"].centerX()
	Ts.push(sketch["t#{i+1}"])
	sketch["t#{i+1}"].states.add
		fade:
			opacity: 0
	sketch["t#{i+1}"].states.animationOptions = curve: "linear", time: fadeTime
	

logo = new Layer
	width: Screen.width
	height: 135
	x: 0
	y: 0
	backgroundColor: "rgba(0,0,0, 0.45)"
	html:"NYT<span style='font-weight: 600; font-family: Helvetica, sans-serif; color:lightgreen; font-size: 2.1rem'>VR</span>"
	style:
		display: "block"
		textAlign: "center"
		fontSize: "3rem"
		fontFamily: "Freight, Times, Serif"
		paddingTop: "3.5rem"
logo.states.add
	fade:
		backgroundColor: "rgba(0,0,0,0)"
logo.states.animationOptions = curve: "linear", time: fadeTime


for i in [0...Layers.length]
	Layers[i].onClick ->
		for layer in Layers
			layer.states.switch("gone")
		currentLayer = this
		scroll.scrollToLayer(
			this
			0,0
			true
			curve: "ease"
			time: fadeTime/1.5
		) 
		
		this.states.switch("fade")
		logo.states.switch("fade")
		@subLayers[4].states.switch("fade")
		@subLayers[3].states.switch("fade")
		@subLayers[2].states.switch("fade")
		@subLayers[1].states.switch("fade")
		@subLayers[0].states.switch("fade")
		
		if this.y >= 2699
			this.animate
				properties:
					y: 2250
				curve: "ease-out"
				time: fadeTime / 1.5
			
		scroll.scrollVertical = false
		Utils.delay fadeTime * 3, ->
			sketch.line.bringToFront()
			sketch.line.states.switch("fade")
		Utils.delay fadeTime * 4.5, ->
			sketch.question.bringToFront()
			sketch.question.states.switch("fade")
			
			sketch.options.bringToFront()
			sketch.options.states.switch("fade")
			
			sketch.back.bringToFront()
			sketch.back.states.switch("fade")
		
		sketch.back.onClick ->
			sketch.question.states.switch("default")
			sketch.options.states.switch("default")
			sketch.back.states.switch("default")
			sketch.line.states.switch("default")
			Utils.delay fadeTime, ->
				currentLayer.states.switch("default")
				currentLayer.subLayers[0].states.switch("default")
# 				
				Utils.delay fadeTime / 4, ->
					logo.states.switch("default")
					currentLayer.subLayers[1].states.switch("default")
					currentLayer.subLayers[2].states.switch("default")
					currentLayer.subLayers[4].states.switch("default")
					currentLayer.subLayers[3].states.switch("default")
					scroll.scrollVertical = true
					for layer in Layers
						layer.states.switch("default")
						
						
						