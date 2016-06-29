#author Sergiy Voronov twitter.com/mamezito dribbble.com/mamezito
#done for Framer London framerlondon.com


exports.circleDrag=(objectLayer, radius)->
	angle=0
	centerX=objectLayer.midX
	centerY=objectLayer.midY+radius
	proxy=objectLayer.copy()
	proxy.name="proxy"
	proxy.opacity=0
	proxy.draggable=true
	proxy.draggable.overdrag=false
	proxy.draggable.momentum=false

	proxy.draggable.constraints=
		x:proxy.midX-radius-proxy.width/2
		y:proxy.y
		width:radius*2+proxy.width
		height:radius*2+proxy.width
	proxy.onDrag (event, layer) ->
		radX=this.x-centerX
		radY=this.y-centerY
		angle=Math.atan2(radX,radY)*(180/Math.PI)
		exports.dragAngle=180-angle
		placeOnElipse objectLayer, centerX, centerY, angle, radius, radius
	proxy.onDragEnd ->
		proxy.x=objectLayer.x
		proxy.y=objectLayer.y





placeOnElipse=(newLayer, centerX, centerY, angle, radiusX, radiusY)->
	newLayer.midX=centerX-Math.sin((angle+180)  * Math.PI / 180)*radiusX
	newLayer.midY=centerY-Math.cos((angle+180)  * Math.PI / 180)*radiusY
