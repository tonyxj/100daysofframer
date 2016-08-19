# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


t0 = 0
t1 = 0
delta = 0
sliderTimeMax = 3.1
animateTime = 0.02
tick = animateTime

bg = new BackgroundLayer backgroundColor: "250319"

dummy = new Layer 
	size: 0 

timeText = new Layer
	html: "Animation Time: 0.00", x: Align.center(60), y: Align.center(-100)
	width: 500, height: 50, backgroundColor: null
	style: textAlign: "left", fontSize: "2.5rem"

slider = new SliderComponent
	x: Align.center, y: Align.center
	min: animateTime, max: sliderTimeMax

go = new Layer
	width: 120, height: 50, html: "GO", borderRadius: 5
	backgroundColor: "#27af90", x: Align.center
	y: Align.center(90)
	style: 
		textAlign: "center", fontSize: "1.2rem"
		lineHeight: "3rem"

slider.on "change:value", ->
	bg.backgroundColor = "#250319"
	animateTime = this.value
	

go.onClick ->
	t0 = performance.now()
	tick = 0
	dummy.animate 
		properties: x: 100
		time: animateTime
		curve: "lineal"
	
	bg.animate 
		properties: backgroundColor: "#5790cc"
		time: animateTime
		
	bg.onAnimationEnd ->
		t1 = performance.now()
		delta = t1 - t0
		dummy.x = 0
		
		
dummy.on "change:x", ->
	if Math.round(tick * 100) < 10
		timeText.html = "Animation Time: 0.0" +  Math.round(tick * 100)
	else if  Math.round(tick * 100) < 100
		timeText.html = "Animation Time: 0." +  Math.round(tick * 100)
	else if Math.round(tick * 100) < 200
		timeText.html = "Animation Time: 1." + Math.round(tick * 100 - 100)
	else if Math.round(tick * 100) < 300
		timeText.html = "Animation Time: 2." + Math.round(tick * 100 - 200)
	else 
		timeText.html = "Animation Time: 3." + Math.round(tick * 100 - 300)
	
Utils.interval 0.01, ->
	tick += 0.01
	