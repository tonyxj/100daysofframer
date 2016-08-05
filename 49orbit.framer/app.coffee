# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


baseSize = 200
num = 17

shapes = []
shapes2 = []

for i in [0...num]
	bgColor = Utils.randomColor()
	petal = new Layer
		size: baseSize - i * baseSize / (num + 1)
		borderRadius: "20% 100%"
		x: 80 - 2 * i
		style: 
			backgroundColor: bgColor
			mixBlendMode: "screen"
	
	shapes.push(petal)
	petal.parent = shapes[i-1]
	shapes[0].center()
	
	petal.animate 
		properties: 
			rotation: 360
		time: 5
		curve: "linear"
		repeat: Infinity
	
