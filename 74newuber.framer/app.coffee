# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


# Elements setup
bg = new BackgroundLayer
	backgroundColor: "gray"

mapClip = new Layer
	width: Screen.width * 1.5
	height: Screen.width * 1.5
	x: Align.center
	y: Align.center
	borderRadius: "50%"
	backgroundColor: "lightblue"
	scale: 0.15
	rotation: -30
	clip: true
	
map = new Layer
	width: Screen.width * 1.5
	height: Screen.height * 1.5
	x: Align.center
	y: Align.center
	backgroundColor: "#DDE2E3"
	parent: mapClip
	scale: 0.57

for i in [0 ... 19]
	street = new Layer
		parent: map
		height: 6
		width: map.width
		x: 0
		y: i * 200
		backgroundColor: "white"
	avenue = new Layer
		parent: map
		height: map.height
		width: 2
		y: 0
		x: i * 60
		backgroundColor: "white"

menu = new Layer
	width: 35
	height: 21
	backgroundColor: "none"
	x: 65
	y: 70

menuBar1 = new Layer
	width: menu.width
	height: 2
	backgroundColor: "black"
	parent: menu
menuBar2 = new Layer
	width: menu.width
	height: 2
	midY: menu.height / 2
	backgroundColor: "black"
	parent: menu
menuBar3 = new Layer
	width: menu.width
	height: 2
	maxY: menu.height
	backgroundColor: "black"
	parent: menu

messageCard = new Layer
	width: Screen.width * 0.95
	height: Screen.height / 2.5
	backgroundColor: "#3d9fc6"
	x: Align.center
	borderRadius: 6
	maxY: Screen.height + 410
	shadowY: -10
	shadowBlur: 80
	shadowSpread: 50
	shadowColor: "#DDE2E3" 
	html: "Meet your new Uber app"
	style:
		fontFamily: "Roboto"
		fontSize: "1.55rem"
		padding: "1.7rem 0 0 2rem"
		color: "rgba(255,255,255,0.5)"

frequentAddress1 = new Layer
	borderRadius: "50%"
	backgroundColor: "white"
	size: 110
	y: Screen.height * 0.7
	shadowY: 25
	shadowBlur: 45
	shadowColor: "rgba(0,0,0,0.22)"

frequentAddress2 = frequentAddress1.copy()
frequentAddress3 = frequentAddress1.copy()

frequentAddress1.x = Align.center(-frequentAddress1.width * 1.7)
frequentAddress2.x = Align.center
frequentAddress3.x = Align.center(frequentAddress1.width * 1.7)

frequentAText1 = new Layer
	html: "636 2nd Ave"
	backgroundColor: "none"
	color: "#333"
	parent: frequentAddress1
	width: frequentAddress1.width * 1.4
	midX: frequentAddress1.width / 2
	y: frequentAddress1.height + 35
	style:
		textAlign: "center"
		fontFamily: "Roboto"
		fontSize: "1.6rem"
		
frequentShape1 = new Layer
	size: 35
	borderWidth: 4
	backgroundColor: ""
	borderColor: "black"
	parent: frequentAddress1
	midX: frequentAddress1.width / 2
	midY: frequentAddress1.height / 2
		
frequentAText2 = new Layer
	html: "153 Kearny Street"
	color: "#333"
	parent: frequentAddress2
	backgroundColor: "none"
	width: frequentAddress2.width * 1.4
	midX: frequentAddress2.width / 2
	y: frequentAddress1.height + 35
	style:
		textAlign: "center"
		fontFamily: "Roboto"
		fontSize: "1.6rem"

frequentShape2 = frequentShape1.copy()
frequentShape2.props = 
	parent: frequentAddress2
	width: 55
	midX: frequentAddress2.width / 2
	midY: frequentAddress2.height / 2 + 10
	borderRadius: 5
	height: 15

frequentAText2 = new Layer
	html: "1455 Market Street"
	color: "#333"
	parent: frequentAddress3
	backgroundColor: "none"
	width: frequentAddress3.width * 1.4
	midX: frequentAddress3.width / 2
	y: frequentAddress1.height + 35
	style:
		textAlign: "center"
		fontFamily: "Roboto"
		fontSize: "1.6rem"
		
frequentShape3 = frequentShape1.copy()
frequentShape3.props = 
	parent: frequentAddress3
	size: 30
	midX: frequentAddress3.width / 2
	midY: frequentAddress3.height / 2 
	borderRadius: "50%"

currentLocationCirlce1 = new Layer
	size: 100
	borderRadius: "50%"
	borderColor: "#3Fa0c6"
	borderWidth: 2
	backgroundColor: ""
	opacity: 0.5
	x: Align.center
	y: Align.center
	scale: 0

currentLocationCirlce2 = new Layer
	size: 100
	borderRadius: "50%"
	backgroundColor: "#3Fa0c6"
	opacity: 0.16
	x: Align.center
	y: Align.center
	scale: 0
	
splashScreen = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: "black"

splashCircle = new Layer
	size: 140
	borderRadius: "50%"
	backgroundColor: "white"
	parent: splashScreen
	midX: Screen.width / 2
	midY: Screen.height / 2
	
splashSymbol = new Layer
	size: 40
	midX: Screen.width / 2
	midY: Screen.height / 2
	backgroundColor: "black"
	shadowBlur: 50
	shadowY: Screen.height / 2
	shadowColor: "rgba(0,0,0,0.3)"

splashLine = new Layer
	maxX: Screen.width / 2
	midY: Screen.height / 2
	height: 10
	backgroundColor: "black"

