# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


new BackgroundLayer backgroundColor: "#fff"
Framer.Defaults.Animation = curve: "ease-in-out", time: 0.25
thumbnails = []
textStyle = 
		fontFamily: "Helvetica Neue"
		color: "black"
		fontSize: "2.2rem"
		fontWeight: 500
		textAlign: "center"
		lineHeight: "7.3rem"

accountPage = new Layer
	size: Screen, backgroundColor: ""
accountPage.states.add on: x: -100

accountPageBar = new Layer
	height: 120, width: Screen.width
	backgroundColor: "#efefef", html: "accountName"
	style: textStyle
accountPageBar.states.add on: opacity: 0
accountPageBar.states.animationOptions = time: 0.3

photoPageBar = new Layer
	height: accountPageBar.height, width: Screen.width, opacity: 0
	backgroundColor: "#efefef", html: "Photo"
	style: textStyle
photoPageBar.states.add on: opacity: 1

backButton  = new Layer
	html: "< Back", parent: photoPageBar, height: photoPageBar.height
	backgroundColor: "", style: textStyle
	opacity: 0.7, width: 145, scale: 0.9
	
backButton.onClick ->
	backToDefault()

backToDefault = ->
	accountPage.states.switch("default")
	accountPageBar.states.switch("default")
	photoPageBar.states.switch("default")
	photoPage.states.switch("default")
	for layer in thumbnails
		layer.ignoreEvents = false
	
for i in [0...3]
	for j in [0...6]
		thumbnail = new Layer
			size: Screen.width/3 - 1
			x: i * (Screen.width/3 + 1)
			y: j * (Screen.width/3 + 1) + accountPageBar.height
			image: Utils.randomImage()
			parent: accountPage
		
		thumbnails.push thumbnail
		thumbnail.onClick ->
			imageCopy = this.image
			image.image = imageCopy
			
			accountPage.states.next()
			accountPageBar.states.next()
			photoPageBar.states.next()
			photoPage.states.next()
			
			for layer in thumbnails
				layer.ignoreEvents = true

photoPage = new Layer
	size: Screen, backgroundColor: "#fefefe", x: Screen.width
photoPage.states.add on: x: 0

image = new Layer
	size: Screen.width, parent: photoPage, y: accountPageBar.height

photoPageBar.bringToFront()
accountPageBar.bringToFront()

photoPage.on Events.Swipe, (event)->
	dist = event.offset.x
	@x = dist unless dist < 0
	accountPage.x = Utils.modulate(dist, [0, Screen.width], [-100, 0], true)

photoPage.onSwipeEnd ->
	backToDefault()
	