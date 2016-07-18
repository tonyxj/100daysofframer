{User} = require "User"
{Button} = require "Button"

bg = new BackgroundLayer
	backgroundColor: "#fafafa"

button = new Button
	cta: "Show Customers"
	ctaSize: 40
	x: 70
	y: 300

customerList = new ScrollComponent
	width: Screen.width
	height: Screen.height
	x: 0
	y: Screen.height + 200
	scrollHorizontal: false
	backgroundColor: "#fff"
customerList.states.add show: y: 0
customerList.states.animationOptions = curve: "spring(100, 13, 0)"
customerList.onScrollEnd ->
	scrAmt = customerList.scrollY
	if scrAmt <= -300 and scrAmt
			customerList.states.switch("default")

close = new Layer
	width: 100
	height: 100
	parent: customerList.content
	x: Screen.width - 52
	y: 32
	html: "X"
	color: "#333"
	backgroundColor: null
	opacity: 0.3
	style: 
		fontSize: "36px"
	
close.onClick ->
	customerList.states.switch("default")
	
button.onClick ->
	customerList.states.switch("show")
	Utils.domLoadJSON "http://jsonplaceholder.typicode.com/users", (error, response) ->
		for user, i in response
			newUser = new User
				parent: customerList.content
				y: i * 470 + 150
				idNum: user.id
				height: 470 
				name: user.name
				phone: user.phone
				email: user.email
				company: user.company.name
				city: user.address.city
				website: user.website
	

