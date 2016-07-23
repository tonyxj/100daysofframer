Screen.backgroundColor = "#5689cd"

dots = []
diameter = 15
numDots = diameter * 1.5

for row in [0...numDots]
	for column in [0...numDots]
		dot = new Layer
			width: diameter
			height: diameter
			x: 20 * row + 70
			y: 20 * column + 150
			backgroundColor: "#fff"
			borderRadius: diameter/2
		dot.states.add on: 
			y:  20 * column + 50
			scale: 1.5
			backgroundColor: Utils.randomColor().lighten(10)
		dot.states.animationOptions = 
			curve: "ease-in-out", time: 0.25
	
		dot.onMouseOver ->
			this.states.switch("on")
			this.onAnimationEnd ->
				this.states.switch("default")