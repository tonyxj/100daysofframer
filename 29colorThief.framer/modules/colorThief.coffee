


# 'colorThief' module v1.0
# by Marc Krenn, July 1st, 2016 | marc.krenn@gmail.com | @marc_krenn

# ... based on colorThief.js by by Lokesh Dhakar http://www.lokeshdhakar.com
# and kulturaveshchi


# The 'colorThief' module allows you to extract the dominant color(s) of images.


# --------------------------------------------------------------------

# The following is a slightly modified, auto-converted coffeescript version
# of Color Thief, based on a PR by kulturaveshchi (https://github.com/lokesh/color-thief/pull/84)



# Usage:
# --------------------------------------------------------------------
###

# Include Module by adding the following line on top of your project
{ColorThief} = require "colorThief"


# Get dominant color

colorThief.getColor imgSrc, (color) ->
	print color

# Optional: Set custom sample quality
colorThief.getColor {url:imgSrc, quality:10}, (color) ->
	print color



# Get color palette

# By default, this will return 5 colors at default quality 10
colorThief.getPalette imgSrc, (colors) ->
	print colors

# Optional: Set custom colorCount and sample quality
colorThief.getPalette {url:imgSrc, colorCount: 5, quality:10}, (colors) ->
	print colors

###


# --------------------------------------------------------------------

###!
# Color Thief v2.0
# by Lokesh Dhakar - http://www.lokeshdhakar.com
#
# License
# -------
# Creative Commons Attribution 2.5 License:
# http://creativecommons.org/licenses/by/2.5/
#
# Thanks
# ------
# Nick Rabinowitz - For creating quantize.js.
# John Schulz - For clean up and optimization. @JFSIII
# Nathan Spady - For adding drag and drop support to the demo page.
#
###


###
  CanvasImage Class
  Class that wraps the html image element and canvas.
  It also simplifies some of the canvas context manipulation
  with a set of helper functions.
###

CanvasImage = (image) ->
  @canvas = document.createElement('canvas')
  @context = @canvas.getContext('2d')
  document.body.appendChild @canvas
  @width = @canvas.width = image.width
  @height = @canvas.height = image.height
  @context.drawImage image, 0, 0, @width, @height
  return

CanvasImage::clear = ->
  @context.clearRect 0, 0, @width, @height
  return

CanvasImage::update = (imageData) ->
  @context.putImageData imageData, 0, 0
  return

CanvasImage::getPixelCount = ->
  @width * @height

CanvasImage::getImageData = ->
  @context.getImageData 0, 0, @width, @height

CanvasImage::removeCanvas = ->
  @canvas.parentNode.removeChild @canvas
  return

exports.ColorThief = ->

###
# getColor(sourceImage[, quality])
# returns {r: num, g: num, b: num}
#
# Use the median cut algorithm provided by quantize.js to cluster similar
# colors and return the base color from the largest cluster.
#
# Quality is an optional argument. It needs to be an integer. 1 is the highest quality settings.
# 10 is the default. There is a trade-off between quality and speed. The bigger the number, the
# faster a color will be returned but the greater the likelihood that it will not be the visually
# most dominant color.
#
# 
###

exports.ColorThief::getColor = (imgOptions, response) ->

  switch typeof imgOptions
    when "string"
      url = imgOptions
      quality = 10
    when "object"
      url = imgOptions.url
      quality = imgOptions.quality


  img = new Image

  img.onload = =>
    palette = @getColors(img, 5, quality)
    dominantColor = palette[0]
    response(colRgb = new Color("rgb(#{dominantColor[0]},#{dominantColor[1]},#{dominantColor[2]})"))

  img.crossOrigin = "anonymous"
  if url.startsWith("http") then img.src = "https://crossorigin.me/#{url}" else img.src = url



