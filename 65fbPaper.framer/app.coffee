# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


module = require "OrientationEvents"

img = new Layer
	width: 1280 * (Screen.height/852)
	height: Screen.height 
	image: "images/lone-bison-1259728_1280.jpg"

imgHalf = (img.width - Screen.width)/2
img.x = -imgHalf

text = new Layer
	width: Screen.width, height: 319 * (Screen.width/750)
	maxY: Screen.height
	image: "images/shadow.png"

# Setup OrientationEvents
module.OrientationEvents()
# Sets smoothing for all smooth[Variable]
module.smoothOrientation = .02

Utils.interval .03, ->
	if module.orientation? # To make sure we're actually receiving orientation-values
		gamma = module.orientation.gamma
		delta = Utils.modulate(gamma, [-10, 10], [-(img.width - Screen.width), 0], true)
		img.x = delta