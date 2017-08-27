
# Setup
Framer.Defaults.Animation =
	curve: "spring(230,25,0)"

Framer.Device.background.backgroundColor = "#010109"

bg = new BackgroundLayer
	backgroundColor: "#040A15"

stockGraph = new Layer
	y: Align.center(-100)
	backgroundColor: ""
	html: """
<svg width="#{Screen.width}" height="302px" viewBox="0 0 746 302" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
    <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <polyline id="Path" stroke="#81D288" stroke-width="2" points="1 206.222656 12.625 216.164062 21.8828125 176.929687 27 193.359375 35.2265625 168.027344 42.0078125 201.339844 46.6289062 118.320312 54.484375 152.136719 63.0664062 122.617187 76.5585937 93.4921875 90.3164062 225.074219 103.097656 113.628906 110.722656 86.9257812 122.988281 145.851562 130.585937 202.847656 140.160156 184.847656 154.59375 172.265625 160.066406 236.453125 169.03125 193.085937 175.933594 189.980469 182.550781 211.078125 194.441406 101.066406 209.464844 117.828125 220.898437 111.535156 221.734375 145.511719 238.265625 92.53125 249.324219 86.7265625 253.09375 126.203125 258.054688 131.953125 272.957031 135.527344 285.898437 199.152344 292.902344 175.789062 300.984375 192.144531 308.554687 194.5 313.902344 216.816406 322.417969 207.714844 329.589844 210.230469 334.46875 239.347656 340.546875 244.335938 346.097656 252.097656 350.617187 241.996094 356.878906 248.28125 360.398437 290.316406 369.945312 299.34375 371.828125 278.539062 378.054688 281.355469 394.546875 233.007813 406.699219 287.964844 421.757812 248.429688 428.605469 240.238281 439 174.144531 449.050781 173.898437 453.765625 180.683594 463.171875 151.679687 471.285156 142.535156 474.546875 121.710938 483.828125 114.035156 487.511719 94.921875 498.464844 95.25 505.304687 131.292969 510.742188 114.253906 519.097656 101.667969 533.226562 39.546875 540.933594 52.0234375 553.148437 3 561.179687 15.4101562 570.09375 43.7148437 580.347656 54.9375 581.703125 90.3984375 589.496094 95.0078125 595.03125 91.9257812 611.179687 98.6992188 616.09375 116.058594 625.644531 103.914062 632.292969 110.585937 639.757812 105.277344 653.964844 107.578125 661.394531 119.464844 667.308594 111.449219 675.644531 113.207031 692.65625 160.660156 709.363281 152.335938 720.082031 147.605469 730.574219 138.132812 738.847656 136.757812 744.582031 148.863281"></polyline>
    </g>
</svg> """

currentPosition = new SliderComponent
	x: 0
	y: Align.center
	width:Screen.width
	backgroundColor: ""
currentPosition.knob.draggable.momentum = false

currentPosition.knob.props =
	height: Screen.height
	backgroundColor: ""
	x: Screen.width/2
	
knobLine = new Layer
	height: Screen.height
	parent: currentPosition.knob
	width: 2
	backgroundColor: "rgba(100,100,100,90)"
	x: Align.center

currentPosition.fill.opacity = 0
currentPosition.sliderOverlay.opacity = 0

footer = new Layer
	x: Align.center
	maxY: Screen.height
	width: Screen.width
	height: 304 * (Screen.width/495)
	image: "images/footer.png"

header.bringToFront()
showTotalArea.bringToFront()
dollarSign.bringToFront()

groupFirst.y = (-Utils.randomChoice([1,2,3,4,5,6,7,8,9]) * 60 + 18)
groupSecond.y = (-Utils.randomChoice([1,2,3,4,5,6,7,8,9]) * 60 + 18)
groupOnes.y = (-Utils.randomChoice([1,2,3,4,5,6,7,8,9]) * 60 + 18)
groupTens.y = (-Utils.randomChoice([1,2,3,4,5,6,7,8,9]) * 60 + 18)
groupHundreds.y = (-Utils.randomChoice([5,6]) * 60 + 18)

currentPosition.onValueChange ->
	groupFirst.animate
		y: (-Utils.randomChoice([1,2,3,4,5,6,7,8,9]) * 60 + 18)
	groupSecond.animate
		y: (-Utils.randomChoice([1,2,3,4,5,6,7,8,9]) * 60 + 18)
	groupOnes.animate
		y: (-Utils.randomChoice([1,2,3,4,5,6,7,8,9]) * 60 + 18)
	groupTens.animate
		y: (-Utils.randomChoice([1,2,3,4,5,6,7,8,9]) * 60 + 18)
	groupHundreds.animate
		y: (-Utils.randomChoice([6,7,8]) * 60 + 18)


