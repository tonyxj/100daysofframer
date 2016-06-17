
# Stream gif source: http://rebloggy.com/post/gif-cold-rock-awesome-fresh-water-nature-animated-gif-original-river-wild-stream/114414392285

# A few variables for controlling the basic
streamSpeed = 0.5
stop = false
stillgoing = false
newDragList = []

stream = new Layer
	width: Screen.width
	height: Screen.height
	image: "images/stream2.gif"
	style: 
		backgroundPosition: "left"

# Create base bubble archetype
bubble = new Layer
	width: Utils.randomNumber(40, 48)
	height: Utils.randomNumber(37, 40)
	x: 0
	y: 0
	borderRadius: "50%"
	scale: Utils.randomNumber(0.7, 1.2)
	style:
		background: "radial-gradient(circle, rgba(255,255,255,"+ Utils.randomNumber(0.05, 0.25) + "), rgba(255,255,255,"+ Utils.randomNumber(0.8, 0.99) + "))"
bubble.visible = false

############################################  MAIN FUNCTION to create bubbles

createRandomBubbles = (streamX, streamY) ->
	if stop is true 
		return
	# Create new bubble function
	createNewBubble = (streamX, streamY) ->
		if stop is true 
			return
		newBubble = new Layer
			width: Utils.randomNumber(40, 48)
			height: Utils.randomNumber(37, 40)
			x: 0
			y: 0
			borderRadius: "50%"
			scale: 0
			style:
				background: "radial-gradient(circle, rgba(255,255,255,"+ Utils.randomNumber(0.05, 0.25) + "), rgba(255,255,255,"+ Utils.randomNumber(0.8, 0.99) + "))"
		return newBubble
	
	# Create size for base stream where bubbles would float across
	streamUpSize =
		w: 520
		h: 160
	
	# Create the two streams, above and below the finger
	streamUp = new Layer
		x: streamX 
		y: streamY - streamUpSize.h / 2.5
		width: streamUpSize.w
		height: streamUpSize.h / 1.2
		clip: false
		superLayer: newDrag
		backgroundColor: "none"
	
	streamDown = new Layer
		x: streamX - 30
		y: streamY + streamUpSize.h / 3
		width: streamUpSize.w
		height: streamUpSize.h * 1.1
		clip: false
		superLayer: newDrag
		backgroundColor: "none"
	
	newDragList.push(streamUp)
	newDragList.push(streamDown)
		
	############################################  ANIMATION VARIABLES
	
	# Create the random variables to be used in the float animations
	animationProps =
		upX: Utils.randomNumber(-30, 30)
		upY: Utils.randomNumber(-30, 30)
		downX: Utils.randomNumber(-30, 30)
		downY: Utils.randomNumber(-30, 30)
		upEndX: Utils.randomNumber(streamUp.width - 30, streamUp.width + 30)
		upEndY: Utils.randomNumber(streamUp.height - 30, streamUp.height + 30)
		downEndX: Utils.randomNumber(streamDown.width - 30, streamDown.width + 30)
		downEndY: Utils.randomNumber(streamDown.height - 30, streamDown.height + 30)
		waveY: Utils.randomNumber(20, 60)
		aC: "linear"

	# Create layers to attach the animations of floating from left to right for the top and bottom streams
	mainDirectionLayerUp = new Layer
		width: bubble.width
		height: bubble.height
		x: animationProps.upX
		y: animationProps.upY
		backgroundColor:  "none"
		superLayer: streamUp
		clip: false
	
	mainDirectionLayerDown = new Layer
		width: bubble.width
		height: bubble.height
		x: animationProps.downX
		y: animationProps.downY
		backgroundColor:  "none"
		superLayer: streamDown
		clip: false
	
	# Create the float across animations for the top and bottom layers
	floatRightUp = new Animation
		layer: mainDirectionLayerUp
		properties: y: animationProps.upEndY, x: animationProps.upEndX, opacity: 0
		curve: animationProps.aC
		time: streamSpeed
	
	floatRightDown = new Animation
		layer: mainDirectionLayerDown
		properties: y: animationProps.downEndY, x: animationProps.downEndX, opacity: 0
		curve: animationProps.aC
		time: streamSpeed
	
	# Create the float across animation for the top layer
	mainDirectionLayerUp.on Events.AnimationEnd, (animation, layer) ->
		layer.destroy()
		
	mainDirectionLayerDown.on Events.AnimationEnd, (animation, layer) ->
		layer.destroy()
	
	floatRightUp.start()
	floatRightDown.start()
	
	# Create the up and down floating layers
	upDownLayerTop = new Layer
		width: bubble.width
		height: bubble.height
		superLayer: mainDirectionLayerUp
		backgroundColor: "none"
		clip: false
	
	upDownLayerDown = new Layer
		width: bubble.width
		height: bubble.height
		superLayer: mainDirectionLayerDown
		backgroundColor: "none"
		clip: false
	
	# Create the float up down animation for the top stream
	waveUpTop = new Animation
		layer: upDownLayerTop
		properties: 
			y: upDownLayerTop.y - animationProps.waveY
		time: streamSpeed / 3
		curve: animationProps.aC
	
	waveDownTop = new Animation
		layer: upDownLayerTop
		properties: 
			y: upDownLayerTop.y + animationProps.waveY
		time: streamSpeed / 3
		curve: animationProps.aC
		
	# Create the float up down animation for the bottom stream
	waveUpBottom = new Animation
		layer: upDownLayerDown
		properties: 
			y: upDownLayerDown.y - animationProps.waveY
		time: streamSpeed / 3
		curve: animationProps.aC
	
	waveDownBottom = new Animation
		layer: upDownLayerDown
		properties: 
			y: upDownLayerDown.y + animationProps.waveY
		time: streamSpeed / 3
		curve: animationProps.aC
	
	# Loop the up and down animations for both streams
	waveUpTop.on(Events.AnimationEnd, waveDownTop.start)
	waveDownTop.on(Events.AnimationEnd, waveUpTop.start)
	
	waveUpBottom.on(Events.AnimationEnd, waveDownBottom.start)
	waveDownBottom.on(Events.AnimationEnd, waveUpBottom.start)
	
	Utils.randomChoice( [waveUpTop, waveDownTop] ).start()
	Utils.randomChoice( [waveUpBottom, waveDownBottom] ).start()
	
	# Create the new bubbles and add them to the animation layers
	newBubble1 = createNewBubble()
	newBubble2 = createNewBubble()
	
	upDownLayerTop.addSubLayer newBubble1
	upDownLayerDown.addSubLayer newBubble2
	
	# Animate the initial pop out
	newBubble1.animate
		properties:
			scale: Utils.randomNumber(0.7, 1.3)
		time: .03
		curve: "ease-out"
	
	newBubble2.animate
		properties:
			scale: Utils.randomNumber(0.7, 1.3)
		time: .02
		curve: "ease-out"
	
	