searchBar = new Layer
	width: Screen.width / 1.2
	height: 105
	x: Align.center
	y: Screen.height * 0.14
	backgroundColor: "white"
	borderRadius: 5
	shadowY: 50
	shadowBlur: 55
	shadowSpread: 0
	shadowColor: "rgba(0,0,0,0.22)"
	html: "Where to?"
	color: "#555"
	style:
		fontSize: "2.4rem"
		padding: "2.5rem"
		paddingLeft: "5rem"
		fontWeight: 300
		fontFamily: "Roboto"

searchBarDot = new Layer
	parent: searchBar
	size: 12
	y: Align.center
	backgroundColor: "black"
	x: 40

addressDot1 = new Layer
	size: 19
	borderRadius: "50%"
	backgroundColor: "black"
	midY: frequentAddress1.midY
	x: Screen.width * 1.2

addressDot2 = addressDot1.copy()
addressDot3 = addressDot1.copy()

# States & Animation
fadeTime = 0.5

# Circle drop animation
circleDrop1 = new Animation
	layer: currentLocationCirlce1
	properties:  scale: 3, opacity: 0
	time: fadeTime * 2
circleDrop2 = new Animation
	layer: currentLocationCirlce2
	properties:  scale: 2
	time: fadeTime * 1.8
	curve: "ease-in-out"

# Slide in dots animation
slide1 = new Animation
	layer: addressDot1
	properties: midX: frequentAddress1.midX
	time: fadeTime * 2

slide2 = new Animation
	layer: addressDot2
	properties: midX: frequentAddress2.midX
	time: fadeTime * 2
	delay: fadeTime / 2

slide3 = new Animation
	layer: addressDot3
	properties: midX: frequentAddress3.midX
	time: fadeTime * 2
	delay: fadeTime

dotExpand1 = () =>
	addressDot1.animate
		properties: scale: 7.2, opacity: 0
	time: fadeTime
	frequentAddress1.states.switch("default")

dotExpand2 = () =>
	addressDot2.animate
		properties: scale: 7.2, opacity: 0
	time: fadeTime
	frequentAddress2.states.switch("default")

dotExpand3 = () =>
	addressDot3.animate
		properties: scale: 7.2, opacity: 0
	time: fadeTime
	frequentAddress3.states.switch("default")

# Splash Screen
splashScreen.states.add
	on: 
		opacity: 0
splashScreen.states.animationOptions = 
	time: fadeTime * 5.5

splashCircle.states.add 
	on: 
		scale: 4
		opacity: 0
splashCircle.states.animationOptions = 
	curve: "spring(64, 10, 0)"
	
splashLine.states.add 
	on: 
		scaleY: 0
splashLine.states.animationOptions = 
	time: fadeTime * 0.7

splashSymbol.states.add 
	on: 
		scale: 0.6
		backgroundColor: "#3Fa0c6"
		borderRadius: "50%"
		shadowY: 10
splashSymbol.states.animationOptions = 
	time: fadeTime * 4

# Map Clip
mapClip.states.add
	on: 
		scale: 2.5
		rotation: 20
mapClip.states.animationOptions = 
	time: fadeTime * 4.5
	delay: 0.1
	curve: "spring(20, 20, 0)"

# Search Bar
searchBar.states.add
	hide: 
		y: - 300
		scale: 0.6
		shadowY: -100
		shadowColor: ""
searchBar.states.animationOptions = 
	time: fadeTime * 4.2

# frequent address
frequentAddress1.states.add
	hide: 
		scale: 0
		opacity: 0
frequentAddress1.states.animationOptions = 
	time: fadeTime
	curve: "ease-in-out"
	
frequentAddress2.states.add
	hide: 
		scale: 0
		opacity: 0
frequentAddress2.states.animationOptions = 
	time: fadeTime
	curve: "ease-in-out"
	
frequentAddress3.states.add
	hide: 
		scale: 0
		opacity: 0
frequentAddress3.states.animationOptions = 
	time: fadeTime
	curve: "ease-in-out"
	
# message card
messageCard.states.add
	hide:
		y: Screen.height * 1.2
messageCard.states.animationOptions =
	time: fadeTime * 2
	
# Menu
menu.states.add
	hide: 
		opacity: 0
menu.states.animationOptions =
	time: fadeTime * 6
	

# Events
searchBar.states.switchInstant("hide")
messageCard.states.switchInstant("hide")
menu.states.switchInstant("hide")
frequentAddress1.states.switchInstant("hide")
frequentAddress2.states.switchInstant("hide")
frequentAddress3.states.switchInstant("hide")

splashScreen.onClick ->
	Utils.delay 0.3, =>
		splashScreen.states.switch("on")
		splashCircle.states.switch("on")
		splashLine.states.switch("on")
		splashSymbol.states.switch("on")
		mapClip.states.switch("on")
		Utils.delay fadeTime * 0.9, =>
			searchBar.states.switch("default")
		Utils.delay fadeTime * 1.5, =>
			slide1.start()
			slide2.start()
			slide3.start()
			slide1.on(Events.AnimationEnd, dotExpand1)
			slide2.on(Events.AnimationEnd, dotExpand2)
			slide3.on(Events.AnimationEnd, dotExpand3)
		Utils.delay fadeTime * 3.2, =>
			circleDrop1.start()
			circleDrop1.on(Events.AnimationEnd, circleDrop2.start)
			messageCard.states.switch("default")
			menu.states.switch("default")
		
		