exports.ColorThief::getPalette = (imgOptions, response) ->

  switch typeof imgOptions
    when "string" then url = imgOptions
    when "object" then url = imgOptions.url


  quality    = imgOptions.quality    ?= 10
  colorCount = imgOptions.colorCount ?= 5


  img = new Image

  img.onload = =>
    palette = @getColors(img, colorCount, quality)

    colArray = []


    for col in palette
      colArray.push(new Color("rgb(#{col[0]},#{col[1]},#{col[2]})"))

    response(colArray)


  img.crossOrigin = "anonymous"
  if url.startsWith("http") then img.src = "https://crossorigin.me/#{url}" else img.src = url




###
# getColors(sourceImage[, colorCount, quality])
# returns array[ {r: num, g: num, b: num}, {r: num, g: num, b: num}, ...]
#
# Use the median cut algorithm provided by quantize.js to cluster similar colors.
#
# colorCount determines the size of the palette; the number of colors returned. If not set, it
# defaults to 10.
#
# BUGGY: Function does not always return the requested amount of colors. It can be +/- 2.
#
# quality is an optional argument. It needs to be an integer. 1 is the highest quality settings.
# 10 is the default. There is a trade-off between quality and speed. The bigger the number, the
# faster the palette generation but the greater the likelihood that colors will be missed.
#
#
###

exports.ColorThief::getColors = (sourceImage, colorCount, quality) ->

  if `typeof colorCount == 'undefined'`
    colorCount = 10
  if `typeof quality == 'undefined'` or quality < 1
    quality = 10
  # Create custom CanvasImage object
  image = new CanvasImage(sourceImage)
  imageData = image.getImageData()
  pixels = imageData.data
  pixelCount = image.getPixelCount()
  # Store the RGB values in an array format suitable for quantize function
  pixelArray = []
  i = 0
  offset = undefined
  r = undefined
  g = undefined
  b = undefined
  a = undefined
  while i < pixelCount
    offset = i * 4
    r = pixels[offset + 0]
    g = pixels[offset + 1]
    b = pixels[offset + 2]
    a = pixels[offset + 3]
    # If pixel is mostly opaque and not white
    if a >= 125
      if !(r > 250 and g > 250 and b > 250)
        pixelArray.push [
          r
          g
          b
        ]
    i = i + quality
  # Send array to quantize function which clusters values
  # using median cut algorithm
  cmap = MMCQ.quantize(pixelArray, colorCount)
  palette = if cmap then cmap.palette() else null
  # Clean up
  image.removeCanvas()
  palette

###!
# quantize.js Copyright 2008 Nick Rabinowitz.
# Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
###

# fill out a couple protovis dependencies

###!
# Block below copied from Protovis: http://mbostock.github.com/protovis/
# Copyright 2010 Stanford Visualization Group
# Licensed under the BSD License: http://www.opensource.org/licenses/bsd-license.php
###

if !pv
  pv = 
    map: (array, f) ->
      o = {}
      if f then array.map(((d, i) ->
        o.index = i
        f.call o, d
      )) else array.slice()
    naturalOrder: (a, b) ->
      if a < b then -1 else if a > b then 1 else 0
    sum: (array, f) ->
      o = {}
      array.reduce if f then ((p, d, i) ->
        o.index = i
        p + f.call(o, d)
      ) else ((p, d) ->
        p + d
      )
    max: (array, f) ->
      Math.max.apply null, if f then pv.map(array, f) else array

###*
# Basic Javascript port of the MMCQ (modified median cut quantization)
# algorithm from the Leptonica library (http://www.leptonica.com/).
# Returns a color map you can use to map original pixels to the reduced
# palette. Still a work in progress.
#
# @author Nick Rabinowitz
# @example

// array of pixels as [R,G,B] arrays
var myPixels = [[190,197,190], [202,204,200], [207,214,210], [211,214,211], [205,207,207]
                // etc
                ];
var maxColors = 4;

var cmap = MMCQ.quantize(myPixels, maxColors);
var newPalette = cmap.palette();
var newPixels = myPixels.map(function(p) {
    return cmap.map(p);
});

###