############################################  MAKE EMITTER

showBubbles = (x, y) ->
	delay = Utils.randomNumber(0,0.08)
	Utils.delay delay, ->
		if stop is true 
			return
		# v Uses code above not the module
		# getRandomHeart()
# 		getRandomHeart(heart, streamSize, heartStream)
		showBubbles(x,y)
		createRandomBubbles(x, y)

############################################  KICK OFF
main = new Layer
	width: Screen.width
	height: Screen.height
	x: 0
	y: 0
	backgroundColor: "none"

newDrag = new Layer
	width: Screen.width
	height: Screen.height
	x: 0
	y: 0
	superLayer: main
	backgroundColor: "none"
newDrag.draggable = true
newDrag.draggable.momentum = false

main.onTouchStart ->
	if stillgoing is false
# 		touchEvent = Events.touchEvent event
# 		tX = touchEvent.offsetX
# 		tY = touchEvent.offsetY
		touchEvent = Events.touchEvent(event)
		if Utils.isPhone() || Utils.isTablet()
			tX = touchEvent.clientX - newDrag.x
			tY = touchEvent.clientY - newDrag.y
		else 
			tX = touchEvent.offsetX 
			tY = touchEvent.offsetY
		showBubbles(tX, tY)
		stop = false

main.onTouchEnd ->
	stop = true
	stillgoing = true
	Utils.delay 0.65, ->
		newDrag.x = 0
		newDrag.y = 0
		stillgoing = false
		for layer,i in newDragList
			layer.destroy()
			newDragList[i] = null
		newDragList.length = null

