# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


# Setup
{SVGLayer} = require "SVGLayer"

bg = new Layer
	size: Screen
	image: "images/IMG_4190.PNG"
	
iconCover = new Layer
	size: 110, backgroundColor: "#fff", x: 12, y: 226

cover = new Layer
	size: Screen, backgroundColor: "#000", opacity: 0
	
photo_clip = new Layer
	size: Screen.width * 2.2 
	x: -Screen.width - 4, y: -230
	borderRadius: "50%", backgroundColor: ""
	clip: true, originX: 0.5, originY: 0.3
	scale: 0.06
	
photo = new Layer
	size: Screen, x: Align.center, y: Align.center
	image: "images/IMG_4189.jpg"
	parent: photo_clip, originX: 0.5, originY: 0.5
	scale: 2.3

timer = new Layer
	size: 150, maxX: Screen.width, backgroundColor: ""
	parent: photo

clickStateCover = new Layer
	width: Screen.width, height: 130, y: 218
	backgroundColor: "#999", opacity: 0
	
# SVG
ring_bg = new SVGLayer
	strokeWidth: 2, parent: timer
	x: Align.center, y: Align.center
	width: 436, height: 430
	scale: 0.15, opacity:.95
	path: '<path fill="none" stroke="#222" stroke-width="85" stroke-linecap="round" stroke-miterlimit="10" d="M217.473,68.503c78.883,1.187,142.461,65.5,142.461,144.665c0,79.904-64.774,144.68-144.68,144.68c-79.905,0-144.68-64.775-144.68-144.68c0-79.229,63.681-143.582,142.652-144.667"/></path>'
	
ring_spinner = new SVGLayer
	strokeWidth: 2, parent: timer
	x: Align.center, y: Align.center
	width: 436, height: 430
	scale: 0.15, dashOffset: -1
	path: '<path fill="none" stroke="#fff" stroke-width="45" stroke-linecap="square" stroke-miterlimit="10" d="M217.473,68.503c78.883,1.187,142.461,65.5,142.461,144.665c0,79.904-64.774,144.68-144.68,144.68c-79.905,0-144.68-64.775-144.68-144.68c0-79.229,63.681-143.582,142.652-144.667"/></path>'

# States
ring_spinner.states.add
	spin: dashOffset: 0
ring_spinner.states.animationOptions =
	curve: "linear", time: 5

clickStateCover.states.add on: opacity: 0.15
clickStateCover.states.animationOptions =
	curve: "ease", time: 0.1

photo_clip.states.add on: 
	scale: 1, x: Align.center, y: Align.center
photo_clip.states.animationOptions = curve: "ease", time: 0.3

photo.states.add on:
	scale: 1, x: Align.center, y: Align.center
photo.states.animationOptions = curve: "ease", time: 0.3

cover.states.add on: opacity: 0.8
cover.states.animationOptions = curve: "ease", time: 0.3

# Events
clickStateCover.onTouchStart ->
	@states.switch("on")

clickStateCover.onClick ->
	photo_clip.states.switch("on")
	photo.states.switchInstant("on")
	ring_spinner.states.switch("spin")
	cover.states.switch("on")
	
	photo.onClick ->
		endSnap()
	
	photo_clip.draggable.enabled = true
	photo_clip.draggable.overdrag = false
	photo_clip.draggable.constraints = 
		x: -1450, y: -158, width: 3650, height: 5000
	
	photo_clip.onDrag ->
		op = Utils.modulate(@y, [-155, 200], [0.8, 0], true)
		clipScaleAmt = Utils.modulate(@y, [-155, 200], [1, 0.35], true)
		@scale = clipScaleAmt
		
		photo.scale = 1/clipScaleAmt
		photo.y = Align.center
		cover.opacity = op

		if @y >= 300
			photo_clip.draggable.horizontal = true
		else
			photo_clip.draggable.horizontal = false
			photo_clip.x = Align.center
		
	photo_clip.onDragEnd ->
		if @draggable.direction is "down"
			endSnap()
		else
			photo_clip.states.switch("on")
			photo.states.switch("on")

clickStateCover.onTapEnd ->
	@sendToBack()
	@states.switch("default")
	
ring_spinner.onAnimationEnd ->
	endSnap()
	
endSnap = ->
	clickStateCover.bringToFront()
	ring_spinner.dashOffset = -1
	ring_spinner.states.switch("default")
	photo_clip.states.switch("default")
	photo.states.switch("default")
	cover.states.switch("default")



	