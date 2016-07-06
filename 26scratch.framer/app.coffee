
bg = new BackgroundLayer backgroundColor: "rgb(0,0,0)"

jackpot = new Layer
	width: 400
	height: 227
	image: "images/jackpot.jpg"
	scale: 1.5

jackpot.center()
jackpot.centerY(-100)

scratchLayer = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: "white"
	style:
		color: "rgba(0,0,0,0.5)"
		fontSize: "2.6rem"
		fontWeight: 300
		textAlign: "center"
		paddingTop: "550px"
		mixBlendMode: "Screen"

scratchBox = new Layer
	width: 600
	height: 400
	borderRadius: 25
	borderColor: "rgba(0,0,0,0.5)"
	html: "Scratch Me"
	style:
		color: "rgba(0,0,0,0.5)"
		fontSize: "2.6rem"
		fontWeight: 300
		textAlign: "center"
		paddingTop: "7rem"
	borderWidth: 3
	backgroundColor: null
scratchBox.center()
scratchBox.centerY(-100)

scratchLayer.on Events.TouchMove, (e, layer) ->
# 	touchX = if Utils.isMobile then Events.touchEvent(event).clientX else event.offsetX
# 	touchY = if Utils.isMobile then Events.touchEvent(event).clientY else event.offsetY
	touchEvent = Events.touchEvent(e)
	if Utils.isPhone() || Utils.isTablet() || Utils.isMobile()
		tX = touchEvent.clientX - layer.x
		tY = touchEvent.clientY - layer.y
	else 
		tX = touchEvent.offsetX 
		tY = touchEvent.offsetY
		
		
	through = new Layer
		midX: tX
		midY: tY
		width: 50
		height: 50
		backgroundColor: "black"
		borderRadius: "1rem"
		opacity: 0
		superLayer: scratchLayer

	through.states.add
		clear: opacity: .5
	
	through.states.switch("clear", time: .1)