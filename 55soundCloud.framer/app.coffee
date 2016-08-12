# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


# Setup
# Import sketch file "soundCloud"
sketch = Framer.Importer.load("imported/soundCloud@1x")
Utils.globalLayers(sketch)
new BackgroundLayer backgroundColor: "#000"

# Variables
Framer.Defaults.Animation = time: 0.3
defaultSpring = curve: "spring(150, 13, 0)"

show = {show: opacity: 1}
hide = {hide: opacity: 0}
bounceHide = {bounceHide: scaleY: 0}
dragging = {dragging: scale: 1.9, y: Align.center(80)}

bgScaleUp = 1.1
bgBlur = 70

Framer["pause1"] = false
Framer["pause2"] = false

Framer["isDragging1"] = false
Framer["isDragging2"] = false

Framer["elapsedSec1"] = 0
Framer["elapsedSec2"] = 0

Framer["currentTime1"] = ""
Framer["currentTime2"] = ""

Framer["songLength1"] = 79
Framer["songLength2"] = 283

# Base Layers and States
page = new PageComponent
	size: Screen, scrollVertical: false

# States
for layer in [buttonsLine1, buttonsLine2, overlay1, overlay2]
	layer.opacity = 0
	layer.states.add show

for layer in [artistBg1, artistBg2, titleBg1, titleBg2, buttonsBase1, buttonsBase2, nextButton1, playButton1, nextButton2, playButton2, icons1, icons2, title1, title2, artist1, artist2]
	layer.states.add hide

# Functions
# Utility
# Second to MM:SS Function
timeFromSeconds = (seconds) ->
	if seconds > 0
		return new Date(seconds * 1000).toISOString().substr(15, 4)
	else
		return "0:00"

# Interaction Functions
pausePlay = (artboard) ->
	num = 1 if artboard is Artboard1
	num = 2 if artboard is Artboard2
		
	sketch["overlay#{num}"].states.next()
	if sketch["bg#{num}"].blur is 0
		sketch["bg#{num}"].animate properties: blur: bgBlur, scale: bgScaleUp
	else sketch["bg#{num}"].animate properties: blur: 0, scale: 1
	sketch["buttonsLine#{num}"].states.next()
	sketch["buttonsBase#{num}"].states.next()
	sketch["titleBg#{num}"].states.next()
	sketch["artistBg#{num}"].states.next()
	Framer["timeStampBg#{num}"].states.next()
	
	for layer in Framer["trackArea#{num}"].children
		layer.states.next()
	
	if Framer["pause#{num}"] is false 
		Framer["pause#{num}"]  = true
	else Framer["pause#{num}"] = false
	trackMoveStop(num)

trackMoveStop = (num) ->
	midPoint = Framer["track#{num}"].width/2
	distRemain = Framer["track#{num}"].x - midPoint
	songTime = Framer["songLength#{num}"]
	
	animationTime = Utils.modulate(distRemain, [0, -midPoint*2], [79, 0])
	
	if Framer["pause#{num}"] is false
		Framer["track#{num}"].animate 
			properties: 
				x: -Framer["track#{c}"].width/2
			curve: "linear"
			time: animationTime

		Framer["animation#{num}"] = new Animation
			layer: sketch["bg#{num}"]
			properties: maxX: Screen.width
			curve: "linear"
			time: animationTime
		Framer["animation#{num}"].start()
		
	else 
		Framer["track#{num}"].animateStop()
		if Framer["animation#{num}"]
			Framer["animation#{num}"].stop()
	
dragStart = (track) ->
	page.scrollHorizontal = false
	num = 1 if track is "track1" 
	num = 2 if track is "track2"
	
	Framer["isDragging#{num}"] = true
	
	sketch["overlay#{num}"].states.switch("show")
	sketch["icons#{num}"].states.switch("hide")
	sketch["title#{num}"].states.switch("hide")
	sketch["artist#{num}"].states.switch("hide")
	sketch["nextButton#{num}"].opacity = 0
	sketch["playButton#{num}"].opacity = 0
	sketch["bg#{num}"].animate properties: blur: bgBlur
	sketch["bg#{num}"].animate properties: scale: bgScaleUp
	
	Framer["timeStampBg#{num}"].states.switch("hide")
	Framer["textGroup#{num}"].states.switch("dragging")
	if Framer["animation#{num}"]
			Framer["animation#{num}"].stop()

