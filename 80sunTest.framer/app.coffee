for i in [0 ... 80]
	star = new Layer
		size: 2
		backgroundColor: "fff"
		opacity: Utils.randomNumber(0.1, 0.5)
		x: Utils.randomNumber(2, 798)
		y: Utils.randomNumber(2, 220)
		parent: container
	star.placeBehind(bridge)

for layer in [farFog0, farFog1, farFog2, farFog3, nearFog0, nearFog2, nearFog3, nearFog4]
	layer.states.fogging =
		maxX: 860
		scale: Utils.randomNumber(0.75, 1.2)
		opacity: Utils.randomNumber(0.75, 1)
		options:
			time: 7.5
			curve: "ease-in-out"
	layer.animate "fogging"
	layer.onAnimationEnd ->
		@.stateSwitch("default")
		@.animate "fogging"

blinkOn = new Animation light,
	opacity: 1
	options: 
		time: 0.35
		delay: 1
blinkOff = new Animation light,
	opacity: 0
	options: 
		time: 0.35
		delay: 1

blinkOn.on Events.AnimationEnd, blinkOff.start
blinkOff.on Events.AnimationEnd, blinkOn.start
 
blinkOn.start()

# shootingStar.rotation = -25
shootingStar.states.shoot =
	x: -100
	opacity: 0.2
	width: 55
	y: 237
	options:
		time: 6
		curve: "linear"
shootingStar.animate("shoot")

shootingStar.onAnimationEnd ->
	@.x = 408
	@.y = 0
	@.opacity = 1
	@.animate("shoot")



