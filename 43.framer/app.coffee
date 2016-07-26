

ball = new Layer
	size: 80
	backgroundColor: "yellow"
	borderRadius: "50%"
	x: Align.center
	y: Align.center()

ball.draggable.enabled = true
trailSwitch = false

ball.onDragEnd ->
	trailSwitch = true
	ball.animate
		properties: 
			x: Align.center
			y: Align.center()
			backgroundColor: "blue"
		curve: "spring(200, 10, 0)"

	ball.on "change:y", ->
		if trailSwitch
			trail = this.copy() 
			trail.animate
				properties: scale: 0.1, opacity: 0
				delay: 0.05
				time: 0.5
			trail.onAnimationEnd ->
					trail.destroy()
			ball.onAnimationEnd ->
				this.bringToFront()

ball.onDragStart ->
	trailSwitch = false
	this.animate
		properties:
			backgroundColor: "yellow"