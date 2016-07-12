# Setup
# Import file "dateScroll"
sketch = Framer.Importer.load("imported/dateScroll@1x")

bg = new BackgroundLayer
	backgroundColor: "white"
	
# Variables for detecting if the blocks are animated into place
detect1 = true
detect2 = true
detect3 = true

rect1 = new ScrollComponent
	backgroundColor: "rgba(250,250,250,0.5)"
	scrollHorizontal: false
	contentInset: top: 200, bottom: 400
# 	borderColor: "lightgray"
# 	borderWidth: 2
# 	borderRadius: 5
rect2 = new ScrollComponent
	backgroundColor: "rgba(250,250,250,0.5)"
	scrollHorizontal: false
# 	borderColor: "lightgray"
# 	borderWidth: 2
# 	borderRadius: 5
	contentInset: top: 200, bottom: 400
rect3 = new ScrollComponent
	backgroundColor: "rgba(250,250,250,0.5)"
	scrollHorizontal: false
# 	borderColor: "lightgray"
# 	borderWidth: 2
# 	borderRadius: 5
	contentInset: top: 200, bottom: 400

rect1.screenFrame = sketch.Group.frame
rect2.screenFrame = sketch.Group_2.frame
rect3.screenFrame = sketch.Group_3.frame
# rect1.content.draggable.momentum = false
# rect3.content.draggable.momentum = false
# rect3.content.draggable.momentum = false

# Layers
for i in [0 .. 11]
	Framer["year#{i+1}"] = new Layer
		name: "year#{i+1}" 
		width: rect1.width
		height: 90
		y: i * 90
		html: 2016 - i
		parent: rect1.content
		backgroundColor: "white"
		style: 
			textAlign: "center"
			paddingTop: "31px"
			fontSize: "2.1rem"
			color: "black"
	Framer["month#{i+1}"] = new Layer
		name: "month#{i+1}" 
		width: rect1.width
		backgroundColor: "white"
		height: 90
		y: i * 90
		html: 2016 - i
		parent: rect2.content
		style: 
			textAlign: "center"
			paddingTop: "31px"
			fontSize: "2.1rem"
			color: "black"
			
	rect1.onMove ->
		rect1.scrollY
			
	
Framer.month1.html = "Jan"
Framer.month2.html = "Feb"
Framer.month3.html = "Mar"
Framer.month4.html = "Apr"
Framer.month5.html = "May"
Framer.month6.html = "Jun"
Framer.month7.html = "Jul"
Framer.month8.html = "Aug"
Framer.month9.html = "Sep"
Framer.month10.html = "Oct"
Framer.month11.html = "Nov"
Framer.month12.html = "Dec"

for i in [0 .. 29]
	Framer["day#{i+1}"] = new Layer
		name: "day#{i+1}" 
		width: rect1.width
		backgroundColor: "white"
		height: 90
		y: i * 90
		parent: rect3.content
		html: 1 + i
		style: 
			textAlign: "center"
			paddingTop: "31px"
			fontSize: "2.1rem"
			color: "black"

sketch.select.bringToFront()
sketch.Group_5.bringToFront()
sketch.Group_6.bringToFront()

# Events
# sketch.select.opacity = 0

# rect1.onMove ->
# 	for i in [1 .. 12]
# 		if Framer["year#{i}"].screenFrame.y > 610 && Framer["year#{i}"].screenFrame.y < 700
# 			Framer["year#{i}"].animate
# 				properties:
# 					backgroundColor: "rgba(230,235,251,0.5)"
# 				time: 0.05
# 		else
# 			Framer["year#{i}"].animate
# 				properties:
# 					backgroundColor: "white"
# 				time: 0.05


rect1.onScrollEnd ->
	detect1 = false
	rect1.onMove ->
		if Math.abs(rect1.velocity.y) <= 0.11 && detect1 == false
			for i in [1 .. 12]
				if Framer["year#{i}"].screenFrame.y > 610 && Framer["year#{i}"].screenFrame.y < 700
					rect1.scrollToLayer(Framer["year#{i}"])
			detect1 = true
						
rect1.onScrollStart ->
	detect1 = true

# rect2.onMove ->
# 	for i in [1 .. 12]
# 		if Framer["month#{i}"].screenFrame.y > 610 && Framer["month#{i}"].screenFrame.y < 700
# 			Framer["month#{i}"].animate
# 				properties:
# 					backgroundColor: "rgba(230,235,251,0.5)"
# 				time: 0.05
# 		else
# 			Framer["month#{i}"].animate
# 				properties:
# 					backgroundColor: "white"
# 				time: 0.05

rect2.onScrollEnd ->
	detect2 = false
	rect2.onMove ->
		if Math.abs(rect2.velocity.y) <= 0.11 && detect2 == false
			for i in [1 .. 12]
				if Framer["month#{i}"].screenFrame.y > 610 && Framer["month#{i}"].screenFrame.y < 700
					rect2.scrollToLayer(Framer["month#{i}"])
			detect2 = true
						
rect2.onScrollStart ->
	detect2 = true
	


# rect3.onMove ->
# 	for i in [1 .. 30]
# 		if Framer["day#{i}"].screenFrame.y > 610 && Framer["day#{i}"].screenFrame.y < 700
# 			Framer["day#{i}"].animate
# 				properties:
# 					backgroundColor: "rgba(230,235,251,0.5)"
# 				time: 0.05
# 		else
# 			Framer["day#{i}"].animate
# 				properties:
# 					backgroundColor: "white"
# 				time: 0.05

rect3.onScrollEnd ->
	detect3 = false
	rect3.onMove ->
		if Math.abs(rect3.velocity.y) <= 0.11 && detect3 == false
			for i in [1 .. 30]
				if Framer["day#{i}"].screenFrame.y > 610 && Framer["day#{i}"].screenFrame.y < 700
					rect3.scrollToLayer(Framer["day#{i}"])
			detect3 = true
						
rect3.onScrollStart ->
	detect3 = true
