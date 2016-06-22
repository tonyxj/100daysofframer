
layerS = 230
margin = 15
lSide = 15
tSide = 190
posX = 0
posY = 0
Layers = []

bg = new BackgroundLayer
	backgroundColor: "#fff"
	width: Screen.width
	height: Screen.height

for i in [1..12]
	if i % 3 is 0
		posX = lSide
	else if i % 3 is 2
		posX = lSide + margin + layerS
	else
		posX = lSide + margin * 2 + layerS * 2
	
	if i <= 3
		posY = tSide
	else if i <= 6
		posY = tSide + margin + layerS
	else if i <= 9
		posY = tSide + margin*2 + layerS*2
	else
		posY = tSide + margin*3 + layerS*3
	
	layer = new Layer
		width: layerS
		height: layerS
		x: posX
		y: posY
		backgroundColor: "white"
		borderRadius: 8
		shadowY: 4
		shadowBlur: 8
		shadowColor: "rgba(0,0,0,0.3)"
	layer.states.add
		hide:
			opacity: 0
	layer.states.animationOptions = time: 0.2
	Layers.push(layer)
	
	imageLayer = new Layer
		width: layerS
		height: layerS
		borderRadius: 8 
		superLayer: layer
		image: "images/" + i + ".jpg"
	imageLayer.states.add
		fade:
			opacity: 0
	imageLayer.states.animationOptions = time: 0
		
	imageLayer.onClick ->
		
		img = this
		img.states.switch("fade")	
		
		currentLayer = this.copy()
		currentLayer.frame = this.screenFrame
		currentLayer.states.add
			one:
				x: 0
				y: 360
				width: Screen.width
				height: 500
				borderRadius: 0
				clip: false
				shadowY: 20
				shadowBlur: 48
		currentLayer.states.animationOptions = 
			curve: "spring(320, 20, 0)"
			
		currentLayer.states.switch("one")
		for layerToHide in Layers
			layerToHide.states.switch("hide")
			layerToHide.subLayers[0].ignoreEvents = true
		
		currentLayer.pinchable.enabled = true
		currentLayer.on Events.Pinch, (event, layer) ->
			this.draggable.enabled = true
			this.draggable.momentumOptions = 
				friction: 5.1
				tolerance: 0.1
		
		
		currentLayer.onPinchEnd ->
			
			if this.scale >= 3
				currentLayer.animate
					properties:
						scale: 3
					curve: "ease"
					time: 0.3
					
			if this.rotation >= 45
				currentLayer.animate
					properties:
						rotation: 90
					time: 0.2
			if this.rotation >= 135
				currentLayer.animate
					properties:
						rotation: 180
					time: 0.2
			if this.rotation > 225
				currentLayer.animate
					properties:
						rotation: 270
					time: 0.2
			if this.rotation > 270
				currentLayer.animate
					properties:
						rotation: 0
					time: 0.2
			
			if this.rotation < 45
				currentLayer.animate
					properties:
						rotation: 0
					time: 0.2
					
			if this.rotation <= -45
				currentLayer.animate
					properties:
						rotation: -90
					time: 0.2
			if this.rotation <= -135
				currentLayer.animate
					properties:
						rotation: -180
					time: 0.2
			if this.rotation <= -225
				currentLayer.animate
					properties:
						rotation: -270
					time: 0.2
			if this.rotation <= -270
				currentLayer.animate
					properties:
						rotation: 0
					time: 0.2
					
			if this.scale <= 1.2
				currentLayer.animate
					properties:
						scale: 1
# 						x: Align.center
# 						y: Align.center
					curve: "spring(320, 20, 0)"
			
			xconstraint = currentLayer.screenFrame.width
			
			if xconstraint > (Screen.width * 3)
				xconstraint = Screen.width * 3
			if xconstraint < (Screen.width)
				xconstraint = Screen.width
			xpoint = -((xconstraint - Screen.width) / 2)
			
			this.draggable.constraints =
				x: xpoint
				y: 0
				width: xconstraint
				height: Screen.height
			if this.scale <= 1
				currentLayer.states.switch("default")
				
				currentLayer.onAnimationEnd ->
					img.states.switch("default")
					Utils.delay 0.1, ->
						currentLayer.destroy()			
				for layerToShow in Layers
					layerToShow.states.switch("default")
					layerToShow.subLayers[0].ignoreEvents = false
			
		


