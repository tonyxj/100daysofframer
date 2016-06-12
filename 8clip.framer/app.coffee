# Import file "day5"
sketch = Framer.Importer.load("imported/day5@1x")

Framer.Device.background.backgroundColor = "#39eed1"

albumCover = new Layer
	width: Screen.width
	height: 800
	image: "images/albumCover.jpg"

albumTitle = new Layer
	width: Screen.width
	height: 900
	y: 496
	backgroundColor: "#fff"

albumTitleGradient = new Layer
	width: Screen.width
	height: 200
	superLayer: albumTitle
	y: -199
	style: background: "linear-gradient(180deg, rgba(255,255,255, 0) 0%, white 100%)"

container = new Layer
	width: Screen.width
	height: 400
	x: Align.center
	y: 300
	backgroundColor: "rgba(255,255,255, 0.0)"
	clip: true

rotator = new Layer
	width: 500
	height: 200
	superLayer: container
	y: Align.center
	x: 220
	backgroundColor: "rgba(255,255,255, 0.0)"

button = new Layer
	width: 120
	height: 120
	borderRadius: "50%"
	superLayer: rotator
	y: Align.center
	x: 350
	backgroundColor: "rgb(75,210,15)"

invibutton = new Layer
	width: 120
	height: 120
	borderRadius: "50%"
	superLayer: rotator
	y: Align.center
	x: 350
	backgroundColor: "none"


controls = new Layer
	width: 60
	height: 60
	superLayer: container
	backgroundColor: "none"
controls.center()

backButtonMask = new Layer
	width: 500
	height: 42
	superLayer: invibutton
	y: Align.center
	backgroundColor: "none"
	x: -453
	clip: true

playButtonMask = new Layer
	width: 34
	height: 42
	superLayer: invibutton
	y: Align.center
	x: 46
	clip: true
	backgroundColor: "none"

sketch.play.superLayer = playButtonMask
sketch.play.centerY()
sketch.play.x = -6
sketch.play.scale = 0.65

sketch.n2.superLayer = invibutton
sketch.n2.centerY()
sketch.n2.x = 41
sketch.n2.scale = 0.65

sketch.n1.superLayer = invibutton
sketch.n1.centerY()
sketch.n1.x = 41
sketch.n1.scale = 0.65

sketch.l2.superLayer = invibutton
sketch.l2.centerY()
sketch.l2.x = 46
sketch.l2.scale = 0.65

sketch.l1.superLayer = invibutton
sketch.l1.centerY()
sketch.l1.x = 46
sketch.l1.scale = 0.65

sketch.b2.superLayer = backButtonMask
sketch.b2.centerY()
sketch.b2.x = 492
sketch.b2.scale = 0.65

sketch.b1.superLayer = backButtonMask
sketch.b1.centerY()
sketch.b1.x = 492
sketch.b1.scale = 0.65

songListD = new Layer
	width: 762
	height: 635
	scale: 0.85
	superLayer: albumTitle
	x: -12
	y: 195
	image: "images/songList.png"

title = new Layer
	width: 421
	height: 107
	x: 45
	y: 478
	image: "images/title.png"

track = new Layer
	width: 462
	height: 39
	scale: 0.7
	x: 156
	y: 53
	superLayer: container
	opacity: 0
	image: "images/track.png"

icons = new Layer
	width: 1436
	height: 77
	scale: 0.45
	y: 300
	x: -339
	superLayer: container
	opacity: 0
	image: "images/icons.png"

timeLine = new Layer
	width: Screen.width
	height: 30
	y: 0
	opacity: 0
	superLayer: container
	style:
		paddingLeft: "680px"
	backgroundColor: "rgba(0,0,0, 0.08)"
	
currentTime = new Layer
	width: 200
	height: 30
	html: "0:00"
	x: -135
	y: 0
	superLayer: timeLine
	style: 
		background: "linear-gradient(90deg, rgba(0,0,0, 0) 0%, rgba(0,0,0, 0.18) 100%)"
		color: "rgba(255,255,255,0.65)"
		fontSize: "1.5rem"
		paddingTop: "2px"
		textAlign: "right"
		paddingRight: "8px"
		

