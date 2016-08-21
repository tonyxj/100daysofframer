# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


bg = new Layer
	width: 750
	height: 1334
	image: "images/Screenshot_IGvsSC_03.jpg"
bgCover = new Layer
	size: Screen, backgroundColor: "#fff", opacity: 0
bgCover.states.add on: opacity: 0.6
bgCover.states.animationOptions = time: 0.3

profileBlock = new Layer
	size: 113, borderRadius: "50%", backgroundColor: "#fff"
	x: 26, y: 160
profileBlock.states.add on: opacity: 0
profileBlock.states.animationOptions = time: 0.1


vidWrap = new Layer 
	size: Screen, x: 0, y: 0, opacity: 0
	backgroundColor: "", shadowY: 10, shadowBlur: 100, clip: true
vidWrap.states.add on: opacity: 1
vidWrap.states.animationOptions = time: 0.2

vidPaused = true

vid = new VideoLayer
	width: 750, height: 1920/(1080/750)
	scale: 0, originX: 0.05, originY: 0.15, parent: vidWrap
	video: "images/IMG_4089.MOV"
vid.states.add on: scale: 1
vid.states.animationOptions = time: 0.35

	
profile = new Layer
	width: 112, height: 112, x: 26, y: 160
	image: "images/profile.png"
profile.states.add on: scale: 0.7, x: 5, y: 40
profile.states.animationOptions = time: 0.1

shadowDown = new Layer
	width: Screen.width, height: 70, backgroundColor: "", parent: vid
	style: backgroundImage: "linear-gradient(to bottom, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0) 100%)"

for bar in [0..7]
	if bar < 4
		op = 0.95
	else 
		op = 0.5
	bar = new Layer 
		width: Screen.width / 8.8, height: 5, parent: shadowDown
		backgroundColor: "#fff", opacity: op
		x: 12 + bar * Screen.width / 8.2, y: 22
	
current = new Layer
	width: 0, backgroundColor: "#fff", parent: shadowDown
	x: 378, height: 5, y: 22
current.states.add on: width: Screen.width/9
current.states.animationOptions = curve: "linear", time: 4.2


profile.onClick ->
	run()
vid.onClick ->
	run()

run = ->
	profileBlock.states.next()
	vidWrap.states.next()
	vid.states.next()
	profile.states.next()
	current.states.next()
	bgCover.states.next()
	
	vid.player.play()
	
	if vidPaused is true
		profile.onAnimationEnd -> 
			@parent = vidWrap
			vidPaused = false
	else 
		profile.parent = null
		profile.onAnimationEnd ->
			profile.parent = null
			vidPaused = true
	
vidWrap.draggable.enabled = true
vidWrap.draggable.horizontal = false
vidWrap.draggable.constraints = 
	x: 0, y: 0, width: Screen.width, height: Screen.height + 350

vidWrap.onDrag ->
	vid.player.pause()
	vidWrap.borderRadius = 9
	vidWrap.scale = Utils.modulate(vidWrap.y, [0, 300], [1, 0.96], true)

vidWrap.onDragEnd ->
	profile.x = 26
	profile.y = 120
	run()
	vid.player.pause()
	
	
	