dragEnd = (track) ->
	Utils.delay 0.5, ->
		page.scrollHorizontal = true
	num = 1 if track is "track1" 
	num = 2 if track is "track2"
	
	Framer["isDragging#{num}"] = false
	
	sketch["overlay#{num}"].states.switch("default")
	sketch["icons#{num}"].states.switch("default")
	sketch["title#{num}"].states.switch("default")
	sketch["artist#{num}"].states.switch("default")
	
	Framer["timeStampBg#{num}"].states.switch("default")
	Framer["textGroup#{num}"].states.switch("default")
	
	sketch["nextButton#{num}"].animate properties: opacity: 1
	sketch["playButton#{num}"].animate properties: opacity: 1
	sketch["bg#{num}"].animate properties: blur: 0
	sketch["bg#{num}"].animate properties: scale: 1
	
	if Framer["pause#{num}"] is true
		sketch["bg#{num}"].animate properties: blur: bgBlur
		sketch["bg#{num}"].animate properties: scale: bgScaleUp
		sketch["overlay#{num}"].states.switch("show")
		Framer["timeStampBg#{num}"].states.switch("hide")
	
	trackMoveStop(num)

drag = (track) ->
	num = 1 if track is "track1" 
	num = 2 if track is "track2"
	x = Framer[track].x
	song = Framer["songLength#{num}"]
	trackStart = Framer[track].width/2
	trackEnd = -Framer[track].width/2
	currentTime = Math.round(Utils.modulate(x, [trackStart, trackEnd], [0, song]))
	Framer["elapsedSec#{num}"] = currentTime
	Framer["elasedText#{num}"].html = timeFromSeconds(currentTime)

move = (track) ->
	num = 1 if track is "track1" 
	num = 2 if track is "track2"
	x = Framer[track].x
	trackStart = Framer[track].width/2
	trackEnd = -Framer[track].width/2
	travelLength = sketch["bg#{num}"].width - Screen.width
	pos = Math.round(Utils.modulate(x, [trackStart, trackEnd], [0, -travelLength]))
	sketch["bg#{num}"].x = pos
	for layer in Framer["trackArea#{num}"].children
		if layer.screenFrame.x < Framer[track].width/2 - 3
			layer.backgroundColor = "orange"
		else
			layer.backgroundColor = "#fff"
 
# Calc Track Progress
Utils.interval 1, ->
	for layer, t in [Artboard1, Artboard2]
		c = t + 1
		if Framer["pause#{c}"] is false
			if Framer["elapsedSec#{c}"] >= Framer["songLength#{c}"]
				Framer["elapsedSec#{c}"] == Framer["songLength#{c}"]
			else
				Framer["elapsedSec#{c}"] += 1 