animateMove = true

time = 0
Utils.interval 1, ->
	time += 1

button.onClick ->
	if animateMove
	
		albumTitle.animate
			properties: 
				y: 790
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.6
			
		title.animate
			properties: 
				scale: 0.8
				x: -3
				y: 575
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.6
			
		track.animate
			delay: 0.8
			properties: 
				opacity: 0.8
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.3
		
		icons.animate
			delay: 0.8
			properties: 
				opacity: 0.7
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.3
		
		time = 0
		
		Utils.interval 1, ->
			if time <= 9
				currentTime.html= "0:0" + time
			else if (time > 9 && time <= 44)
				currentTime.html= "0:" + time
			if time >= 45
				currentTime.html= "0:45"
		
		currentTime.animate
			delay: 0.8
			properties: 
				x: Screen.width - 200
			curve: "linear"
			time: 45
		
		timeLine.animate
			delay: 0.8
			properties: 
				opacity: 1
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.3
			
			
		
		button.animate
			delay: 0.5
			properties: 
				scale: 10
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.6
		
		invibutton.animate
			properties: 
				rotation: -180
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.6
		
		rotator.animate
			properties: 
				x: 300
				y: 90
				rotation: 180
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.6
		
		container.animate
			properties: 
				y: 700
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.6
		
		sketch.n2.animate
			delay: 0.7
			properties: 
				x: 255
			curve: "spring(300, 20, 0)"
			time: 0.6
		
		sketch.n1.animate
			delay: 0.73
			properties: 
				x: 230
			curve: "spring(300, 20, 0)"
			time: 0.6
			
		sketch.b2.animate
			delay: 0.7
			properties: 
				x: 263
			curve: "spring(300, 20, 0)"
			time: 0.6
		
		sketch.b1.animate
			delay: 0.73
			properties: 
				x: 289
			curve: "spring(300, 20, 0)"
			time: 0.6
		
		sketch.play.animate
			delay: 0.7
			properties: 
				x: -43
			curve: "spring(300, 20, 0)"
			time: 0.6
		
		sketch.l2.animate
			delay: 0.7
			properties: 
				x: 65
			curve: "spring(300, 20, 0)"
			time: 0.6
		
		animateMove = false
		
	else
		albumTitle.animate
			delay: 0.5
			properties: 
				y: 496
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.6
			
		title.animate
			delay: 0.5
			properties: 
				scale: 1
				x: 45
				y: 478
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.6
			
		track.animate
			properties: 
				opacity: 0
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.3
		
		icons.animate
			properties: 
				opacity: 0
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.3
		
		currentTime.animate
				delay: 0.8
				properties: 
					x: -135
				curve: "linear"
				time: 0.5
		
		timeLine.animate
			properties: 
				opacity: 0
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.3
			
	
		sketch.n2.animate
			properties: 
				x: 41
# 			curve: "spring(300, 20, 0)"
			time: 0.3
		
		sketch.n1.animate
			properties: 
				x: 41
# 			curve: "spring(300, 20, 0)"
			time: 0.3
			
		sketch.b2.animate
			properties: 
				x: 492
# 			curve: "spring(300, 20, 0)"
			time: 0.3
		
		sketch.b1.animate
			properties: 
				x: 492
# 			curve: "spring(300, 20, 0)"
			time: 0.3
		
		sketch.play.animate
			properties: 
				x: -6
# 			curve: "spring(300, 20, 0)"
			time: 0.3
		
		sketch.l2.animate
			properties: 
				x: 46
# 			curve: "spring(300, 20, 0)"
			time: 0.3
			
	
		button.animate
			properties: 
				scale: 1
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.3
		
		rotator.animate
			delay: 0.3
			properties: 
				x: 220
				y: Align.center
				rotation: 0
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.6
		
		invibutton.animate
			delay: 0.3
			properties: 
				rotation: 0
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.6
		
		container.animate
			delay: 0.3
			properties: 
				y: 300
			curve: "cubic-bezier(0.4, 0, 0.2, 1)"
			time: 0.6
	
		animateMove = true



