# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


Framer.Defaults.Animation = curve: "spring(300,25,0)"

bg = new Layer
	size: Screen, borderRadius: 20, html: "Song Playing Demo"
	backgroundColor: Color.random().darken(10), scale: 0.99
	style: 
		fontSize: "4rem", textAlign: "center"
		fontWeight: 300, lineHeight: "20rem"
bg.states.add song: scale: 0.95, opacity: 0.8


playingBg = new Layer
	width: Screen.width, height: 300, backgroundColor: "#eee"
	maxY: Screen.height
playingBg.states.add 
	song: 
		height: Screen.height, y: 70, borderRadius: 20
		backgroundColor: "#fff"

navBar = new Layer
	width: Screen.width, height: 130, html: "Bottom Navbar"
	backgroundColor: "#fff", maxY: Screen.height
	style: 
		fontSize: "3rem", textAlign: "center", color: "#000"
		fontWeight: 300, lineHeight: "8rem"
navBar.states.add song: y: Screen.height + navBar.height
navBar.states.animationOptions = curve: "ease", time: 0.2

coverImg = new Layer
	size: 130, parent: playingBg, x: 10, y: 15
	image: "images/album-covers-01.jpg"
coverImg.states.add song: 
	scale: 5, x: Align.center, y: 315

controls = new Layer 
	width: Screen.width, height: 400, backgroundColor: "#fff"
	maxY: Screen.height - 100, scale: 0, originY: 1, parent: playingBg
controls.states.add song: scale: 1
controls.states.animationOptions = curve: "ease", time: 0.25

controlsImg = new Layer
	width: 750, height: 386, parent: controls, 
	maxY: controls.height, scale: 0.88
	image: "images/controls.jpg"

currentlyPlayingText = new Layer
	html: "Currently Playing Song Name"
	backgroundColor: "", width: Screen.width
	x: 60, parent: playingBg, color: "#333"
	style: 
		fontSize: "2.3rem", lineHeight: "10rem"
		textAlign: "center", fontWeight: "600"
currentlyPlayingText.states.add 
	song: 
		scale: 1.22, x: 0, y: 742
currentlyPlayingText.states.animationOptions = curve: "ease", time: 0.25
	

play = new Layer
	size: Screen, backgroundColor: ""


play.onClick ->
	for layer in [bg, navBar, playingBg, coverImg, controls, currentlyPlayingText]
		layer.states.next()