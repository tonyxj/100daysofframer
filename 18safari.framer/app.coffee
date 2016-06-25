

group = []
groupLength = 10
threeDflag = false

# Create ScrollComponent
# 	scale: 1.43
layers = new Layer
	width: Screen.width
	height: 2000
	y: 0
	backgroundColor: "null"

layers.draggable.constraints =
		x: 0
		y: -200
		width: Screen.width
		height: 3900
layers.draggable.enabled = false

for i in [0...groupLength]
	Framer["card#{i+1}"] = new Layer
		name: "card#{i+1}" # display names in layer list
		width: Screen.width
		height: Screen.height
		x: 0
		y: 0
		backgroundColor: "white"
		shadowY: -50
		shadowBlur: 110
		shadowColor: "rgba(0,0,0,0.2)"
		superLayer: layers
		html: "Tap Here"
		style: 
			color: "black"
			fontSize: "5rem"	
			textAlign: "center"
			display: "block"
			lineHeight: "500px"
			verticalAlign: "middle"
	group.push(Framer["card#{i+1}"])
	
	Framer["card#{i+1}"].states.add
		yo:
			y:  -(groupLength * 150) + i * 230
			rotationX: -30
			scale: 0.7
	Framer["card#{i+1}"].states.animationOptions = curve: "spring(220, 20, 0)"

for i in [0...group.length] 
	group[i].onClick ->
		if threeDflag == false
			layers.draggable.enabled = true
			layers.draggable.horizontal = false
			threeDflag = true
			for i in [0...group.length]
					Framer["card#{i+1}"].states.switch("yo")
		else 
			layers.draggable.enabled = false
			for i in [0...group.length]
					Framer["card#{i+1}"].states.switch("default")
			layers.props = 
				width: Screen.width
				height: 2000
				y: 0
			threeDflag = false