MMCQ = do ->
  # private constants
  sigbits = 5
  rshift = 8 - sigbits
  maxIterations = 1000
  fractByPopulations = 0.75
  # get reduced-space color index for a pixel

  getColorIndex = (r, g, b) ->
    (r << 2 * sigbits) + (g << sigbits) + b

  # Simple priority queue

  PQueue = (comparator) ->
    contents = []
    sorted = false

    sort = ->
      contents.sort comparator
      sorted = true
      return

    {
      push: (o) ->
        contents.push o
        sorted = false
        return
      peek: (index) ->
        if !sorted
          sort()
        if `index == undefined`
          index = contents.length - 1
        contents[index]
      pop: ->
        if !sorted
          sort()
        contents.pop()
      size: ->
        contents.length
      map: (f) ->
        contents.map f
      debug: ->
        if !sorted
          sort()
        contents

    }

  # 3d color space box

  VBox = (r1, r2, g1, g2, b1, b2, histo) ->
    vbox = this
    vbox.r1 = r1
    vbox.r2 = r2
    vbox.g1 = g1
    vbox.g2 = g2
    vbox.b1 = b1
    vbox.b2 = b2
    vbox.histo = histo
    return

  # Color map

  CMap = ->
    @vboxes = new PQueue((a, b) ->
      pv.naturalOrder a.vbox.count() * a.vbox.volume(), b.vbox.count() * b.vbox.volume()
)
    return

  # histo (1-d array, giving the number of pixels in
  # each quantized region of color space), or null on error

  getHisto = (pixels) ->
    histosize = 1 << 3 * sigbits
    histo = new Array(histosize)
    index = undefined
    rval = undefined
    gval = undefined
    bval = undefined
    pixels.forEach (pixel) ->
      rval = pixel[0] >> rshift
      gval = pixel[1] >> rshift
      bval = pixel[2] >> rshift
      index = getColorIndex(rval, gval, bval)
      histo[index] = (histo[index] or 0) + 1
      return
    histo

  vboxFromPixels = (pixels, histo) ->
    rmin = 1000000
    rmax = 0
    gmin = 1000000
    gmax = 0
    bmin = 1000000
    bmax = 0
    rval = undefined
    gval = undefined
    bval = undefined
    # find min/max
    pixels.forEach (pixel) ->
      rval = pixel[0] >> rshift
      gval = pixel[1] >> rshift
      bval = pixel[2] >> rshift
      if rval < rmin
        rmin = rval
      else if rval > rmax
        rmax = rval
      if gval < gmin
        gmin = gval
      else if gval > gmax
        gmax = gval
      if bval < bmin
        bmin = bval
      else if bval > bmax
        bmax = bval
      return
    new VBox(rmin, rmax, gmin, gmax, bmin, bmax, histo)

  medianCutApply = (histo, vbox) ->

    doCut = (color) ->
      dim1 = color + '1'
      dim2 = color + '2'
      left = undefined
      right = undefined
      vbox1 = undefined
      vbox2 = undefined
      d2 = undefined
      count2 = 0
      `i = vbox[dim1]`
      while i <= vbox[dim2]
        if partialsum[i] > total / 2
          vbox1 = vbox.copy()
          vbox2 = vbox.copy()
          left = i - (vbox[dim1])
          right = vbox[dim2] - i
          if left <= right
            d2 = Math.min(vbox[dim2] - 1, ~ ~(i + right / 2))
          else
            d2 = Math.max(vbox[dim1], ~ ~(i - 1 - (left / 2)))
          # avoid 0-count boxes
          while !partialsum[d2]
            d2++
          count2 = lookaheadsum[d2]
          while !count2 and partialsum[d2 - 1]
            count2 = lookaheadsum[--d2]
          # set dimensions
          vbox1[dim2] = d2
          vbox2[dim1] = vbox1[dim2] + 1
          #                    console.log('vbox counts:', vbox.count(), vbox1.count(), vbox2.count());
          return [
            vbox1
            vbox2
          ]
        i++
      return

    if !vbox.count()
      return
    rw = vbox.r2 - (vbox.r1) + 1
    gw = vbox.g2 - (vbox.g1) + 1
    bw = vbox.b2 - (vbox.b1) + 1
    maxw = pv.max([
      rw
      gw
      bw
    ])
    # only one pixel, no split
    if `vbox.count() == 1`
      return [ vbox.copy() ]

    ### Find the partial sum arrays along the selected axis. ###

    total = 0
    partialsum = []
    lookaheadsum = []
    i = undefined
    j = undefined
    k = undefined
    sum = undefined
    index = undefined
    if `maxw == rw`
      i = vbox.r1
      while i <= vbox.r2
        sum = 0
        j = vbox.g1
        while j <= vbox.g2
          k = vbox.b1
          while k <= vbox.b2
            index = getColorIndex(i, j, k)
            sum += histo[index] or 0
            k++
          j++
        total += sum
        partialsum[i] = total
        i++
    else if `maxw == gw`
      i = vbox.g1
      while i <= vbox.g2
        sum = 0
        j = vbox.r1
        while j <= vbox.r2
          k = vbox.b1
          while k <= vbox.b2
            index = getColorIndex(j, i, k)
            sum += histo[index] or 0
            k++
          j++
        total += sum
        partialsum[i] = total
        i++
    else

      ### maxw == bw ###

      i = vbox.b1
      while i <= vbox.b2
        sum = 0
        j = vbox.r1
        while j <= vbox.r2
          k = vbox.g1
          while k <= vbox.g2
            index = getColorIndex(j, k, i)
            sum += histo[index] or 0
            k++
          j++
        total += sum
        partialsum[i] = total
        i++
    partialsum.forEach (d, i) ->
      lookaheadsum[i] = total - d
      return
    # determine the cut planes
    if `maxw == rw` then doCut('r') else if `maxw == gw` then doCut('g') else doCut('b')

  quantize = (pixels, maxcolors) ->
    k = 0
    # short-circuit
    # inner function to do the iteration

    iter = (lh, target) ->
      ncolors = lh.size()
      niters = 0
      vbox = undefined
      while niters < maxIterations
        if ncolors >= target
          return
        if niters++ > maxIterations
          #                    console.log("infinite loop; perhaps too few pixels!");
          return
        vbox = lh.pop()
        if !vbox.count()

          ### just put it back ###

          lh.push vbox
          niters++
          k++
          continue
        # do the cut
        vboxes = medianCutApply(histo, vbox)
        vbox1 = vboxes[0]
        vbox2 = vboxes[1]
        if !vbox1
          #                    console.log("vbox1 not defined; shouldn't happen!");
          return
        lh.push vbox1
        if vbox2

          ### vbox2 can be null ###

          lh.push vbox2
          ncolors++
      return

    if !pixels.length or maxcolors < 2 or maxcolors > 256
      #            console.log('wrong number of maxcolors');
      return false
    # XXX: check color content and convert to grayscale if insufficient
    histo = getHisto(pixels)
    histosize = 1 << 3 * sigbits
    # check that we aren't below maxcolors already
    nColors = 0
    histo.forEach ->
      nColors++
      return
    if nColors <= maxcolors
      # XXX: generate the new colors from the histo and return
    else
    # get the beginning vbox from the colors
    vbox = vboxFromPixels(pixels, histo)
    pq = new PQueue((a, b) ->
      pv.naturalOrder a.count(), b.count()
)
    pq.push vbox
    # first set of colors, sorted by population
    iter pq, fractByPopulations * maxcolors
    # Re-sort by the product of pixel occupancy times the size in color space.
    pq2 = new PQueue((a, b) ->
      pv.naturalOrder a.count() * a.volume(), b.count() * b.volume()
)
    while pq.size()
      pq2.push pq.pop()
    # next set - generate the median cuts using the (npix * vol) sorting.
    iter pq2, maxcolors
    # calculate the actual colors
    cmap = new CMap
    while pq2.size()
      cmap.push pq2.pop()
    cmap

  VBox.prototype =
    volume: (force) ->
      vbox = this
      if !vbox._volume or force
        vbox._volume = (vbox.r2 - (vbox.r1) + 1) * (vbox.g2 - (vbox.g1) + 1) * (vbox.b2 - (vbox.b1) + 1)
      vbox._volume
    count: (force) ->
      vbox = this
      histo = vbox.histo
      if !vbox._count_set or force
        npix = 0
        i = undefined
        j = undefined
        k = undefined
        i = vbox.r1
        while i <= vbox.r2
          j = vbox.g1
          while j <= vbox.g2
            k = vbox.b1
            while k <= vbox.b2
              `index = getColorIndex(i, j, k)`
              npix += histo[index] or 0
              k++
            j++
          i++
        vbox._count = npix
        vbox._count_set = true
      vbox._count
    copy: ->
      vbox = this
      new VBox(vbox.r1, vbox.r2, vbox.g1, vbox.g2, vbox.b1, vbox.b2, vbox.histo)
    avg: (force) ->
      vbox = this
      histo = vbox.histo
      if !vbox._avg or force
        ntot = 0
        mult = 1 << 8 - sigbits
        rsum = 0
        gsum = 0
        bsum = 0
        hval = undefined
        i = undefined
        j = undefined
        k = undefined
        histoindex = undefined
        i = vbox.r1
        while i <= vbox.r2
          j = vbox.g1
          while j <= vbox.g2
            k = vbox.b1
            while k <= vbox.b2
              histoindex = getColorIndex(i, j, k)
              hval = histo[histoindex] or 0
              ntot += hval
              rsum += hval * (i + 0.5) * mult
              gsum += hval * (j + 0.5) * mult
              bsum += hval * (k + 0.5) * mult
              k++
            j++
          i++
        if ntot
          vbox._avg = [
            ~ ~(rsum / ntot)
            ~ ~(gsum / ntot)
            ~ ~(bsum / ntot)
          ]
        else
          #                    console.log('empty box');
          vbox._avg = [
            ~ ~(mult * (vbox.r1 + vbox.r2 + 1) / 2)
            ~ ~(mult * (vbox.g1 + vbox.g2 + 1) / 2)
            ~ ~(mult * (vbox.b1 + vbox.b2 + 1) / 2)
          ]
      vbox._avg
    contains: (pixel) ->
      vbox = this
      rval = pixel[0] >> rshift
      `gval = pixel[1] >> rshift`
      `bval = pixel[2] >> rshift`
      rval >= vbox.r1 and rval <= vbox.r2 and gval >= vbox.g1 and gval <= vbox.g2 and bval >= vbox.b1 and bval <= vbox.b2
  CMap.prototype =
    push: (vbox) ->
      @vboxes.push
        vbox: vbox
        color: vbox.avg()
      return
    palette: ->
      @vboxes.map (vb) ->
        vb.color
    size: ->
      @vboxes.size()
    map: (color) ->
      vboxes = @vboxes
      i = 0
      while i < vboxes.size()
        if vboxes.peek(i).vbox.contains(color)
          return vboxes.peek(i).color
        i++
      @nearest color
    nearest: (color) ->
      vboxes = @vboxes
      d1 = undefined
      d2 = undefined
      pColor = undefined
      i = 0
      while i < vboxes.size()
        d2 = Math.sqrt((color[0] - (vboxes.peek(i).color[0])) ** 2 + (color[1] - (vboxes.peek(i).color[1])) ** 2 + (color[2] - (vboxes.peek(i).color[2])) ** 2)
        if d2 < d1 or `d1 == undefined`
          d1 = d2
          pColor = vboxes.peek(i).color
        i++
      pColor
    forcebw: ->
      # XXX: won't  work yet
      vboxes = @vboxes
      vboxes.sort (a, b) ->
        pv.naturalOrder pv.sum(a.color), pv.sum(b.color)
      # force darkest color to black if everything < 5
      lowest = vboxes[0].color
      if lowest[0] < 5 and lowest[1] < 5 and lowest[2] < 5
        vboxes[0].color = [
          0
          0
          0
        ]
      # force lightest color to white if everything > 251
      idx = vboxes.length - 1
      highest = vboxes[idx].color
      if highest[0] > 251 and highest[1] > 251 and highest[2] > 251
        vboxes[idx].color = [
          255
          255
          255
        ]
      return
  { quantize: quantize }

# ---
# generated by js2coffee 2.2.0