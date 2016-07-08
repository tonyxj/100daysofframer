# Import file "sprig"
sketch = Framer.Importer.load("imported/sprig@1x")
page = new PageComponent width: Screen.width, height: Screen.height, scrollVertical: false

for i in [1..6]
	Framer["scrollday#{i}"] = new ScrollComponent name: "scrollday#{i}", y: 1400, width: Screen.width, height: Screen.height + 200, scrollHorizontal: false
	sketch["day#{i}"].superLayer = page.content
	sketch["day#{i}Details"].superLayer = Framer["scrollday#{i}"].content
	sketch["day#{i}"].onClick ->
		clickedLayer = @.name
		Framer["scroll#{clickedLayer}"].bringToFront()
		Framer["scroll#{clickedLayer}"].animate
			properties:
				y: 0
			curve: "spring(150, 18, 0)"
		sketch.addToOrder.bringToFront()
		Utils.delay 0.2, ->
			sketch.addToOrder.animate
				properties: 
					y: Screen.height - sketch.addToOrder.height
			Framer["scroll#{clickedLayer}"].height = Screen.height
		Framer["scroll#{clickedLayer}"].subLayers[0].subLayers[0].subLayers[0].onClick ->
			Framer["scroll#{clickedLayer}"].animate
				properties:
					y: 1400
				curve: "spring(150, 18, 0)"
		Framer["scroll#{clickedLayer}"].onScroll ->
			scrollAmt = Framer["scroll#{clickedLayer}"].scrollY
			if scrollAmt <= -185
				Framer["scroll#{clickedLayer}"].animate
					properties:
						y: 1400
					curve: "spring(150, 18, 0)"
				sketch.addToOrder.animate
					properties: 
						y: 1400
	
page.on "change:currentPage", ->
	current = page.horizontalPageIndex(page.currentPage)
	if current is 0
		sketch.selector.animate {properties: (x: 328), time: 0.2}
	if current is 1
		sketch.selector.animate {properties: (x: 358), time: 0.2}
	if current is 2
		sketch.selector.animate {properties: (x: 386), time: 0.2}
	if current is 3
		sketch.selector.animate {properties: (x: 414), time: 0.2}
	if current is 4
		sketch.selector.animate {properties: (x: 443), time: 0.2}
	if current is 5
		sketch.selector.animate {properties: (x: 471), time: 0.2}