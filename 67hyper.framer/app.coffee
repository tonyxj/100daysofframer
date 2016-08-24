# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


# Video Setup
vid3 = new VideoLayer
	width: 1920 * (Screen.height/1080)
	height: Screen.height
	video: "images/trim1.mp4"
vid3.x = vid3.originalX = -vid3.width/3

vid3.player.play()
Events.wrap(vid3.player).on "ended", ->
	vid3.player.play()

vid2 = new VideoLayer
	width: 1920 * (Screen.height/1080)
	height: Screen.height
	video: "images/trim2.mp4"
vid2.x = vid2.originalX = -vid2.width/2.7

vid2.player.play()
Events.wrap(vid2.player).on "ended", ->
	vid2.player.play()

vid1 = new VideoLayer
	width: 1920 * (Screen.height/1080)
	height: Screen.height
	video: "images/trim3.mp4"
vid1.x = vid1.originalX = -vid1.width/1.9

vid1.player.play()
Events.wrap(vid1.player).on "ended", ->
	vid1.player.play()

# Text Vars
Framer["copy1"] = "Auto-Storify Your Videos"
Framer["copy2"] = "Auto-Add Effects and MetaData"
Framer["copy3"] = "Share Your Video Stories Today"

textStyle = 
	fontSize: "4.15rem"
	lineHeight: "4.5rem"
	textTransform: "uppercase"
	fontFamily: "Montserrat, Helvetica Neue, sans-serif"
	fontWeight: 700
	textAlign: "center"
	padding: "3rem"
	letterSpacing: "-1px"
	zIndex: 100
	paddingTop: "#{Screen.height/2.2}px"

logoStyle =
	fontSize: "4.2rem", zIndex: 101, textAlign: "center"
	fontFamily: "Garamond", fontWeight: 900, fontStyle: "italic"
	mixBlendMode: "overlay"

buttonStyle = 
	fontSize: "2.6rem", textAlign: "center"
	textTransform: "uppercase"
	fontFamily: "Montserrat, Helvetica Neue, sans-serif"
	letterSpacing: "5px", color: "#86C9FE", zIndex: 101
	fontWeight: 300

# Setup
page = new PageComponent
	size: Screen
	scrollVertical: false
	
for layer, t in [vid1, vid2, vid3]
	Framer["label#{t+1}"] = new Layer
		name: "label#{t+1}", parent: page.content
		backgroundColor: "rgba(50,50,50,0.6)"
		size: Screen		
		x: t * Screen.width
		html: Framer["copy#{t+1}"]
		style: textStyle
		
	Framer["mask#{t+1}"] = new Layer
		name: "mask#{t+1}", size: Screen, backgroundColor: ""
		x: t * Screen.width
		parent: page.content
		clip: true
	Framer["mask#{t+1}"].addChild(layer)
	
	layer.player.play()
	
	Framer["progressBar#{t+1}"] = new Layer
		name: "progressBar#{t+1}"
		width: 25, height: 40, backgroundColor: "#fff"
		opacity: 0.4, x: (Screen.width/2 + 22) - t * 35
		maxY: Screen.height - 125, originY: 0
	Framer["progressBar#{t+1}"].originalX = (Screen.width/2 + 22) - t * 35
	Framer["progressBar#{t+1}"].states.add on: height: 70, opacity: 0.8, maxY: Screen.height - 120
	Framer["progressBar#{t+1}"].states.animationOptions = 
		curve: "spring(200, 20, 0)"
	
	if t == 2 
		button = new Layer
			width: Screen.width, parent: page.content, 
			y: Screen.height - 220
			html: "Tap To Begin"
			backgroundColor: "", x: t * Screen.width
			style: buttonStyle
	
	if t == 0
		logo = new Layer
			width: Screen.width
			y: Align.center(-410), opacity: 1
			html: "prescient", backgroundColor: null
			style: logoStyle


Framer["progressBar3"].states.switch("on")
	
page.content.on "change:x", ->
	if Framer["label2"].screenFrame.x < -3
		for i in [1..3]
			Framer["progressBar#{i}"].x = Framer["progressBar#{i}"].originalX + Framer["label2"].screenFrame.x
	else
		for i in [1..3]
			Framer["progressBar#{i}"].x = Framer["progressBar#{i}"].originalX
	
	for layer, t in [vid1, vid2, vid3]
		Framer["offsetX#{t+1}"] = Framer["mask#{t+1}"].screenFrame.x
		layer.x = layer.originalX + (-Framer["offsetX#{t+1}"])

page.on "change:currentPage", ->
	if page.currentPage == Framer["label1"]
		Framer["progressBar3"].states.switch("on")
		Framer["progressBar2"].states.switch("default")
		Framer["progressBar1"].states.switch("default")
	if page.currentPage == Framer["label2"]
		Framer["progressBar2"].states.switch("on")
		Framer["progressBar1"].states.switch("default")
		Framer["progressBar3"].states.switch("default")
	if page.currentPage == Framer["label3"]
		Framer["progressBar1"].states.switch("on")
