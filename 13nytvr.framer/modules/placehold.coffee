styleArr = [
    {
        str: "simple",
        url: "http://placehold.it/",
        separator: "x",
    },
    {
        str: "unsplash",
        url: "https://unsplash.it/",
        separator: "/",
    },
    {
        str: "cage",
        url: "http://placecage.com/",
        separator: "/",
    },
    {
        str: "crazy-cage",
        url: "http://placecage.com/c/",
        separator: "/",
    },
    {
        str: "murray",
        url: "http://fillmurray.com/",
        separator: "/",
    },
    {
        str: "starwars",
        url: "http://420placehold.it/starwars/",
        separator: "-",
    },
    {
        str: "startrek",
        url: "http://420placehold.it/startrek/",
        separator: "-",
    },
    {
        str: "space",
        url: "http://420placehold.it/space/",
        separator: "-",
    },
    {
        str: "fatcats",
        url: "http://420placehold.it/fatcats/",
        separator: "-",
    },
    {
        str: "familyphotos",
        url: "http://420placehold.it/familyphotos/",
        separator: "-",
    }
]


isInArr = ( styleStr ) -> 

    for i in [0..styleArr.length-1] by 1

        if styleArr[i].str == styleStr
            return styleArr[i]

    return false


randomStyle = ( layer ) ->

    style = styleArr[Math.floor(Math.random() * styleArr.length)].str
    applyStyle( layer, style )


createUrl = (style, width, height) ->

    inArr = isInArr(style)

    if (inArr)
        url = inArr.url + width + inArr.separator + height
    else 
        url = "https://unsplash.it/" + width + '/' + height

    return url


applyStyle = ( layer, style ) ->
    niceUrl = createUrl(style, layer.width, layer.height)
    layer.image = niceUrl


exports.placeHold = ( layer, style ) ->

    if layer
        if style != "random"
            applyStyle( layer, style )
        else
            randomStyle( layer, style )


exports.getUrl = ( style, width, height ) -> 
    return createUrl( style, width, height )