# Video Setup
video = new VideoLayer
	x: Align.center
	y: -100
	width: Screen.width
	height: Screen.height
	
	video: "images/jb-long.mp4"
	backgroundColor: "none"

# Start Thumbnail Setup
jb16 = new Layer
	width: Screen.width
	height: Screen.height
	x: Align.center
	y: 0
	image: "images/jb16-l.jpg"
jb16.states.add
	play:
		blur: 20
		opacity: 0
jb16.states.animationOptions = curve: "ease-in-out", time: 0.4

startButton = new Layer
	width: 71
	height: 50
	x: Align.center
	y: Align.center
	scale: 3
	image: "images/6cr6xX8Ei.png"
	superLayer: jb16

# Controls Overlay Setup
controls = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: "rgba(0,0,0, 0.5)"
	opacity: 0
controls.states.add
	show: 
		opacity: 1
controls.states.animationOptions = curve: "ease-in-out", time: 0.2

buttons = new Layer
	width: Screen.width
	height: Screen.height
	x: 0
	backgroundColor: "none"
	opacity: 0
buttons.states.add
	show:
		opacity: 1
buttons.states.animationOptions = curve: "ease-in-out", time: 0.2


# Pause and Play buttons on Controls Overlay
play = new Layer
	width: 75
	height: 75
	image: "images/play.png"
	superLayer: buttons
	x: Align.center
	y: 530
	opacity: 0

pause = new Layer
	width: 75
	height: 75
	image: "images/pause.png"
	superLayer: buttons
	x: Align.center
	y: 530
	opacity: 1
	

# Scrubber Setup
scrubber = new Layer
	x: Screen.width / 2
	y: 	1100
	image: "images/marks.png"
	width: 149 * 15
	height: 30
	style: background: "linear-gradient(-180deg, rgba(255,65,0, 1) 0%, rgba(255,5,0, 1) 30%)"
# 		backgroundPosition: "0 32%"
	superLayer: controls
	

dial = new Layer
	x: Screen.width / 2 - 2
	y: 1035
	width: 4
	height: 100
	backgroundColor: "rgba(255,255,255, 0.7)"
	superLayer: controls

timeStamp = new Layer
	x: Screen.width / 2 - 120
	y: 1048
	width: 100
	height: 50
	html: 0
	backgroundColor: "none"
	superLayer: controls
	style: 
		fontSize: "3rem"

durationStamp = new Layer
	x: Screen.width / 2 + 22
	y: 1048
	width: 100
	height: 50
	html: 0
	opacity: 0.4
	backgroundColor: "none"
	superLayer: controls
	style: 
		fontSize: "3rem"

# Utility Functions
video.elapsedTime = ->
	sec = Math.floor(this.player.currentTime)
	min = Math.floor(sec / 60)
	sec = Math.floor(sec % 60)
	sec = if sec >= 10 then sec else "0" + sec
	return "#{min}:#{sec}"

video.totalTime = ->
	sec = Math.floor(this.player.duration)
	min = Math.floor(sec / 60)
	sec = Math.floor(sec % 60)
	sec = if sec >= 10 then sec else "0" + sec
	return "#{min}:#{sec}"

# States
firstStart = true
isPlaying = false
isPaused = false
wasPlaying = false

# Video Events
Events.wrap(video.player).on "timeupdate", ->
	scrubber.x = (Screen.width / 2) - (video.player.currentTime * 15)
	timeStamp.html = video.elapsedTime()
	durationStamp.html = video.totalTime()

Events.wrap(video.player).on "play", ->
	isPlaying = true
	isPaused = false

Events.wrap(video.player).on "pause", ->
	isPlaying = false
	isPaused = true

# Click Event on Thumbnail
controls.on Events.Click, (event, layer) ->
	jb16.states.switch("play")
	if firstStart
		video.player.play()
		firstStart = false
	else
		controls.states.next()
		buttons.states.next()
		
	# Click Event on Pause / Play
	play.onClick ->
		video.player.play()
		pause.opacity = 1
		pause.z = 10
		this.z = 1
		this.opacity = 0

	pause.on Events.Click, (event, layer) ->
		video.player.pause()
		this.opacity = 0
		this.z = 1
		play.z = 10
		play.opacity = 1
	

# Scrubbing UX 
scrubber.draggable.enabled = true
scrubber.draggable.vertical = false
scrubber.draggable.momentum = false

scrubber.onDrag ->
	video.player.currentTime = Math.abs(scrubber.x / 15 - 25 - 0.13)
	if isPlaying
		wasPlaying = true
	video.player.pause()
	

scrubber.onDragStart ->
	scrubber.animate
		properties:
			scale: 1.4
		curve: "spring(300, 22, 0)"
	
	durationStamp.animate
		properties: 
			y: 800
			x: Screen.width / 2 + (37*1.5)
			scale: 1.5
		curve: "spring(300, 20, 0)"
	
	timeStamp.animate
		properties: 
			y: 800
			x: Screen.width / 2 - (97*1.5)
			scale: 1.5
		curve: "spring(300, 20, 0)"
	
	dial.animate
		properties: 
			y: 750
			height: 120
		curve: "spring(300, 20, 0)"


scrubber.onDragEnd ->
	durationStamp.animate
		properties: 
			y: 1048
			x: Screen.width / 2 + 22
			scale: 1
		curve: "spring(300, 20, 0)"
	
	timeStamp.animate
		properties: 
			y: 1048
			x: Screen.width / 2 - 120
			scale: 1
		curve: "spring(300, 20, 0)"
	
	dial.animate
		properties: 
			y: 1035
			height: 100
		curve: "spring(300, 20, 0)"
	
	scrubber.animate
		properties:
			scale: 1
		curve: "spring(200, 25, 0)"
	
	if isPaused
		controls.states.switch("show")
		buttons.states.switch("show")
	if wasPlaying
		controls.states.switch("default")
		buttons.states.switch("default")
		video.player.play()
		wasPlaying = false











