
dragOnCircle = require "dragOnCircle"

bg = new BackgroundLayer
	backgroundColor: "#052232"
	
seconds = new Layer
	x: 363 + 43
	y: 350
	width: 200
	height: 200
	backgroundColor: null
	html: "00"
	style:
		fontWeight: 300
		fontSize: "10rem"

minutes = new Layer
	x:125 + 43
	y: 350
	width: 200
	height: 200
	backgroundColor: null
	html: "00"
	style:
		fontWeight: 300
		fontSize: "10rem"
	
colon = new Layer
	x: 310 + 43
	y: 350
	width: 200
	height: 200
	backgroundColor: null
	html: ":"
	style:
		fontWeight: 300
		fontSize: "10rem"	

dial1bg = new Layer
	width: 500	
	height: 500
	borderRadius: "50%"
	x: Screen.width - 330
	y: 680
	backgroundColor: "rgba(255,255,255, 0.05)"
	borderWidth: 5
	borderColor: "rgba(255,255,255, 0.3)"

dial2bg = new Layer
	width: 500	
	height: 500
	borderRadius: "50%"
	x: -200
	y: 680
	backgroundColor: "rgba(255,255,255, 0.05)"
	borderWidth: 5
	borderColor: "rgba(255,255,255, 0.3)"
		
dialKnob1 = new Layer
	x: Screen.width - 170
	y: 580
	width: 180
	height: 180
	borderRadius: 100
	backgroundColor: "white"
	shadowBlur: 30
	shadowSpread: 10
	shadowY: 10
	shadowColor: "rgba(0,0,0,9.8)"
	html: "Seconds"
	style:
		color: "#cd7878"
		fontWeight: 700
		fontSize: "2rem"
		padding: "4.5rem 1.6rem"

dialKnob2 = new Layer
	x: -15
	y: 580
	width: 180
	height: 180
	borderRadius: 100
	backgroundColor: "white"
	shadowBlur: 30
	shadowSpread: 10
	shadowY: 10
	shadowColor: "rgba(0,0,0,0.8)"
	html: "Minutes"
	style:
		color: "#cd7878"
		fontWeight: 700
		fontSize: "2rem"
		padding: "4.5rem 2rem"

dial1 = dragOnCircle.circleDrag dialKnob1, 250
dial2 = dragOnCircle.circleDrag dialKnob2, 250

dialKnob1.on "change:x", ->
# 	print "X is: [" + dialKnob1.x + "], y is [" +dialKnob1.y+ "] and the angle is " +  dragOnCircle.dragAngle
# 	
	secondsCount = Math.floor(Utils.modulate(dragOnCircle.dragAngle, [360, 180], [0, 59],true))
	if secondsCount < 10
		secondsCount = "0" + secondsCount
	seconds.html = secondsCount
	
	if dragOnCircle.dragAngle < 30 && dragOnCircle.dragAngle  > 0
		seconds.html = "00"

dialKnob2.on "change:x", ->
# 	print "X is: [" + dialKnob2.x + "], y is [" +dialKnob2.y+ "] and the angle is " +  dragOnCircle.dragAngle

	minutesCount = Math.floor(Utils.modulate(dragOnCircle.dragAngle, [0, 180], [0, 59],true))
	if  minutesCount < 10
		minutesCount = "0" + minutesCount
	minutes.html = minutesCount
	
	if dragOnCircle.dragAngle <= 360 && dragOnCircle.dragAngle  > 280
		minutes.html = "00"
	