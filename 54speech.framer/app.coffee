# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: "Speech Recog Demo"
	author: "Tony"
	twitter: "TonyJing"
	description: "A rebound of Brian Bailey's Speech Recog demo."


# Variables
promptWidth = Screen.width / 1.5
numAudioBumps = Math.floor(Utils.randomChoice([12,17]))

# Layers and Animations
prompt = new Layer
	size: promptWidth
	x: Align.center, y: Align.center(-150)
	backgroundColor: "", html: "What can I help you with?"
	style:
		textAlign: "center", fontSize: "4.1rem", lineHeight: "5rem"
		fontFamily: "Helvetica Neue", fontWeight: 300
prompt.states.add hide: opacity: 0

text = new Layer
	width: Screen.width-60, x: 30, y: 50, backgroundColor: ""
	style: fontSize: "2.6rem", lineHeight: "3rem", fontWeight: 300, textAlign: "right"

bumpContainer = new Layer
	size: Screen.size, backgroundColor: "", opacity: 0
bumpContainer.states.add show: opacity: 1

lineContainer = bumpContainer.copy()
lineContainer.states.add show: opacity: 1

mic = new Layer
	width: 555/12, height: 1024/12
	x: Align.center, y: Align.center(560), image: "images/MikeThePhone.png"
mic.states.add hide: opacity: 0
mic.states.animationOptions = time: 0.3

createAudioBumps = ->
	for i in [0..numAudioBumps]
		audioBump = new Layer
			width: Utils.randomNumber(120, 320), height: Utils.randomNumber(20, 120)
			borderRadius: "100%", backgroundColor: Utils.randomColor().lighten(10)
			opacity: 0.26, scaleY: 0.1, parent: bumpContainer
			y: Align.center(560), x: Align.center(Utils.randomNumber(-150,150))
		current = audioBump
		
		audioBumpLine = audioBump.copy()
		audioBumpLine.props = 
			blur: 0, parent: bumpContainer
			height: Utils.randomNumber(5, 20), backgroundColor: "#fff"
			opacity: 1, scaleY: 0.1, y: Align.center(560)
		
		jumpUpA = new Animation
			layer: audioBump
			properties:
				scaleY: Utils.randomNumber(1, 1.3)
				scaleX: Utils.randomNumber(1, 1.15)
			time: Utils.randomNumber(0.2, 0.5), curve: "ease-out"
			delay: Utils.randomNumber(0, 0.2)
		
		jumpUpB = new Animation
			layer: audioBump
			properties:
				scaleY: Utils.randomNumber(0.5, 0.7)
				scaleX: Utils.randomNumber(0.8, 0.9)
			time: Utils.randomNumber(0.15, 0.25), curve: "ease-out"
			delay: Utils.randomNumber(0, 0.3)
		
		jumpUpLineA = new Animation
			layer: audioBumpLine
			properties:
				scaleY: Utils.randomNumber(1.2, 2.3)
				scaleX: Utils.randomNumber(1, 1.15)
			time: Utils.randomNumber(0.2, 0.5), curve: "ease-out"
			delay: Utils.randomNumber(0, 0.3)
		
		jumpUpLineB = new Animation
			layer: audioBumpLine
			properties:
				scaleY: Utils.randomNumber(0.55, 0.8)
				scaleX: Utils.randomNumber(0.8, 0.9)
			time: Utils.randomNumber(0.2, 0.5), curve: "ease-out"
			delay: Utils.randomNumber(0, 0.3)
		
		jumpUpA.on(Events.AnimationEnd, jumpUpB.start)
		jumpUpB.on(Events.AnimationEnd, jumpUpA.start)
		
		jumpUpLineA.on(Events.AnimationEnd, jumpUpLineB.start)
		jumpUpLineB.on(Events.AnimationEnd, jumpUpLineA.start)
		
		jumpUpA.start()
		jumpUpLineA.start()

line = new Layer
	width: Screen.width/1.1, height: 3, backgroundColor: "#fff"
	y: Align.center(560), x: Align.center
	parent: lineContainer

lineCenter = line.copy()
lineCenter.props = 
	width: promptWidth, height: 9, x: Align.center,  y: Align.center(560)
	borderRadius: "50%", backgroundColor: "#fff", parent: lineContainer
	shadowColor: "#fff", shadowBlur: 5, shadowSpread: 2

lineCenterA = new Animation
	layer: lineCenter
	properties:
		scaleY: Utils.randomNumber(1.2, 1.9)
		scaleX: Utils.randomNumber(1, 1.15)
	time: Utils.randomNumber(0.3, 0.55), curve: "ease-out"
	delay: Utils.randomNumber(0, 0.2)
	
lineCenterB = new Animation
	layer: lineCenter
	properties:
		scaleY: Utils.randomNumber(0.9, 1.1)
		scaleX: Utils.randomNumber(0.9, 1.1)
	time: Utils.randomNumber(0.45, 0.55), curve: "ease-out"
	delay: Utils.randomNumber(0, 0.2)

lineCenterA.on(Events.AnimationEnd, lineCenterB.start)
lineCenterB.on(Events.AnimationEnd, lineCenterA.start)



# Speech Recognition API
# This API is currently prefixed in Chrome
SpeechRecognition = window.SpeechRecognition or window.webkitSpeechRecognition

recognizer = new SpeechRecognition
recognizer.interimResults = true
recognizer.lang = 'en-US'



# Events
mic.onClick ->
	bumpContainer.states.switch("show")
	lineContainer.states.switch("show")
	lineCenterA.start()
	mic.states.switch("hide")
	recognizer.start()

recognizer.onspeechstart = (event) ->
	createAudioBumps()
	prompt.states.switch("hide")
	
recognizer.onspeechend = (event) ->
	lineContainer.states.switch("default")
	bumpContainer.states.switch("default")
	Utils.delay 0.8, ->
		mic.states.switch("default")
	for layer in bumpContainer.subLayers
		layer.destroy()

recognizer.onresult = (event) ->
	result = event.results[event.resultIndex]
	if result.isFinal
# 		print 'You said: ' + result[0].transcript
		text.html = result[0].transcript
	else
# 		print 'Interim result', result[0].transcript
		text.html = result[0].transcript
	return