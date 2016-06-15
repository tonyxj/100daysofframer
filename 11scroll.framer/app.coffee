

scroll = new ScrollComponent
	width: Screen.width
	height: Screen.height

scroll.scrollHorizontal = false

nytimes = new Layer
	width: 1536 
	height: 3219 
	superLayer: scroll.content
	image: "images/nytimes.png"
	
obama = new VideoLayer
	width: 640 * 1.853
	height: 360 * 1.853
	x: 175
	y: 412
	opacity: 0
	video: "images/obama.mp4"
	superLayer: scroll.content

obama.onClick ->
	this.player.play()
	this.opacity = 1

scrAmt = 0
isPaused  = false 

scroll.onMove ->
	scrAmt = scroll.content.y
	
	if scrAmt <= -412 
		obama.player.volume = Utils.modulate(scrAmt, [-1080, -460], [0, 1], true)
	
	if scrAmt <= -1080
		obama.player.pause()
		isPaused = true
		
	if isPaused and scrAmt > -1050
		obama.player.play()
	
	if scrAmt > -412
		isPaused = false
	
