# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


new BackgroundLayer backgroundColor: "#211"

vidPlayer = new Layer
	width: 300
	height: 200
	x: Align.center
	y: Align.center(-100)
	backgroundColor: "#efefef"
	clip: true
	
horse = new Layer
	width: 2180 * 2.3
	height: 89 * 2.3
	parent: vidPlayer
	image: "images/horse.png"
	
slider = new SliderComponent
	x: Align.center
	y: Align.center(70)
	min: 1
	max: 16

slider.onValueChange ->
	value = Math.floor(slider.value)
	horse.x = 0 - horse.width / 16 * value
