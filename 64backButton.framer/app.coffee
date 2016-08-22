# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


# Kevyn Arnott: "You can use window.location.hash to do your state management. Then you move through the prototype manipulating the URL and relying on a state management function. Then just listen to the back button to call the state manager. Here's a quick example -> http://share.framerjs.com/7o9i6rthv7aa/"

msg1 = "First Page<br>Click anywhere to view the next page."
msg2 = "Second Page<br>Click to view the last page."
msg3 = "Third Page<br>Click the browser back button go back."

layerStyle = 
	fontFamily: "monospace", textAlign: "center"
	fontSize: "1.2rem", lineHeight: "10rem"

fadeIn = time: 0.3

first = new Layer
	html: msg1, opacity: 0
	backgroundColor: "black"
	size: Screen, style: layerStyle
first.states.add on: opacity: 1
first.states.animationOptions = fadeIn
	
second = new Layer
	html: msg2, opacity: 0
	backgroundColor: "maroon"
	size: Screen, style: layerStyle
second.states.add on: opacity: 1
second.states.animationOptions = fadeIn

third = new Layer
	html: msg3, opacity: 0
	backgroundColor: "indigo"
	size: Screen, style: layerStyle
third.states.add on: opacity: 1
third.states.animationOptions = fadeIn

first.bringToFront()

state = (hash) ->
	window.location.hash = hash
		
	#These are the different states you'd switch between
	switch hash
		when "#third"
			third.states.switch("on")
			second.states.switch("default")
		when "#second" 
			second.bringToFront()
			third.states.switch("default")
			first.states.switch("default")
			second.states.switch("on")
		else  
			first.bringToFront()
			second.states.switch("default")
			first.states.switch("on")

#Start with your initial state
state("")

# You can move through the states using the state function
first.on Events.TouchEnd, ->
	state("#second")
	
	
second.on Events.TouchEnd, ->
	state("#third")

#You won't need to change these. They listen to the back button & go to the previous state.
goBack = () ->
	state(window.location.hash)
	
window.onpopstate = goBack