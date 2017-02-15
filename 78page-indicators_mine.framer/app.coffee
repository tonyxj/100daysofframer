

sketch = Framer.Importer.load "imported/page-indicators"

page = new PageComponent
	width: Screen.width, height: Screen.height
	y: 128, scrollVertical: false
	contentInset: {top: 32, right: 32}
	
allIndicators = []
allCards = []
amount = 4
margin = 32

for i in [0...amount]
	card = new Layer
		backgroundColor: "#fff", borderRadius: 6
		width: page.width - (margin * 2), height: 960
		x: (page.width + margin)*(i+1), superLayer: page.content
		scale: 0.8
	
	card.style.boxShadow="0 3px 12px rgba(0,0,0,0.2)"
	
	card.states.add(active: {opacity: 1, scale: 1})
	card.states.animationOptions = curve: "spring(220, 20, 0)"
	
	indicator = new Layer
		backgroundColor: "#222", width: 12, height: 12
		x: 28 * i, y: 1167
		# Setting border radius to 50% on a square creates a circle
		borderRadius: "50%", opacity: 0.2
		
	# A good way to horizontally align center indicator layers.
	# For each indicator, the new X value is the result of its old X value, plus half of the screen width, minus the entire width of all the layers, as each layer's width is 12 and amount is the number of layers
	indicator.x += (Screen.width) / 2 - (12 * amount)
	
	indicator.states.add(active: {opacity: 1, scale: 1.2})
	indicator.states.animationOptions = time: 0.2
	
	# Store them in an array
	allIndicators.push(indicator)
	allCards.push(card)

# Use page.content.subLayer[#] to keep the page on this # as the default on start
page.snapToPage(page.content.subLayers[0])
# Setting the current indicator dot to be the same as the snapped page on load, using the horizontalPageIndex value
current = page.horizontalPageIndex(page.currentPage)
allIndicators[current].states.switch("active")
allCards[current].states.switch("active")

# Adding this animation gives the page transition a bounce
page.animationOptions = curve: "spring(220, 20, 0)"

# .on "change:currentPage" is an event listenter for new currentPage layer
page.on "change:currentPage", ->
	# Hides the indicators as the page is switched
	indicator.states.switch("default") for indicator in allIndicators
	card.states.switch("default") for card in allCards
	
	# Whenever the current page changes, the current variable is updated to the  horizontal index of the page that is current 
	current = page.horizontalPageIndex(page.currentPage)
	# use the current variable, which shows the index number of the page on screen to animate the right page in the allIndicators array
	allIndicators[current].states.switch("active")
	allCards[current].states.switch("active")
	
# 	Giving the pages more of an animated feel when transitioning

# 	page.previousPage.animate
# 		properties: {scale: 0.5} 

# 		One thing to note here is that page.previousPage.animationOptions = curve: "spring(100, 50, 0, 1)" creates a weird bounce when the page is dragged back, while adding the curve and curve options below avoids that problem. Not sure why this is the case

# 		curve: "spring"
# 		curveOptions: {tension: 100, friction: 50, velocity: 0, tolerance: 1}

# 	Returning page that moved away to its original scale
# 	page.previousPage.once Events.AnimationEnd, -> this.scale = 1




