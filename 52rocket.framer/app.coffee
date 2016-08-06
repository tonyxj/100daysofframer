# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: "Rocket"
	author: "Tony"
	twitter: "TonyJing"
	description: "Rocket Launch Animation"


# Var
gray = "#ebebeb"
red = "ee5656"

launchTime = 2
flameYBase = 0.1
flameXBase = 1.7

launched = false
nearGround = true

# Elements 
sky = new BackgroundLayer 
	style:
		backgroundImage: """linear-gradient(to bottom, 
								#470DBA 1%,
								#5CAFF2 33%,
								#FFFFFF 52%)"""

horizon = new Layer
	width: 500, y: Align.center(95)
	x: Align.center, height: 200, clip: true
	borderRadius: "50%", backgroundColor: ""
	
land = new Layer
	x: Align.center, y: -100, width: 400, height: 200
	backgroundColor: "white", parent: horizon

rocket = new Layer
	width: 50, height: 155, x: Align.center, y: Align.center
	clip: true, backgroundColor: ""

finLeft = new Layer
	width: 15, height: 100, rotation: 45, parent: rocket
	x: -20, y: 40, backgroundColor: red

finRight = new Layer
	width: 15, height: 100, rotation: -45, parent: rocket
	x: 55, y: 40, backgroundColor: red

nosecone = new Layer
	size: 40, rotation: 45, parent: rocket, x: Align.center, 
	y: 10, borderRadius: "0 100%", backgroundColor: gray

airframe = new Layer
	width: 24, height: 50, parent: rocket
	x: Align.center, y: 30, backgroundColor: gray

finCenter = new Layer
	width: 2, height: 32, parent: rocket
	x: Align.center, y: 58, backgroundColor: red

viewWindow = new Layer
	size: 12, borderRadius: "50%", parent: rocket, y: 30
	x: Align.center, backgroundColor: "#3396ec"
	borderColor: "#fff", borderWidth: 2

# Animations
fireAnimation = new Animation
	layer: rocket
	properties: y: Align.center(-60)
	time: launchTime
	curve: "ease-in"
	
flyAnimation = new Animation
	layer: rocket, properties: y: -400 
	time: launchTime * 0.6
	curve: "ease-in"

rocketShakeA = new Animation
		layer: rocket
		properties: x: Align.center(-1)
		time: 0.05
		
rocketShakeB = new Animation
		layer: rocket
		properties: x: Align.center(1)
		time: 0.05

# Functions
launch = ->
	launched = true
	fireAnimation.start()
	fireAnimation.on(Events.AnimationEnd, flyAnimation.start)
	fireAnimation.onAnimationEnd ->
		nearGround = false
	flyAnimation.onAnimationEnd ->
		launched = false
		Utils.delay 0.5, ->
			restart()

shake = ->
	rocketShakeA.start()
	rocketShakeA.on(Events.AnimationEnd, rocketShakeB.start)
	rocketShakeB.on(Events.AnimationEnd, rocketShakeA.start)

Utils. interval 0.1, ->
	if launched
		flameYBase += 0.032
		flameXBase -= 0.01
		flame = new Layer
			width: 30, height: 80, borderRadius: "50%", parent: rocket
			backgroundColor: Utils.randomChoice(["#F18F0F",
				"#F1A20F","#F1B50F"]) 
			scale: 0, originY: 0
		flame.center()
		flame.y = 75
		flame.placeBehind airframe
		flame.animate
			properties: 
				scale: 1, scaleY: flameYBase, scaleX: flameXBase
			time: 0.3
		flame.animate
			delay: 0.2, time: 0.1, properties: opacity: 0
		flame.onAnimationEnd -> @destroy()
	else 
		flameYBase = 0.1
		flameXBase = 1.7

randomPos = -> Utils.randomNumber -125, 80

smoke = ->
	for i in [0..Utils.randomChoice([10,11,12])]
		cloud = new Layer
			size: Utils.randomNumber(50, 80)
			borderRadius: "50%", opacity: 0.8, scale: 0
			style: 
				background: """radial-gradient(ellipse at center, 
										rgba(255,255,255,0) 0%, 
										rgba(215,215,210,1) 100%)"""
		cloud.center()
		if i <= 9
			cloud.placeBehind(rocket)
		cloud.animate
			delay: launchTime / 5
			properties: 
				scale: 2
				x: rocket.midX + randomPos()
				y: rocket.midY + 15 + randomPos() / 3.2
			curve: "ease-out"
			time: launchTime * 1.8
		cloud.animate
			delay: launchTime / 1.5
			properties: opacity: 0
			time: launchTime * 1.8
		cloud.onAnimationEnd -> @destroy()

restart = ->
	rocket.y = Align.center
	rocket.props = 
		y: Align.center, scale: 0
	rocket.animate
		properties: 
			scale: 1, rotationX: 0
		time: 0.6
		curve: "ease-in-out"
	rocketShakeA.stop()
	rocketShakeB.stop()

# Events
rocket.onClick ->
	launch()
	shake()
	smoke()

restart()

Events.wrap(window).addEventListener "resize", ->
	rocket.center()
	horizon.centerX()
	horizon.centerY(95)