# Track Layers and Events
for layer, t in [Artboard1, Artboard2]
	c = t + 1
	Framer["clipBox#{c}"] = new Layer
		size: Screen, backgroundColor: "", x: t * Screen.width
		parent: page.content, clip: true, name: "clipBox#{c}"
		
	layer.x = 0
	layer.parent = Framer["clipBox#{c}"]
	
	# Create track for each artboard
	Framer["track#{c}"] = new Layer
		height: 250, width: Screen.width, backgroundColor: ""
		maxY: Screen.height - 250, x: Screen.width / 2
		parent: Framer["clipBox#{c}"], name: "track#{c}"
	
	Framer["trackArea#{c}"] = new Layer
		height: Framer["track#{c}"].height, width: Framer["track#{c}"].width
		backgroundColor: "", x: 0, parent: Framer["track#{c}"]
		name: "trackArea#{c}"
		
	barY = Framer["track#{c}"].height - 100
	barW = 6
	
	trackLine = new Layer
		width: Framer["track#{c}"].width
		height: 3, backgroundColor: "#fff"
		x: 0, y: barY, parent: Framer["track#{c}"], name: "trackLine#{c}"
		
	Framer["elaspedTrackLine#{c}"] = new Layer
		width: 0
		height: 3, backgroundColor: "orange"
		maxX: Framer["track#{c}"].width/2, y: trackLine.screenFrame.y
		parent: Framer["clipBox#{c}"], name: "elaspedTrackLine#{c}"
	
	# Create music bars for each track
	for i in [0...Math.round(Screen.width / (barW + 2.5))]
		bar = new Layer
			width: barW, height: Utils.randomNumber(60, 150)
			maxY: barY, x: i * (barW + 2.5), originY: 1
			backgroundColor: "#fff", parent: Framer["trackArea#{c}"]
			opacity: 0.9
		bar.states.add bounceHide
		bar.states.animationOptions = defaultSpring
			
		barShadow = bar.copy()
		barShadow.props =
			parent: Framer["trackArea#{c}"], y: barY
			scaleY: 0.7, originY: 0, opacity: 0.4
		barShadow.states.add bounceHide
		barShadow.states.animationOptions = defaultSpring
		
	# Create Time Stamp
	Framer["timeStampBg#{c}"] = new Layer
		width: 220, height: 50, backgroundColor: "#000"
		x: Align.center, y: Align.center(292)
		parent: Framer["clipBox#{c}"], name: "timeStampBg#{c}"
	Framer["timeStampBg#{c}"].states.add hide
	
	Framer["textGroup#{c}"] = new Layer
		width: 220, height: 50, backgroundColor: ""
		x: Align.center, y: Align.center(292)
		parent: Framer["clipBox#{c}"], name: "textGroup#{c}"
	Framer["textGroup#{c}"].states.add dragging
	
	Framer["elasedText#{c}"] = new Layer
		html: "0:00", parent: Framer["textGroup#{c}"], backgroundColor: ""
		width: 70, height: 40, x: Align.center(-59), y: Align.center(5)
		name: "elapsedText#{c}"
		style: fontFamily: "monospace", fontSize: "2rem"
	
	Framer["totalText#{c}"] = new Layer
		html: timeFromSeconds(Framer["songLength#{c}"])
		parent: Framer["textGroup#{c}"], backgroundColor: ""
		width: 70, height: 40, x: Align.center(52), y: Align.center(5)
		name: "totalText#{c}"
		style: fontFamily: "monospace", textAlign: "right", fontSize: "2rem"
	
	Framer["divider#{c}"] = new Layer
		width: 1, height: 25, backgroundColor: "#fff", x: Align.center
		y: Align.center(1), parent: Framer["textGroup#{c}"], name: "divider"
	
	# Make the track draggable
	Framer["track#{c}"].draggable.enabled = true
	Framer["track#{c}"].draggable.vertical = false
	Framer["track#{c}"].draggable.constraints =
		x: -(Framer["track#{c}"].width/2), width: Framer["track#{c}"].width * 2
	Framer["track#{c}"].draggable.overdrag = false
	Framer["track#{c}"].draggable.momentumOptions = friction: 18
	
	# Drag event
	Framer["track#{c}"].onTouchStart ->
		dragStart(@name)
	
	Framer["track#{c}"].onDrag ->
		drag(@name)
	
	Framer["track#{c}"].onDragEnd ->
		dragEnd(@name)
		
	Framer["track#{c}"].onMove ->
		move(@name)
	
	# Pause click event
	layer.onClick -> 
		pausePlay(this)

Utils.interval 1, ->
	for layer, t in [Artboard1, Artboard2]
		c = t + 1
		if Framer["isDragging#{c}"] is false
			Framer["currentTime#{c}"] = timeFromSeconds(Framer["elapsedSec#{c}"])
			Framer["elasedText#{c}"].html = Framer["currentTime#{c}"]
		
		for layer in Framer["trackArea#{c}"].children
			if layer.screenFrame.x < Framer["trackArea#{c}"].width/2 - 2
				layer.backgroundColor = "orange"
			else
				layer.backgroundColor = "#fff"

pausePlay(Artboard1)
pausePlay(Artboard2)





