# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: "Dots Rebound"
	author: "Tony"
	twitter: "TonyJing"
	description: "A rebound of Jonas Treub's original prototype: http://share.framerjs.com/5kgx0udrhill/"


# Device Shake Module made by RayPS
# https://github.com/RayPS/Framer-Module-ShakeEvent
ShakeEvent = require "shake"

ShakeEvent.throttleInterval = 1
ShakeEvent.sensitivity = 30

ShakeEvent.onShake = () ->
	createDots()

dotsCount = 1500
threshold = 80
pushFactor = 1.2
dots = []
document.body.style.cursor = "auto"

createDots = () ->
	for dot in dots
		dot.destroy
	dots = []
	dots = [0...dotsCount].map ->
		d = new Layer
			size: 8
			borderRadius: 4
			backgroundColor: "rgba(0,0,0,0.6)"
			x: Math.random() * Screen.width
			y: Math.random() * Screen.height
	
	for i in [0...dots.length]
		dots[i].oX = dots[i].x
		dots[i].oY = dots[i].x

createDots()

drop = (dot, duration) ->
	falling = new Animation
		layer: dot
		properties: 
			maxY: Screen.height
		curve: "ease-in"
		time: duration
	falling.start()

pushDots = (event) ->
	event = event.touches[0] if event.touches?
	mouseX = event.clientX
	mouseY = event.clientY
	dots.forEach (dot) ->
		dx = dot.midX - mouseX
		dy = dot.midY - mouseY
		return if Math.abs(dx) > threshold
		return if Math.abs(dy) > threshold
		distance = Math.sqrt(dx * dx + dy * dy)
		if distance < threshold
			
			dot.midX = mouseX + (dx / distance) * threshold
			dot.midY = mouseY + (dy / distance) * threshold
			if (dot.midX > dot.oX + threshold * pushFactor) or (dot.midX < dot.oX - threshold * pushFactor) or (dot.midY > dot.oY + threshold * pushFactor) or (dot.midY < dot.oY - threshold * pushFactor)	
				yDamp = 0.06/(dot.midY / Screen.height)
				drop(dot, 0.25+yDamp )

bg = new BackgroundLayer
bg.onPan(pushDots)
bg.onMouseMove(pushDots)