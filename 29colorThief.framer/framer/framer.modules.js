require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"colorThief":[function(require,module,exports){

/*

 * Include Module by adding the following line on top of your project
{ColorThief} = require "colorThief"


 * Get dominant color

colorThief.getColor imgSrc, (color) ->
	print color

 * Optional: Set custom sample quality
colorThief.getColor {url:imgSrc, quality:10}, (color) ->
	print color



 * Get color palette

 * By default, this will return 5 colors at default quality 10
colorThief.getPalette imgSrc, (colors) ->
	print colors

 * Optional: Set custom colorCount and sample quality
colorThief.getPalette {url:imgSrc, colorCount: 5, quality:10}, (colors) ->
	print colors
 */

/*!
 * Color Thief v2.0
 * by Lokesh Dhakar - http://www.lokeshdhakar.com
 *
 * License
 * -------
 * Creative Commons Attribution 2.5 License:
 * http://creativecommons.org/licenses/by/2.5/
 *
 * Thanks
 * ------
 * Nick Rabinowitz - For creating quantize.js.
 * John Schulz - For clean up and optimization. @JFSIII
 * Nathan Spady - For adding drag and drop support to the demo page.
 *
 */

/*
  CanvasImage Class
  Class that wraps the html image element and canvas.
  It also simplifies some of the canvas context manipulation
  with a set of helper functions.
 */
var CanvasImage, MMCQ, pv;

CanvasImage = function(image) {
  this.canvas = document.createElement('canvas');
  this.context = this.canvas.getContext('2d');
  document.body.appendChild(this.canvas);
  this.width = this.canvas.width = image.width;
  this.height = this.canvas.height = image.height;
  this.context.drawImage(image, 0, 0, this.width, this.height);
};

CanvasImage.prototype.clear = function() {
  this.context.clearRect(0, 0, this.width, this.height);
};

CanvasImage.prototype.update = function(imageData) {
  this.context.putImageData(imageData, 0, 0);
};

CanvasImage.prototype.getPixelCount = function() {
  return this.width * this.height;
};

CanvasImage.prototype.getImageData = function() {
  return this.context.getImageData(0, 0, this.width, this.height);
};

CanvasImage.prototype.removeCanvas = function() {
  this.canvas.parentNode.removeChild(this.canvas);
};

exports.ColorThief = function() {};


/*
 * getColor(sourceImage[, quality])
 * returns {r: num, g: num, b: num}
 *
 * Use the median cut algorithm provided by quantize.js to cluster similar
 * colors and return the base color from the largest cluster.
 *
 * Quality is an optional argument. It needs to be an integer. 1 is the highest quality settings.
 * 10 is the default. There is a trade-off between quality and speed. The bigger the number, the
 * faster a color will be returned but the greater the likelihood that it will not be the visually
 * most dominant color.
 *
 *
 */

exports.ColorThief.prototype.getColor = function(imgOptions, response) {
  var img, quality, url;
  switch (typeof imgOptions) {
    case "string":
      url = imgOptions;
      quality = 10;
      break;
    case "object":
      url = imgOptions.url;
      quality = imgOptions.quality;
  }
  img = new Image;
  img.onload = (function(_this) {
    return function() {
      var colRgb, dominantColor, palette;
      palette = _this.getColors(img, 5, quality);
      dominantColor = palette[0];
      return response(colRgb = new Color("rgb(" + dominantColor[0] + "," + dominantColor[1] + "," + dominantColor[2] + ")"));
    };
  })(this);
  img.crossOrigin = "anonymous";
  if (url.startsWith("http")) {
    return img.src = "https://crossorigin.me/" + url;
  } else {
    return img.src = url;
  }
};

exports.ColorThief.prototype.getPalette = function(imgOptions, response) {
  var colorCount, img, quality, url;
  switch (typeof imgOptions) {
    case "string":
      url = imgOptions;
      break;
    case "object":
      url = imgOptions.url;
  }
  quality = imgOptions.quality != null ? imgOptions.quality : imgOptions.quality = 10;
  colorCount = imgOptions.colorCount != null ? imgOptions.colorCount : imgOptions.colorCount = 5;
  img = new Image;
  img.onload = (function(_this) {
    return function() {
      var col, colArray, l, len, palette;
      palette = _this.getColors(img, colorCount, quality);
      colArray = [];
      for (l = 0, len = palette.length; l < len; l++) {
        col = palette[l];
        colArray.push(new Color("rgb(" + col[0] + "," + col[1] + "," + col[2] + ")"));
      }
      return response(colArray);
    };
  })(this);
  img.crossOrigin = "anonymous";
  if (url.startsWith("http")) {
    return img.src = "https://crossorigin.me/" + url;
  } else {
    return img.src = url;
  }
};


/*
 * getColors(sourceImage[, colorCount, quality])
 * returns array[ {r: num, g: num, b: num}, {r: num, g: num, b: num}, ...]
 *
 * Use the median cut algorithm provided by quantize.js to cluster similar colors.
 *
 * colorCount determines the size of the palette; the number of colors returned. If not set, it
 * defaults to 10.
 *
 * BUGGY: Function does not always return the requested amount of colors. It can be +/- 2.
 *
 * quality is an optional argument. It needs to be an integer. 1 is the highest quality settings.
 * 10 is the default. There is a trade-off between quality and speed. The bigger the number, the
 * faster the palette generation but the greater the likelihood that colors will be missed.
 *
 *
 */

exports.ColorThief.prototype.getColors = function(sourceImage, colorCount, quality) {
  var a, b, cmap, g, i, image, imageData, offset, palette, pixelArray, pixelCount, pixels, r;
  if (typeof colorCount == 'undefined') {
    colorCount = 10;
  }
  if (typeof quality == 'undefined' || quality < 1) {
    quality = 10;
  }
  image = new CanvasImage(sourceImage);
  imageData = image.getImageData();
  pixels = imageData.data;
  pixelCount = image.getPixelCount();
  pixelArray = [];
  i = 0;
  offset = void 0;
  r = void 0;
  g = void 0;
  b = void 0;
  a = void 0;
  while (i < pixelCount) {
    offset = i * 4;
    r = pixels[offset + 0];
    g = pixels[offset + 1];
    b = pixels[offset + 2];
    a = pixels[offset + 3];
    if (a >= 125) {
      if (!(r > 250 && g > 250 && b > 250)) {
        pixelArray.push([r, g, b]);
      }
    }
    i = i + quality;
  }
  cmap = MMCQ.quantize(pixelArray, colorCount);
  palette = cmap ? cmap.palette() : null;
  image.removeCanvas();
  return palette;
};


/*!
 * quantize.js Copyright 2008 Nick Rabinowitz.
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */


/*!
 * Block below copied from Protovis: http://mbostock.github.com/protovis/
 * Copyright 2010 Stanford Visualization Group
 * Licensed under the BSD License: http://www.opensource.org/licenses/bsd-license.php
 */

if (!pv) {
  pv = {
    map: function(array, f) {
      var o;
      o = {};
      if (f) {
        return array.map((function(d, i) {
          o.index = i;
          return f.call(o, d);
        }));
      } else {
        return array.slice();
      }
    },
    naturalOrder: function(a, b) {
      if (a < b) {
        return -1;
      } else if (a > b) {
        return 1;
      } else {
        return 0;
      }
    },
    sum: function(array, f) {
      var o;
      o = {};
      return array.reduce(f ? (function(p, d, i) {
        o.index = i;
        return p + f.call(o, d);
      }) : (function(p, d) {
        return p + d;
      }));
    },
    max: function(array, f) {
      return Math.max.apply(null, f ? pv.map(array, f) : array);
    }
  };
}


/**
 * Basic Javascript port of the MMCQ (modified median cut quantization)
 * algorithm from the Leptonica library (http://www.leptonica.com/).
 * Returns a color map you can use to map original pixels to the reduced
 * palette. Still a work in progress.
 *
 * @author Nick Rabinowitz
 * @example

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
 */

MMCQ = (function() {
  var CMap, PQueue, VBox, fractByPopulations, getColorIndex, getHisto, maxIterations, medianCutApply, quantize, rshift, sigbits, vboxFromPixels;
  sigbits = 5;
  rshift = 8 - sigbits;
  maxIterations = 1000;
  fractByPopulations = 0.75;
  getColorIndex = function(r, g, b) {
    return (r << 2 * sigbits) + (g << sigbits) + b;
  };
  PQueue = function(comparator) {
    var contents, sort, sorted;
    contents = [];
    sorted = false;
    sort = function() {
      contents.sort(comparator);
      sorted = true;
    };
    return {
      push: function(o) {
        contents.push(o);
        sorted = false;
      },
      peek: function(index) {
        if (!sorted) {
          sort();
        }
        if (index == undefined) {
          index = contents.length - 1;
        }
        return contents[index];
      },
      pop: function() {
        if (!sorted) {
          sort();
        }
        return contents.pop();
      },
      size: function() {
        return contents.length;
      },
      map: function(f) {
        return contents.map(f);
      },
      debug: function() {
        if (!sorted) {
          sort();
        }
        return contents;
      }
    };
  };
  VBox = function(r1, r2, g1, g2, b1, b2, histo) {
    var vbox;
    vbox = this;
    vbox.r1 = r1;
    vbox.r2 = r2;
    vbox.g1 = g1;
    vbox.g2 = g2;
    vbox.b1 = b1;
    vbox.b2 = b2;
    vbox.histo = histo;
  };
  CMap = function() {
    this.vboxes = new PQueue(function(a, b) {
      return pv.naturalOrder(a.vbox.count() * a.vbox.volume(), b.vbox.count() * b.vbox.volume());
    });
  };
  getHisto = function(pixels) {
    var bval, gval, histo, histosize, index, rval;
    histosize = 1 << 3 * sigbits;
    histo = new Array(histosize);
    index = void 0;
    rval = void 0;
    gval = void 0;
    bval = void 0;
    pixels.forEach(function(pixel) {
      rval = pixel[0] >> rshift;
      gval = pixel[1] >> rshift;
      bval = pixel[2] >> rshift;
      index = getColorIndex(rval, gval, bval);
      histo[index] = (histo[index] || 0) + 1;
    });
    return histo;
  };
  vboxFromPixels = function(pixels, histo) {
    var bmax, bmin, bval, gmax, gmin, gval, rmax, rmin, rval;
    rmin = 1000000;
    rmax = 0;
    gmin = 1000000;
    gmax = 0;
    bmin = 1000000;
    bmax = 0;
    rval = void 0;
    gval = void 0;
    bval = void 0;
    pixels.forEach(function(pixel) {
      rval = pixel[0] >> rshift;
      gval = pixel[1] >> rshift;
      bval = pixel[2] >> rshift;
      if (rval < rmin) {
        rmin = rval;
      } else if (rval > rmax) {
        rmax = rval;
      }
      if (gval < gmin) {
        gmin = gval;
      } else if (gval > gmax) {
        gmax = gval;
      }
      if (bval < bmin) {
        bmin = bval;
      } else if (bval > bmax) {
        bmax = bval;
      }
    });
    return new VBox(rmin, rmax, gmin, gmax, bmin, bmax, histo);
  };
  medianCutApply = function(histo, vbox) {
    var bw, doCut, gw, i, index, j, k, lookaheadsum, maxw, partialsum, rw, sum, total;
    doCut = function(color) {
      var count2, d2, dim1, dim2, left, right, vbox1, vbox2;
      dim1 = color + '1';
      dim2 = color + '2';
      left = void 0;
      right = void 0;
      vbox1 = void 0;
      vbox2 = void 0;
      d2 = void 0;
      count2 = 0;
      i = vbox[dim1];
      while (i <= vbox[dim2]) {
        if (partialsum[i] > total / 2) {
          vbox1 = vbox.copy();
          vbox2 = vbox.copy();
          left = i - vbox[dim1];
          right = vbox[dim2] - i;
          if (left <= right) {
            d2 = Math.min(vbox[dim2] - 1, ~~(i + right / 2));
          } else {
            d2 = Math.max(vbox[dim1], ~~(i - 1 - (left / 2)));
          }
          while (!partialsum[d2]) {
            d2++;
          }
          count2 = lookaheadsum[d2];
          while (!count2 && partialsum[d2 - 1]) {
            count2 = lookaheadsum[--d2];
          }
          vbox1[dim2] = d2;
          vbox2[dim1] = vbox1[dim2] + 1;
          return [vbox1, vbox2];
        }
        i++;
      }
    };
    if (!vbox.count()) {
      return;
    }
    rw = vbox.r2 - vbox.r1 + 1;
    gw = vbox.g2 - vbox.g1 + 1;
    bw = vbox.b2 - vbox.b1 + 1;
    maxw = pv.max([rw, gw, bw]);
    if (vbox.count() == 1) {
      return [vbox.copy()];
    }

    /* Find the partial sum arrays along the selected axis. */
    total = 0;
    partialsum = [];
    lookaheadsum = [];
    i = void 0;
    j = void 0;
    k = void 0;
    sum = void 0;
    index = void 0;
    if (maxw == rw) {
      i = vbox.r1;
      while (i <= vbox.r2) {
        sum = 0;
        j = vbox.g1;
        while (j <= vbox.g2) {
          k = vbox.b1;
          while (k <= vbox.b2) {
            index = getColorIndex(i, j, k);
            sum += histo[index] || 0;
            k++;
          }
          j++;
        }
        total += sum;
        partialsum[i] = total;
        i++;
      }
    } else if (maxw == gw) {
      i = vbox.g1;
      while (i <= vbox.g2) {
        sum = 0;
        j = vbox.r1;
        while (j <= vbox.r2) {
          k = vbox.b1;
          while (k <= vbox.b2) {
            index = getColorIndex(j, i, k);
            sum += histo[index] || 0;
            k++;
          }
          j++;
        }
        total += sum;
        partialsum[i] = total;
        i++;
      }
    } else {

      /* maxw == bw */
      i = vbox.b1;
      while (i <= vbox.b2) {
        sum = 0;
        j = vbox.r1;
        while (j <= vbox.r2) {
          k = vbox.g1;
          while (k <= vbox.g2) {
            index = getColorIndex(j, k, i);
            sum += histo[index] || 0;
            k++;
          }
          j++;
        }
        total += sum;
        partialsum[i] = total;
        i++;
      }
    }
    partialsum.forEach(function(d, i) {
      lookaheadsum[i] = total - d;
    });
    if (maxw == rw) {
      return doCut('r');
    } else if (maxw == gw) {
      return doCut('g');
    } else {
      return doCut('b');
    }
  };
  quantize = function(pixels, maxcolors) {
    var cmap, histo, histosize, iter, k, nColors, pq, pq2, vbox;
    k = 0;
    iter = function(lh, target) {
      var ncolors, niters, vbox, vbox1, vbox2, vboxes;
      ncolors = lh.size();
      niters = 0;
      vbox = void 0;
      while (niters < maxIterations) {
        if (ncolors >= target) {
          return;
        }
        if (niters++ > maxIterations) {
          return;
        }
        vbox = lh.pop();
        if (!vbox.count()) {

          /* just put it back */
          lh.push(vbox);
          niters++;
          k++;
          continue;
        }
        vboxes = medianCutApply(histo, vbox);
        vbox1 = vboxes[0];
        vbox2 = vboxes[1];
        if (!vbox1) {
          return;
        }
        lh.push(vbox1);
        if (vbox2) {

          /* vbox2 can be null */
          lh.push(vbox2);
          ncolors++;
        }
      }
    };
    if (!pixels.length || maxcolors < 2 || maxcolors > 256) {
      return false;
    }
    histo = getHisto(pixels);
    histosize = 1 << 3 * sigbits;
    nColors = 0;
    histo.forEach(function() {
      nColors++;
    });
    if (nColors <= maxcolors) {

    } else {

    }
    vbox = vboxFromPixels(pixels, histo);
    pq = new PQueue(function(a, b) {
      return pv.naturalOrder(a.count(), b.count());
    });
    pq.push(vbox);
    iter(pq, fractByPopulations * maxcolors);
    pq2 = new PQueue(function(a, b) {
      return pv.naturalOrder(a.count() * a.volume(), b.count() * b.volume());
    });
    while (pq.size()) {
      pq2.push(pq.pop());
    }
    iter(pq2, maxcolors);
    cmap = new CMap;
    while (pq2.size()) {
      cmap.push(pq2.pop());
    }
    return cmap;
  };
  VBox.prototype = {
    volume: function(force) {
      var vbox;
      vbox = this;
      if (!vbox._volume || force) {
        vbox._volume = (vbox.r2 - vbox.r1 + 1) * (vbox.g2 - vbox.g1 + 1) * (vbox.b2 - vbox.b1 + 1);
      }
      return vbox._volume;
    },
    count: function(force) {
      var histo, i, j, k, npix, vbox;
      vbox = this;
      histo = vbox.histo;
      if (!vbox._count_set || force) {
        npix = 0;
        i = void 0;
        j = void 0;
        k = void 0;
        i = vbox.r1;
        while (i <= vbox.r2) {
          j = vbox.g1;
          while (j <= vbox.g2) {
            k = vbox.b1;
            while (k <= vbox.b2) {
              index = getColorIndex(i, j, k);
              npix += histo[index] || 0;
              k++;
            }
            j++;
          }
          i++;
        }
        vbox._count = npix;
        vbox._count_set = true;
      }
      return vbox._count;
    },
    copy: function() {
      var vbox;
      vbox = this;
      return new VBox(vbox.r1, vbox.r2, vbox.g1, vbox.g2, vbox.b1, vbox.b2, vbox.histo);
    },
    avg: function(force) {
      var bsum, gsum, histo, histoindex, hval, i, j, k, mult, ntot, rsum, vbox;
      vbox = this;
      histo = vbox.histo;
      if (!vbox._avg || force) {
        ntot = 0;
        mult = 1 << 8 - sigbits;
        rsum = 0;
        gsum = 0;
        bsum = 0;
        hval = void 0;
        i = void 0;
        j = void 0;
        k = void 0;
        histoindex = void 0;
        i = vbox.r1;
        while (i <= vbox.r2) {
          j = vbox.g1;
          while (j <= vbox.g2) {
            k = vbox.b1;
            while (k <= vbox.b2) {
              histoindex = getColorIndex(i, j, k);
              hval = histo[histoindex] || 0;
              ntot += hval;
              rsum += hval * (i + 0.5) * mult;
              gsum += hval * (j + 0.5) * mult;
              bsum += hval * (k + 0.5) * mult;
              k++;
            }
            j++;
          }
          i++;
        }
        if (ntot) {
          vbox._avg = [~~(rsum / ntot), ~~(gsum / ntot), ~~(bsum / ntot)];
        } else {
          vbox._avg = [~~(mult * (vbox.r1 + vbox.r2 + 1) / 2), ~~(mult * (vbox.g1 + vbox.g2 + 1) / 2), ~~(mult * (vbox.b1 + vbox.b2 + 1) / 2)];
        }
      }
      return vbox._avg;
    },
    contains: function(pixel) {
      var rval, vbox;
      vbox = this;
      rval = pixel[0] >> rshift;
      gval = pixel[1] >> rshift;
      bval = pixel[2] >> rshift;
      return rval >= vbox.r1 && rval <= vbox.r2 && gval >= vbox.g1 && gval <= vbox.g2 && bval >= vbox.b1 && bval <= vbox.b2;
    }
  };
  CMap.prototype = {
    push: function(vbox) {
      this.vboxes.push({
        vbox: vbox,
        color: vbox.avg()
      });
    },
    palette: function() {
      return this.vboxes.map(function(vb) {
        return vb.color;
      });
    },
    size: function() {
      return this.vboxes.size();
    },
    map: function(color) {
      var i, vboxes;
      vboxes = this.vboxes;
      i = 0;
      while (i < vboxes.size()) {
        if (vboxes.peek(i).vbox.contains(color)) {
          return vboxes.peek(i).color;
        }
        i++;
      }
      return this.nearest(color);
    },
    nearest: function(color) {
      var d1, d2, i, pColor, vboxes;
      vboxes = this.vboxes;
      d1 = void 0;
      d2 = void 0;
      pColor = void 0;
      i = 0;
      while (i < vboxes.size()) {
        d2 = Math.sqrt(Math.pow(color[0] - (vboxes.peek(i).color[0]), 2) + Math.pow(color[1] - (vboxes.peek(i).color[1]), 2) + Math.pow(color[2] - (vboxes.peek(i).color[2]), 2));
        if (d2 < d1 || d1 == undefined) {
          d1 = d2;
          pColor = vboxes.peek(i).color;
        }
        i++;
      }
      return pColor;
    },
    forcebw: function() {
      var highest, idx, lowest, vboxes;
      vboxes = this.vboxes;
      vboxes.sort(function(a, b) {
        return pv.naturalOrder(pv.sum(a.color), pv.sum(b.color));
      });
      lowest = vboxes[0].color;
      if (lowest[0] < 5 && lowest[1] < 5 && lowest[2] < 5) {
        vboxes[0].color = [0, 0, 0];
      }
      idx = vboxes.length - 1;
      highest = vboxes[idx].color;
      if (highest[0] > 251 && highest[1] > 251 && highest[2] > 251) {
        vboxes[idx].color = [255, 255, 255];
      }
    }
  };
  return {
    quantize: quantize
  };
})();


},{}],"myModule":[function(require,module,exports){
exports.myVar = "myVariable";

exports.myFunction = function() {
  return print("myFunction is running");
};

exports.myArray = [1, 2, 3];


},{}]},{},[])
//# sourceMappingURL=data:application/json;charset:utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvVXNlcnMvVEovR29vZ2xlIERyaXZlL19EZXNpZ24vX0ZyYW1lci9wbGF5Z3JvdW5kLzI5Y29sb3JUaGllZi5mcmFtZXIvbW9kdWxlcy9jb2xvclRoaWVmLmNvZmZlZSIsIi9Vc2Vycy9USi9Hb29nbGUgRHJpdmUvX0Rlc2lnbi9fRnJhbWVyL3BsYXlncm91bmQvMjljb2xvclRoaWVmLmZyYW1lci9tb2R1bGVzL215TW9kdWxlLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFBQTs7QUNzQkE7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7QUFnQ0E7Ozs7Ozs7Ozs7Ozs7Ozs7O0FBa0JBOzs7Ozs7QUFsREEsSUFBQTs7QUF5REEsV0FBQSxHQUFjLFNBQUMsS0FBRDtFQUNaLElBQUMsQ0FBQSxNQUFELEdBQVUsUUFBUSxDQUFDLGFBQVQsQ0FBdUIsUUFBdkI7RUFDVixJQUFDLENBQUEsT0FBRCxHQUFXLElBQUMsQ0FBQSxNQUFNLENBQUMsVUFBUixDQUFtQixJQUFuQjtFQUNYLFFBQVEsQ0FBQyxJQUFJLENBQUMsV0FBZCxDQUEwQixJQUFDLENBQUEsTUFBM0I7RUFDQSxJQUFDLENBQUEsS0FBRCxHQUFTLElBQUMsQ0FBQSxNQUFNLENBQUMsS0FBUixHQUFnQixLQUFLLENBQUM7RUFDL0IsSUFBQyxDQUFBLE1BQUQsR0FBVSxJQUFDLENBQUEsTUFBTSxDQUFDLE1BQVIsR0FBaUIsS0FBSyxDQUFDO0VBQ2pDLElBQUMsQ0FBQSxPQUFPLENBQUMsU0FBVCxDQUFtQixLQUFuQixFQUEwQixDQUExQixFQUE2QixDQUE3QixFQUFnQyxJQUFDLENBQUEsS0FBakMsRUFBd0MsSUFBQyxDQUFBLE1BQXpDO0FBTlk7O0FBU2QsV0FBVyxDQUFBLFNBQUUsQ0FBQSxLQUFiLEdBQXFCLFNBQUE7RUFDbkIsSUFBQyxDQUFBLE9BQU8sQ0FBQyxTQUFULENBQW1CLENBQW5CLEVBQXNCLENB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Q0FBQSxDQUFBLENBQVIsR0FBYSxHQUExRDtRQUNFLE1BQU8sQ0FBQSxHQUFBLENBQUksQ0FBQyxLQUFaLEdBQW9CLENBQ2xCLEdBRGtCLEVBRWxCLEdBRmtCLEVBR2xCLEdBSGtCLEVBRHRCOztJQWhCTyxDQS9CVDs7U0FzREY7SUFBRSxRQUFBLEVBQVUsUUFBWjs7QUE5YlEsQ0FBQSxDQUFILENBQUE7Ozs7QUNsU1AsT0FBTyxDQUFDLEtBQVIsR0FBZ0I7O0FBRWhCLE9BQU8sQ0FBQyxVQUFSLEdBQXFCLFNBQUE7U0FDcEIsS0FBQSxDQUFNLHVCQUFOO0FBRG9COztBQUdyQixPQUFPLENBQUMsT0FBUixHQUFrQixDQUFDLENBQUQsRUFBSSxDQUFKLEVBQU8sQ0FBUCIsImZpbGUiOiJnZW5lcmF0ZWQuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlc0NvbnRlbnQiOlsiKGZ1bmN0aW9uIGUodCxuLHIpe2Z1bmN0aW9uIHMobyx1KXtpZighbltvXSl7aWYoIXRbb10pe3ZhciBhPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7aWYoIXUmJmEpcmV0dXJuIGEobywhMCk7aWYoaSlyZXR1cm4gaShvLCEwKTt2YXIgZj1uZXcgRXJyb3IoXCJDYW5ub3QgZmluZCBtb2R1bGUgJ1wiK28rXCInXCIpO3Rocm93IGYuY29kZT1cIk1PRFVMRV9OT1RfRk9VTkRcIixmfXZhciBsPW5bb109e2V4cG9ydHM6e319O3Rbb11bMF0uY2FsbChsLmV4cG9ydHMsZnVuY3Rpb24oZSl7dmFyIG49dFtvXVsxXVtlXTtyZXR1cm4gcyhuP246ZSl9LGwsbC5leHBvcnRzLGUsdCxuLHIpfXJldHVybiBuW29dLmV4cG9ydHN9dmFyIGk9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtmb3IodmFyIG89MDtvPHIubGVuZ3RoO28rKylzKHJbb10pO3JldHVybiBzfSkiLCJcblxuXG4jICdjb2xvclRoaWVmJyBtb2R1bGUgdjEuMFxuIyBieSBNYXJjIEtyZW5uLCBKdWx5IDFzdCwgMjAxNiB8IG1hcmMua3Jlbm5AZ21haWwuY29tIHwgQG1hcmNfa3Jlbm5cblxuIyAuLi4gYmFzZWQgb24gY29sb3JUaGllZi5qcyBieSBieSBMb2tlc2ggRGhha2FyIGh0dHA6Ly93d3cubG9rZXNoZGhha2FyLmNvbVxuIyBhbmQga3VsdHVyYXZlc2hjaGlcblxuXG4jIFRoZSAnY29sb3JUaGllZicgbW9kdWxlIGFsbG93cyB5b3UgdG8gZXh0cmFjdCB0aGUgZG9taW5hbnQgY29sb3Iocykgb2YgaW1hZ2VzLlxuXG5cbiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1cblxuIyBUaGUgZm9sbG93aW5nIGlzIGEgc2xpZ2h0bHkgbW9kaWZpZWQsIGF1dG8tY29udmVydGVkIGNvZmZlZXNjcmlwdCB2ZXJzaW9uXG4jIG9mIENvbG9yIFRoaWVmLCBiYXNlZCBvbiBhIFBSIGJ5IGt1bHR1cmF2ZXNoY2hpIChodHRwczovL2dpdGh1Yi5jb20vbG9rZXNoL2NvbG9yLXRoaWVmL3B1bGwvODQpXG5cblxuXG4jIFVzYWdlOlxuIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLVxuIyMjXG5cbiMgSW5jbHVkZSBNb2R1bGUgYnkgYWRkaW5nIHRoZSBmb2xsb3dpbmcgbGluZSBvbiB0b3Agb2YgeW91ciBwcm9qZWN0XG57Q29sb3JUaGllZn0gPSByZXF1aXJlIFwiY29sb3JUaGllZlwiXG5cblxuIyBHZXQgZG9taW5hbnQgY29sb3JcblxuY29sb3JUaGllZi5nZXRDb2xvciBpbWdTcmMsIChjb2xvcikgLT5cblx0cHJpbnQgY29sb3JcblxuIyBPcHRpb25hbDogU2V0IGN1c3RvbSBzYW1wbGUgcXVhbGl0eVxuY29sb3JUaGllZi5nZXRDb2xvciB7dXJsOmltZ1NyYywgcXVhbGl0eToxMH0sIChjb2xvcikgLT5cblx0cHJpbnQgY29sb3JcblxuXG5cbiMgR2V0IGNvbG9yIHBhbGV0dGVcblxuIyBCeSBkZWZhdWx0LCB0aGlzIHdpbGwgcmV0dXJuIDUgY29sb3JzIGF0IGRlZmF1bHQgcXVhbGl0eSAxMFxuY29sb3JUaGllZi5nZXRQYWxldHRlIGltZ1NyYywgKGNvbG9ycykgLT5cblx0cHJpbnQgY29sb3JzXG5cbiMgT3B0aW9uYWw6IFNldCBjdXN0b20gY29sb3JDb3VudCBhbmQgc2FtcGxlIHF1YWxpdHlcbmNvbG9yVGhpZWYuZ2V0UGFsZXR0ZSB7dXJsOmltZ1NyYywgY29sb3JDb3VudDogNSwgcXVhbGl0eToxMH0sIChjb2xvcnMpIC0+XG5cdHByaW50IGNvbG9yc1xuXG4jIyNcblxuXG4jIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tXG5cbiMjIyFcbiMgQ29sb3IgVGhpZWYgdjIuMFxuIyBieSBMb2tlc2ggRGhha2FyIC0gaHR0cDovL3d3dy5sb2tlc2hkaGFrYXIuY29tXG4jXG4jIExpY2Vuc2VcbiMgLS0tLS0tLVxuIyBDcmVhdGl2ZSBDb21tb25zIEF0dHJpYnV0aW9uIDIuNSBMaWNlbnNlOlxuIyBodHRwOi8vY3JlYXRpdmVjb21tb25zLm9yZy9saWNlbnNlcy9ieS8yLjUvXG4jXG4jIFRoYW5rc1xuIyAtLS0tLS1cbiMgTmljayBSYWJpbm93aXR6IC0gRm9yIGNyZWF0aW5nIHF1YW50aXplLmpzLlxuIyBKb2huIFNjaHVseiAtIEZvciBjbGVhbiB1cCBhbmQgb3B0aW1pemF0aW9uLiBASkZTSUlJXG4jIE5hdGhhbiBTcGFkeSAtIEZvciBhZGRpbmcgZHJhZyBhbmQgZHJvcCBzdXBwb3J0IHRvIHRoZSBkZW1vIHBhZ2UuXG4jXG4jIyNcblxuXG4jIyNcbiAgQ2FudmFzSW1hZ2UgQ2xhc3NcbiAgQ2xhc3MgdGhhdCB3cmFwcyB0aGUgaHRtbCBpbWFnZSBlbGVtZW50IGFuZCBjYW52YXMuXG4gIEl0IGFsc28gc2ltcGxpZmllcyBzb21lIG9mIHRoZSBjYW52YXMgY29udGV4dCBtYW5pcHVsYXRpb25cbiAgd2l0aCBhIHNldCBvZiBoZWxwZXIgZnVuY3Rpb25zLlxuIyMjXG5cbkNhbnZhc0ltYWdlID0gKGltYWdlKSAtPlxuICBAY2FudmFzID0gZG9jdW1lbnQuY3JlYXRlRWxlbWVudCgnY2FudmFzJylcbiAgQGNvbnRleHQgPSBAY2FudmFzLmdldENvbnRleHQoJzJkJylcbiAgZG9jdW1lbnQuYm9keS5hcHBlbmRDaGlsZCBAY2FudmFzXG4gIEB3aWR0aCA9IEBjYW52YXMud2lkdGggPSBpbWFnZS53aWR0aFxuICBAaGVpZ2h0ID0gQGNhbnZhcy5oZWlnaHQgPSBpbWFnZS5oZWlnaHRcbiAgQGNvbnRleHQuZHJhd0ltYWdlIGltYWdlLCAwLCAwLCBAd2lkdGgsIEBoZWlnaHRcbiAgcmV0dXJuXG5cbkNhbnZhc0ltYWdlOjpjbGVhciA9IC0+XG4gIEBjb250ZXh0LmNsZWFyUmVjdCAwLCAwLCBAd2lkdGgsIEBoZWlnaHRcbiAgcmV0dXJuXG5cbkNhbnZhc0ltYWdlOjp1cGRhdGUgPSAoaW1hZ2VEYXRhKSAtPlxuICBAY29udGV4dC5wdXRJbWFnZURhdGEgaW1hZ2VEYXRhLCAwLCAwXG4gIHJldHVyblxuXG5DYW52YXNJbWFnZTo6Z2V0UGl4ZWxDb3VudCA9IC0+XG4gIEB3aWR0aCAqIEBoZWlnaHRcblxuQ2FudmFzSW1hZ2U6OmdldEltYWdlRGF0YSA9IC0+XG4gIEBjb250ZXh0LmdldEltYWdlRGF0YSAwLCAwLCBAd2lkdGgsIEBoZWlnaHRcblxuQ2FudmFzSW1hZ2U6OnJlbW92ZUNhbnZhcyA9IC0+XG4gIEBjYW52YXMucGFyZW50Tm9kZS5yZW1vdmVDaGlsZCBAY2FudmFzXG4gIHJldHVyblxuXG5leHBvcnRzLkNvbG9yVGhpZWYgPSAtPlxuXG4jIyNcbiMgZ2V0Q29sb3Ioc291cmNlSW1hZ2VbLCBxdWFsaXR5XSlcbiMgcmV0dXJucyB7cjogbnVtLCBnOiBudW0sIGI6IG51bX1cbiNcbiMgVXNlIHRoZSBtZWRpYW4gY3V0IGFsZ29yaXRobSBwcm92aWRlZCBieSBxdWFudGl6ZS5qcyB0byBjbHVzdGVyIHNpbWlsYXJcbiMgY29sb3JzIGFuZCByZXR1cm4gdGhlIGJhc2UgY29sb3IgZnJvbSB0aGUgbGFyZ2VzdCBjbHVzdGVyLlxuI1xuIyBRdWFsaXR5IGlzIGFuIG9wdGlvbmFsIGFyZ3VtZW50LiBJdCBuZWVkcyB0byBiZSBhbiBpbnRlZ2VyLiAxIGlzIHRoZSBoaWdoZXN0IHF1YWxpdHkgc2V0dGluZ3MuXG4jIDEwIGlzIHRoZSBkZWZhdWx0LiBUaGVyZSBpcyBhIHRyYWRlLW9mZiBiZXR3ZWVuIHF1YWxpdHkgYW5kIHNwZWVkLiBUaGUgYmlnZ2VyIHRoZSBudW1iZXIsIHRoZVxuIyBmYXN0ZXIgYSBjb2xvciB3aWxsIGJlIHJldHVybmVkIGJ1dCB0aGUgZ3JlYXRlciB0aGUgbGlrZWxpaG9vZCB0aGF0IGl0IHdpbGwgbm90IGJlIHRoZSB2aXN1YWxseVxuIyBtb3N0IGRvbWluYW50IGNvbG9yLlxuI1xuIyBcbiMjI1xuXG5leHBvcnRzLkNvbG9yVGhpZWY6OmdldENvbG9yID0gKGltZ09wdGlvbnMsIHJlc3BvbnNlKSAtPlxuXG4gIHN3aXRjaCB0eXBlb2YgaW1nT3B0aW9uc1xuICAgIHdoZW4gXCJzdHJpbmdcIlxuICAgICAgdXJsID0gaW1nT3B0aW9uc1xuICAgICAgcXVhbGl0eSA9IDEwXG4gICAgd2hlbiBcIm9iamVjdFwiXG4gICAgICB1cmwgPSBpbWdPcHRpb25zLnVybFxuICAgICAgcXVhbGl0eSA9IGltZ09wdGlvbnMucXVhbGl0eVxuXG5cbiAgaW1nID0gbmV3IEltYWdlXG5cbiAgaW1nLm9ubG9hZCA9ID0+XG4gICAgcGFsZXR0ZSA9IEBnZXRDb2xvcnMoaW1nLCA1LCBxdWFsaXR5KVxuICAgIGRvbWluYW50Q29sb3IgPSBwYWxldHRlWzBdXG4gICAgcmVzcG9uc2UoY29sUmdiID0gbmV3IENvbG9yKFwicmdiKCN7ZG9taW5hbnRDb2xvclswXX0sI3tkb21pbmFudENvbG9yWzFdfSwje2RvbWluYW50Q29sb3JbMl19KVwiKSlcblxuICBpbWcuY3Jvc3NPcmlnaW4gPSBcImFub255bW91c1wiXG4gIGlmIHVybC5zdGFydHNXaXRoKFwiaHR0cFwiKSB0aGVuIGltZy5zcmMgPSBcImh0dHBzOi8vY3Jvc3NvcmlnaW4ubWUvI3t1cmx9XCIgZWxzZSBpbWcuc3JjID0gdXJsXG5cblxuXG5leHBvcnRzLkNvbG9yVGhpZWY6OmdldFBhbGV0dGUgPSAoaW1nT3B0aW9ucywgcmVzcG9uc2UpIC0+XG5cbiAgc3dpdGNoIHR5cGVvZiBpbWdPcHRpb25zXG4gICAgd2hlbiBcInN0cmluZ1wiIHRoZW4gdXJsID0gaW1nT3B0aW9uc1xuICAgIHdoZW4gXCJvYmplY3RcIiB0aGVuIHVybCA9IGltZ09wdGlvbnMudXJsXG5cblxuICBxdWFsaXR5ICAgID0gaW1nT3B0aW9ucy5xdWFsaXR5ICAgID89IDEwXG4gIGNvbG9yQ291bnQgPSBpbWdPcHRpb25zLmNvbG9yQ291bnQgPz0gNVxuXG5cbiAgaW1nID0gbmV3IEltYWdlXG5cbiAgaW1nLm9ubG9hZCA9ID0+XG4gICAgcGFsZXR0ZSA9IEBnZXRDb2xvcnMoaW1nLCBjb2xvckNvdW50LCBxdWFsaXR5KVxuXG4gICAgY29sQXJyYXkgPSBbXVxuXG5cbiAgICBmb3IgY29sIGluIHBhbGV0dGVcbiAgICAgIGNvbEFycmF5LnB1c2gobmV3IENvbG9yKFwicmdiKCN7Y29sWzBdfSwje2NvbFsxXX0sI3tjb2xbMl19KVwiKSlcblxuICAgIHJlc3BvbnNlKGNvbEFycmF5KVxuXG5cbiAgaW1nLmNyb3NzT3JpZ2luID0gXCJhbm9ueW1vdXNcIlxuICBpZiB1cmwuc3RhcnRzV2l0aChcImh0dHBcIikgdGhlbiBpbWcuc3JjID0gXCJodHRwczovL2Nyb3Nzb3JpZ2luLm1lLyN7dXJsfVwiIGVsc2UgaW1nLnNyYyA9IHVybFxuXG5cblxuXG4jIyNcbiMgZ2V0Q29sb3JzKHNvdXJjZUltYWdlWywgY29sb3JDb3VudCwgcXVhbGl0eV0pXG4jIHJldHVybnMgYXJyYXlbIHtyOiBudW0sIGc6IG51bSwgYjogbnVtfSwge3I6IG51bSwgZzogbnVtLCBiOiBudW19LCAuLi5dXG4jXG4jIFVzZSB0aGUgbWVkaWFuIGN1dCBhbGdvcml0aG0gcHJvdmlkZWQgYnkgcXVhbnRpemUuanMgdG8gY2x1c3RlciBzaW1pbGFyIGNvbG9ycy5cbiNcbiMgY29sb3JDb3VudCBkZXRlcm1pbmVzIHRoZSBzaXplIG9mIHRoZSBwYWxldHRlOyB0aGUgbnVtYmVyIG9mIGNvbG9ycyByZXR1cm5lZC4gSWYgbm90IHNldCwgaXRcbiMgZGVmYXVsdHMgdG8gMTAuXG4jXG4jIEJVR0dZOiBGdW5jdGlvbiBkb2VzIG5vdCBhbHdheXMgcmV0dXJuIHRoZSByZXF1ZXN0ZWQgYW1vdW50IG9mIGNvbG9ycy4gSXQgY2FuIGJlICsvLSAyLlxuI1xuIyBxdWFsaXR5IGlzIGFuIG9wdGlvbmFsIGFyZ3VtZW50LiBJdCBuZWVkcyB0byBiZSBhbiBpbnRlZ2VyLiAxIGlzIHRoZSBoaWdoZXN0IHF1YWxpdHkgc2V0dGluZ3MuXG4jIDEwIGlzIHRoZSBkZWZhdWx0LiBUaGVyZSBpcyBhIHRyYWRlLW9mZiBiZXR3ZWVuIHF1YWxpdHkgYW5kIHNwZWVkLiBUaGUgYmlnZ2VyIHRoZSBudW1iZXIsIHRoZVxuIyBmYXN0ZXIgdGhlIHBhbGV0dGUgZ2VuZXJhdGlvbiBidXQgdGhlIGdyZWF0ZXIgdGhlIGxpa2VsaWhvb2QgdGhhdCBjb2xvcnMgd2lsbCBiZSBtaXNzZWQuXG4jXG4jXG4jIyNcblxuZXhwb3J0cy5Db2xvclRoaWVmOjpnZXRDb2xvcnMgPSAoc291cmNlSW1hZ2UsIGNvbG9yQ291bnQsIHF1YWxpdHkpIC0+XG5cbiAgaWYgYHR5cGVvZiBjb2xvckNvdW50ID09ICd1bmRlZmluZWQnYFxuICAgIGNvbG9yQ291bnQgPSAxMFxuICBpZiBgdHlwZW9mIHF1YWxpdHkgPT0gJ3VuZGVmaW5lZCdgIG9yIHF1YWxpdHkgPCAxXG4gICAgcXVhbGl0eSA9IDEwXG4gICMgQ3JlYXRlIGN1c3RvbSBDYW52YXNJbWFnZSBvYmplY3RcbiAgaW1hZ2UgPSBuZXcgQ2FudmFzSW1hZ2Uoc291cmNlSW1hZ2UpXG4gIGltYWdlRGF0YSA9IGltYWdlLmdldEltYWdlRGF0YSgpXG4gIHBpeGVscyA9IGltYWdlRGF0YS5kYXRhXG4gIHBpeGVsQ291bnQgPSBpbWFnZS5nZXRQaXhlbENvdW50KClcbiAgIyBTdG9yZSB0aGUgUkdCIHZhbHVlcyBpbiBhbiBhcnJheSBmb3JtYXQgc3VpdGFibGUgZm9yIHF1YW50aXplIGZ1bmN0aW9uXG4gIHBpeGVsQXJyYXkgPSBbXVxuICBpID0gMFxuICBvZmZzZXQgPSB1bmRlZmluZWRcbiAgciA9IHVuZGVmaW5lZFxuICBnID0gdW5kZWZpbmVkXG4gIGIgPSB1bmRlZmluZWRcbiAgYSA9IHVuZGVmaW5lZFxuICB3aGlsZSBpIDwgcGl4ZWxDb3VudFxuICAgIG9mZnNldCA9IGkgKiA0XG4gICAgciA9IHBpeGVsc1tvZmZzZXQgKyAwXVxuICAgIGcgPSBwaXhlbHNbb2Zmc2V0ICsgMV1cbiAgICBiID0gcGl4ZWxzW29mZnNldCArIDJdXG4gICAgYSA9IHBpeGVsc1tvZmZzZXQgKyAzXVxuICAgICMgSWYgcGl4ZWwgaXMgbW9zdGx5IG9wYXF1ZSBhbmQgbm90IHdoaXRlXG4gICAgaWYgYSA+PSAxMjVcbiAgICAgIGlmICEociA+IDI1MCBhbmQgZyA+IDI1MCBhbmQgYiA+IDI1MClcbiAgICAgICAgcGl4ZWxBcnJheS5wdXNoIFtcbiAgICAgICAgICByXG4gICAgICAgICAgZ1xuICAgICAgICAgIGJcbiAgICAgICAgXVxuICAgIGkgPSBpICsgcXVhbGl0eVxuICAjIFNlbmQgYXJyYXkgdG8gcXVhbnRpemUgZnVuY3Rpb24gd2hpY2ggY2x1c3RlcnMgdmFsdWVzXG4gICMgdXNpbmcgbWVkaWFuIGN1dCBhbGdvcml0aG1cbiAgY21hcCA9IE1NQ1EucXVhbnRpemUocGl4ZWxBcnJheSwgY29sb3JDb3VudClcbiAgcGFsZXR0ZSA9IGlmIGNtYXAgdGhlbiBjbWFwLnBhbGV0dGUoKSBlbHNlIG51bGxcbiAgIyBDbGVhbiB1cFxuICBpbWFnZS5yZW1vdmVDYW52YXMoKVxuICBwYWxldHRlXG5cbiMjIyFcbiMgcXVhbnRpemUuanMgQ29weXJpZ2h0IDIwMDggTmljayBSYWJpbm93aXR6LlxuIyBMaWNlbnNlZCB1bmRlciB0aGUgTUlUIGxpY2Vuc2U6IGh0dHA6Ly93d3cub3BlbnNvdXJjZS5vcmcvbGljZW5zZXMvbWl0LWxpY2Vuc2UucGhwXG4jIyNcblxuIyBmaWxsIG91dCBhIGNvdXBsZSBwcm90b3ZpcyBkZXBlbmRlbmNpZXNcblxuIyMjIVxuIyBCbG9jayBiZWxvdyBjb3BpZWQgZnJvbSBQcm90b3ZpczogaHR0cDovL21ib3N0b2NrLmdpdGh1Yi5jb20vcHJvdG92aXMvXG4jIENvcHlyaWdodCAyMDEwIFN0YW5mb3JkIFZpc3VhbGl6YXRpb24gR3JvdXBcbiMgTGljZW5zZWQgdW5kZXIgdGhlIEJTRCBMaWNlbnNlOiBodHRwOi8vd3d3Lm9wZW5zb3VyY2Uub3JnL2xpY2Vuc2VzL2JzZC1saWNlbnNlLnBocFxuIyMjXG5cbmlmICFwdlxuICBwdiA9IFxuICAgIG1hcDogKGFycmF5LCBmKSAtPlxuICAgICAgbyA9IHt9XG4gICAgICBpZiBmIHRoZW4gYXJyYXkubWFwKCgoZCwgaSkgLT5cbiAgICAgICAgby5pbmRleCA9IGlcbiAgICAgICAgZi5jYWxsIG8sIGRcbiAgICAgICkpIGVsc2UgYXJyYXkuc2xpY2UoKVxuICAgIG5hdHVyYWxPcmRlcjogKGEsIGIpIC0+XG4gICAgICBpZiBhIDwgYiB0aGVuIC0xIGVsc2UgaWYgYSA+IGIgdGhlbiAxIGVsc2UgMFxuICAgIHN1bTogKGFycmF5LCBmKSAtPlxuICAgICAgbyA9IHt9XG4gICAgICBhcnJheS5yZWR1Y2UgaWYgZiB0aGVuICgocCwgZCwgaSkgLT5cbiAgICAgICAgby5pbmRleCA9IGlcbiAgICAgICAgcCArIGYuY2FsbChvLCBkKVxuICAgICAgKSBlbHNlICgocCwgZCkgLT5cbiAgICAgICAgcCArIGRcbiAgICAgIClcbiAgICBtYXg6IChhcnJheSwgZikgLT5cbiAgICAgIE1hdGgubWF4LmFwcGx5IG51bGwsIGlmIGYgdGhlbiBwdi5tYXAoYXJyYXksIGYpIGVsc2UgYXJyYXlcblxuIyMjKlxuIyBCYXNpYyBKYXZhc2NyaXB0IHBvcnQgb2YgdGhlIE1NQ1EgKG1vZGlmaWVkIG1lZGlhbiBjdXQgcXVhbnRpemF0aW9uKVxuIyBhbGdvcml0aG0gZnJvbSB0aGUgTGVwdG9uaWNhIGxpYnJhcnkgKGh0dHA6Ly93d3cubGVwdG9uaWNhLmNvbS8pLlxuIyBSZXR1cm5zIGEgY29sb3IgbWFwIHlvdSBjYW4gdXNlIHRvIG1hcCBvcmlnaW5hbCBwaXhlbHMgdG8gdGhlIHJlZHVjZWRcbiMgcGFsZXR0ZS4gU3RpbGwgYSB3b3JrIGluIHByb2dyZXNzLlxuI1xuIyBAYXV0aG9yIE5pY2sgUmFiaW5vd2l0elxuIyBAZXhhbXBsZVxuXG4vLyBhcnJheSBvZiBwaXhlbHMgYXMgW1IsRyxCXSBhcnJheXNcbnZhciBteVBpeGVscyA9IFtbMTkwLDE5NywxOTBdLCBbMjAyLDIwNCwyMDBdLCBbMjA3LDIxNCwyMTBdLCBbMjExLDIxNCwyMTFdLCBbMjA1LDIwNywyMDddXG4gICAgICAgICAgICAgICAgLy8gZXRjXG4gICAgICAgICAgICAgICAgXTtcbnZhciBtYXhDb2xvcnMgPSA0O1xuXG52YXIgY21hcCA9IE1NQ1EucXVhbnRpemUobXlQaXhlbHMsIG1heENvbG9ycyk7XG52YXIgbmV3UGFsZXR0ZSA9IGNtYXAucGFsZXR0ZSgpO1xudmFyIG5ld1BpeGVscyA9IG15UGl4ZWxzLm1hcChmdW5jdGlvbihwKSB7XG4gICAgcmV0dXJuIGNtYXAubWFwKHApO1xufSk7XG5cbiMjI1xuXG5NTUNRID0gZG8gLT5cbiAgIyBwcml2YXRlIGNvbnN0YW50c1xuICBzaWdiaXRzID0gNVxuICByc2hpZnQgPSA4IC0gc2lnYml0c1xuICBtYXhJdGVyYXRpb25zID0gMTAwMFxuICBmcmFjdEJ5UG9wdWxhdGlvbnMgPSAwLjc1XG4gICMgZ2V0IHJlZHVjZWQtc3BhY2UgY29sb3IgaW5kZXggZm9yIGEgcGl4ZWxcblxuICBnZXRDb2xvckluZGV4ID0gKHIsIGcsIGIpIC0+XG4gICAgKHIgPDwgMiAqIHNpZ2JpdHMpICsgKGcgPDwgc2lnYml0cykgKyBiXG5cbiAgIyBTaW1wbGUgcHJpb3JpdHkgcXVldWVcblxuICBQUXVldWUgPSAoY29tcGFyYXRvcikgLT5cbiAgICBjb250ZW50cyA9IFtdXG4gICAgc29ydGVkID0gZmFsc2VcblxuICAgIHNvcnQgPSAtPlxuICAgICAgY29udGVudHMuc29ydCBjb21wYXJhdG9yXG4gICAgICBzb3J0ZWQgPSB0cnVlXG4gICAgICByZXR1cm5cblxuICAgIHtcbiAgICAgIHB1c2g6IChvKSAtPlxuICAgICAgICBjb250ZW50cy5wdXNoIG9cbiAgICAgICAgc29ydGVkID0gZmFsc2VcbiAgICAgICAgcmV0dXJuXG4gICAgICBwZWVrOiAoaW5kZXgpIC0+XG4gICAgICAgIGlmICFzb3J0ZWRcbiAgICAgICAgICBzb3J0KClcbiAgICAgICAgaWYgYGluZGV4ID09IHVuZGVmaW5lZGBcbiAgICAgICAgICBpbmRleCA9IGNvbnRlbnRzLmxlbmd0aCAtIDFcbiAgICAgICAgY29udGVudHNbaW5kZXhdXG4gICAgICBwb3A6IC0+XG4gICAgICAgIGlmICFzb3J0ZWRcbiAgICAgICAgICBzb3J0KClcbiAgICAgICAgY29udGVudHMucG9wKClcbiAgICAgIHNpemU6IC0+XG4gICAgICAgIGNvbnRlbnRzLmxlbmd0aFxuICAgICAgbWFwOiAoZikgLT5cbiAgICAgICAgY29udGVudHMubWFwIGZcbiAgICAgIGRlYnVnOiAtPlxuICAgICAgICBpZiAhc29ydGVkXG4gICAgICAgICAgc29ydCgpXG4gICAgICAgIGNvbnRlbnRzXG5cbiAgICB9XG5cbiAgIyAzZCBjb2xvciBzcGFjZSBib3hcblxuICBWQm94ID0gKHIxLCByMiwgZzEsIGcyLCBiMSwgYjIsIGhpc3RvKSAtPlxuICAgIHZib3ggPSB0aGlzXG4gICAgdmJveC5yMSA9IHIxXG4gICAgdmJveC5yMiA9IHIyXG4gICAgdmJveC5nMSA9IGcxXG4gICAgdmJveC5nMiA9IGcyXG4gICAgdmJveC5iMSA9IGIxXG4gICAgdmJveC5iMiA9IGIyXG4gICAgdmJveC5oaXN0byA9IGhpc3RvXG4gICAgcmV0dXJuXG5cbiAgIyBDb2xvciBtYXBcblxuICBDTWFwID0gLT5cbiAgICBAdmJveGVzID0gbmV3IFBRdWV1ZSgoYSwgYikgLT5cbiAgICAgIHB2Lm5hdHVyYWxPcmRlciBhLnZib3guY291bnQoKSAqIGEudmJveC52b2x1bWUoKSwgYi52Ym94LmNvdW50KCkgKiBiLnZib3gudm9sdW1lKClcbilcbiAgICByZXR1cm5cblxuICAjIGhpc3RvICgxLWQgYXJyYXksIGdpdmluZyB0aGUgbnVtYmVyIG9mIHBpeGVscyBpblxuICAjIGVhY2ggcXVhbnRpemVkIHJlZ2lvbiBvZiBjb2xvciBzcGFjZSksIG9yIG51bGwgb24gZXJyb3JcblxuICBnZXRIaXN0byA9IChwaXhlbHMpIC0+XG4gICAgaGlzdG9zaXplID0gMSA8PCAzICogc2lnYml0c1xuICAgIGhpc3RvID0gbmV3IEFycmF5KGhpc3Rvc2l6ZSlcbiAgICBpbmRleCA9IHVuZGVmaW5lZFxuICAgIHJ2YWwgPSB1bmRlZmluZWRcbiAgICBndmFsID0gdW5kZWZpbmVkXG4gICAgYnZhbCA9IHVuZGVmaW5lZFxuICAgIHBpeGVscy5mb3JFYWNoIChwaXhlbCkgLT5cbiAgICAgIHJ2YWwgPSBwaXhlbFswXSA+PiByc2hpZnRcbiAgICAgIGd2YWwgPSBwaXhlbFsxXSA+PiByc2hpZnRcbiAgICAgIGJ2YWwgPSBwaXhlbFsyXSA+PiByc2hpZnRcbiAgICAgIGluZGV4ID0gZ2V0Q29sb3JJbmRleChydmFsLCBndmFsLCBidmFsKVxuICAgICAgaGlzdG9baW5kZXhdID0gKGhpc3RvW2luZGV4XSBvciAwKSArIDFcbiAgICAgIHJldHVyblxuICAgIGhpc3RvXG5cbiAgdmJveEZyb21QaXhlbHMgPSAocGl4ZWxzLCBoaXN0bykgLT5cbiAgICBybWluID0gMTAwMDAwMFxuICAgIHJtYXggPSAwXG4gICAgZ21pbiA9IDEwMDAwMDBcbiAgICBnbWF4ID0gMFxuICAgIGJtaW4gPSAxMDAwMDAwXG4gICAgYm1heCA9IDBcbiAgICBydmFsID0gdW5kZWZpbmVkXG4gICAgZ3ZhbCA9IHVuZGVmaW5lZFxuICAgIGJ2YWwgPSB1bmRlZmluZWRcbiAgICAjIGZpbmQgbWluL21heFxuICAgIHBpeGVscy5mb3JFYWNoIChwaXhlbCkgLT5cbiAgICAgIHJ2YWwgPSBwaXhlbFswXSA+PiByc2hpZnRcbiAgICAgIGd2YWwgPSBwaXhlbFsxXSA+PiByc2hpZnRcbiAgICAgIGJ2YWwgPSBwaXhlbFsyXSA+PiByc2hpZnRcbiAgICAgIGlmIHJ2YWwgPCBybWluXG4gICAgICAgIHJtaW4gPSBydmFsXG4gICAgICBlbHNlIGlmIHJ2YWwgPiBybWF4XG4gICAgICAgIHJtYXggPSBydmFsXG4gICAgICBpZiBndmFsIDwgZ21pblxuICAgICAgICBnbWluID0gZ3ZhbFxuICAgICAgZWxzZSBpZiBndmFsID4gZ21heFxuICAgICAgICBnbWF4ID0gZ3ZhbFxuICAgICAgaWYgYnZhbCA8IGJtaW5cbiAgICAgICAgYm1pbiA9IGJ2YWxcbiAgICAgIGVsc2UgaWYgYnZhbCA+IGJtYXhcbiAgICAgICAgYm1heCA9IGJ2YWxcbiAgICAgIHJldHVyblxuICAgIG5ldyBWQm94KHJtaW4sIHJtYXgsIGdtaW4sIGdtYXgsIGJtaW4sIGJtYXgsIGhpc3RvKVxuXG4gIG1lZGlhbkN1dEFwcGx5ID0gKGhpc3RvLCB2Ym94KSAtPlxuXG4gICAgZG9DdXQgPSAoY29sb3IpIC0+XG4gICAgICBkaW0xID0gY29sb3IgKyAnMSdcbiAgICAgIGRpbTIgPSBjb2xvciArICcyJ1xuICAgICAgbGVmdCA9IHVuZGVmaW5lZFxuICAgICAgcmlnaHQgPSB1bmRlZmluZWRcbiAgICAgIHZib3gxID0gdW5kZWZpbmVkXG4gICAgICB2Ym94MiA9IHVuZGVmaW5lZFxuICAgICAgZDIgPSB1bmRlZmluZWRcbiAgICAgIGNvdW50MiA9IDBcbiAgICAgIGBpID0gdmJveFtkaW0xXWBcbiAgICAgIHdoaWxlIGkgPD0gdmJveFtkaW0yXVxuICAgICAgICBpZiBwYXJ0aWFsc3VtW2ldID4gdG90YWwgLyAyXG4gICAgICAgICAgdmJveDEgPSB2Ym94LmNvcHkoKVxuICAgICAgICAgIHZib3gyID0gdmJveC5jb3B5KClcbiAgICAgICAgICBsZWZ0ID0gaSAtICh2Ym94W2RpbTFdKVxuICAgICAgICAgIHJpZ2h0ID0gdmJveFtkaW0yXSAtIGlcbiAgICAgICAgICBpZiBsZWZ0IDw9IHJpZ2h0XG4gICAgICAgICAgICBkMiA9IE1hdGgubWluKHZib3hbZGltMl0gLSAxLCB+IH4oaSArIHJpZ2h0IC8gMikpXG4gICAgICAgICAgZWxzZVxuICAgICAgICAgICAgZDIgPSBNYXRoLm1heCh2Ym94W2RpbTFdLCB+IH4oaSAtIDEgLSAobGVmdCAvIDIpKSlcbiAgICAgICAgICAjIGF2b2lkIDAtY291bnQgYm94ZXNcbiAgICAgICAgICB3aGlsZSAhcGFydGlhbHN1bVtkMl1cbiAgICAgICAgICAgIGQyKytcbiAgICAgICAgICBjb3VudDIgPSBsb29rYWhlYWRzdW1bZDJdXG4gICAgICAgICAgd2hpbGUgIWNvdW50MiBhbmQgcGFydGlhbHN1bVtkMiAtIDFdXG4gICAgICAgICAgICBjb3VudDIgPSBsb29rYWhlYWRzdW1bLS1kMl1cbiAgICAgICAgICAjIHNldCBkaW1lbnNpb25zXG4gICAgICAgICAgdmJveDFbZGltMl0gPSBkMlxuICAgICAgICAgIHZib3gyW2RpbTFdID0gdmJveDFbZGltMl0gKyAxXG4gICAgICAgICAgIyAgICAgICAgICAgICAgICAgICAgY29uc29sZS5sb2coJ3Zib3ggY291bnRzOicsIHZib3guY291bnQoKSwgdmJveDEuY291bnQoKSwgdmJveDIuY291bnQoKSk7XG4gICAgICAgICAgcmV0dXJuIFtcbiAgICAgICAgICAgIHZib3gxXG4gICAgICAgICAgICB2Ym94MlxuICAgICAgICAgIF1cbiAgICAgICAgaSsrXG4gICAgICByZXR1cm5cblxuICAgIGlmICF2Ym94LmNvdW50KClcbiAgICAgIHJldHVyblxuICAgIHJ3ID0gdmJveC5yMiAtICh2Ym94LnIxKSArIDFcbiAgICBndyA9IHZib3guZzIgLSAodmJveC5nMSkgKyAxXG4gICAgYncgPSB2Ym94LmIyIC0gKHZib3guYjEpICsgMVxuICAgIG1heHcgPSBwdi5tYXgoW1xuICAgICAgcndcbiAgICAgIGd3XG4gICAgICBid1xuICAgIF0pXG4gICAgIyBvbmx5IG9uZSBwaXhlbCwgbm8gc3BsaXRcbiAgICBpZiBgdmJveC5jb3VudCgpID09IDFgXG4gICAgICByZXR1cm4gWyB2Ym94LmNvcHkoKSBdXG5cbiAgICAjIyMgRmluZCB0aGUgcGFydGlhbCBzdW0gYXJyYXlzIGFsb25nIHRoZSBzZWxlY3RlZCBheGlzLiAjIyNcblxuICAgIHRvdGFsID0gMFxuICAgIHBhcnRpYWxzdW0gPSBbXVxuICAgIGxvb2thaGVhZHN1bSA9IFtdXG4gICAgaSA9IHVuZGVmaW5lZFxuICAgIGogPSB1bmRlZmluZWRcbiAgICBrID0gdW5kZWZpbmVkXG4gICAgc3VtID0gdW5kZWZpbmVkXG4gICAgaW5kZXggPSB1bmRlZmluZWRcbiAgICBpZiBgbWF4dyA9PSByd2BcbiAgICAgIGkgPSB2Ym94LnIxXG4gICAgICB3aGlsZSBpIDw9IHZib3gucjJcbiAgICAgICAgc3VtID0gMFxuICAgICAgICBqID0gdmJveC5nMVxuICAgICAgICB3aGlsZSBqIDw9IHZib3guZzJcbiAgICAgICAgICBrID0gdmJveC5iMVxuICAgICAgICAgIHdoaWxlIGsgPD0gdmJveC5iMlxuICAgICAgICAgICAgaW5kZXggPSBnZXRDb2xvckluZGV4KGksIGosIGspXG4gICAgICAgICAgICBzdW0gKz0gaGlzdG9baW5kZXhdIG9yIDBcbiAgICAgICAgICAgIGsrK1xuICAgICAgICAgIGorK1xuICAgICAgICB0b3RhbCArPSBzdW1cbiAgICAgICAgcGFydGlhbHN1bVtpXSA9IHRvdGFsXG4gICAgICAgIGkrK1xuICAgIGVsc2UgaWYgYG1heHcgPT0gZ3dgXG4gICAgICBpID0gdmJveC5nMVxuICAgICAgd2hpbGUgaSA8PSB2Ym94LmcyXG4gICAgICAgIHN1bSA9IDBcbiAgICAgICAgaiA9IHZib3gucjFcbiAgICAgICAgd2hpbGUgaiA8PSB2Ym94LnIyXG4gICAgICAgICAgayA9IHZib3guYjFcbiAgICAgICAgICB3aGlsZSBrIDw9IHZib3guYjJcbiAgICAgICAgICAgIGluZGV4ID0gZ2V0Q29sb3JJbmRleChqLCBpLCBrKVxuICAgICAgICAgICAgc3VtICs9IGhpc3RvW2luZGV4XSBvciAwXG4gICAgICAgICAgICBrKytcbiAgICAgICAgICBqKytcbiAgICAgICAgdG90YWwgKz0gc3VtXG4gICAgICAgIHBhcnRpYWxzdW1baV0gPSB0b3RhbFxuICAgICAgICBpKytcbiAgICBlbHNlXG5cbiAgICAgICMjIyBtYXh3ID09IGJ3ICMjI1xuXG4gICAgICBpID0gdmJveC5iMVxuICAgICAgd2hpbGUgaSA8PSB2Ym94LmIyXG4gICAgICAgIHN1bSA9IDBcbiAgICAgICAgaiA9IHZib3gucjFcbiAgICAgICAgd2hpbGUgaiA8PSB2Ym94LnIyXG4gICAgICAgICAgayA9IHZib3guZzFcbiAgICAgICAgICB3aGlsZSBrIDw9IHZib3guZzJcbiAgICAgICAgICAgIGluZGV4ID0gZ2V0Q29sb3JJbmRleChqLCBrLCBpKVxuICAgICAgICAgICAgc3VtICs9IGhpc3RvW2luZGV4XSBvciAwXG4gICAgICAgICAgICBrKytcbiAgICAgICAgICBqKytcbiAgICAgICAgdG90YWwgKz0gc3VtXG4gICAgICAgIHBhcnRpYWxzdW1baV0gPSB0b3RhbFxuICAgICAgICBpKytcbiAgICBwYXJ0aWFsc3VtLmZvckVhY2ggKGQsIGkpIC0+XG4gICAgICBsb29rYWhlYWRzdW1baV0gPSB0b3RhbCAtIGRcbiAgICAgIHJldHVyblxuICAgICMgZGV0ZXJtaW5lIHRoZSBjdXQgcGxhbmVzXG4gICAgaWYgYG1heHcgPT0gcndgIHRoZW4gZG9DdXQoJ3InKSBlbHNlIGlmIGBtYXh3ID09IGd3YCB0aGVuIGRvQ3V0KCdnJykgZWxzZSBkb0N1dCgnYicpXG5cbiAgcXVhbnRpemUgPSAocGl4ZWxzLCBtYXhjb2xvcnMpIC0+XG4gICAgayA9IDBcbiAgICAjIHNob3J0LWNpcmN1aXRcbiAgICAjIGlubmVyIGZ1bmN0aW9uIHRvIGRvIHRoZSBpdGVyYXRpb25cblxuICAgIGl0ZXIgPSAobGgsIHRhcmdldCkgLT5cbiAgICAgIG5jb2xvcnMgPSBsaC5zaXplKClcbiAgICAgIG5pdGVycyA9IDBcbiAgICAgIHZib3ggPSB1bmRlZmluZWRcbiAgICAgIHdoaWxlIG5pdGVycyA8IG1heEl0ZXJhdGlvbnNcbiAgICAgICAgaWYgbmNvbG9ycyA+PSB0YXJnZXRcbiAgICAgICAgICByZXR1cm5cbiAgICAgICAgaWYgbml0ZXJzKysgPiBtYXhJdGVyYXRpb25zXG4gICAgICAgICAgIyAgICAgICAgICAgICAgICAgICAgY29uc29sZS5sb2coXCJpbmZpbml0ZSBsb29wOyBwZXJoYXBzIHRvbyBmZXcgcGl4ZWxzIVwiKTtcbiAgICAgICAgICByZXR1cm5cbiAgICAgICAgdmJveCA9IGxoLnBvcCgpXG4gICAgICAgIGlmICF2Ym94LmNvdW50KClcblxuICAgICAgICAgICMjIyBqdXN0IHB1dCBpdCBiYWNrICMjI1xuXG4gICAgICAgICAgbGgucHVzaCB2Ym94XG4gICAgICAgICAgbml0ZXJzKytcbiAgICAgICAgICBrKytcbiAgICAgICAgICBjb250aW51ZVxuICAgICAgICAjIGRvIHRoZSBjdXRcbiAgICAgICAgdmJveGVzID0gbWVkaWFuQ3V0QXBwbHkoaGlzdG8sIHZib3gpXG4gICAgICAgIHZib3gxID0gdmJveGVzWzBdXG4gICAgICAgIHZib3gyID0gdmJveGVzWzFdXG4gICAgICAgIGlmICF2Ym94MVxuICAgICAgICAgICMgICAgICAgICAgICAgICAgICAgIGNvbnNvbGUubG9nKFwidmJveDEgbm90IGRlZmluZWQ7IHNob3VsZG4ndCBoYXBwZW4hXCIpO1xuICAgICAgICAgIHJldHVyblxuICAgICAgICBsaC5wdXNoIHZib3gxXG4gICAgICAgIGlmIHZib3gyXG5cbiAgICAgICAgICAjIyMgdmJveDIgY2FuIGJlIG51bGwgIyMjXG5cbiAgICAgICAgICBsaC5wdXNoIHZib3gyXG4gICAgICAgICAgbmNvbG9ycysrXG4gICAgICByZXR1cm5cblxuICAgIGlmICFwaXhlbHMubGVuZ3RoIG9yIG1heGNvbG9ycyA8IDIgb3IgbWF4Y29sb3JzID4gMjU2XG4gICAgICAjICAgICAgICAgICAgY29uc29sZS5sb2coJ3dyb25nIG51bWJlciBvZiBtYXhjb2xvcnMnKTtcbiAgICAgIHJldHVybiBmYWxzZVxuICAgICMgWFhYOiBjaGVjayBjb2xvciBjb250ZW50IGFuZCBjb252ZXJ0IHRvIGdyYXlzY2FsZSBpZiBpbnN1ZmZpY2llbnRcbiAgICBoaXN0byA9IGdldEhpc3RvKHBpeGVscylcbiAgICBoaXN0b3NpemUgPSAxIDw8IDMgKiBzaWdiaXRzXG4gICAgIyBjaGVjayB0aGF0IHdlIGFyZW4ndCBiZWxvdyBtYXhjb2xvcnMgYWxyZWFkeVxuICAgIG5Db2xvcnMgPSAwXG4gICAgaGlzdG8uZm9yRWFjaCAtPlxuICAgICAgbkNvbG9ycysrXG4gICAgICByZXR1cm5cbiAgICBpZiBuQ29sb3JzIDw9IG1heGNvbG9yc1xuICAgICAgIyBYWFg6IGdlbmVyYXRlIHRoZSBuZXcgY29sb3JzIGZyb20gdGhlIGhpc3RvIGFuZCByZXR1cm5cbiAgICBlbHNlXG4gICAgIyBnZXQgdGhlIGJlZ2lubmluZyB2Ym94IGZyb20gdGhlIGNvbG9yc1xuICAgIHZib3ggPSB2Ym94RnJvbVBpeGVscyhwaXhlbHMsIGhpc3RvKVxuICAgIHBxID0gbmV3IFBRdWV1ZSgoYSwgYikgLT5cbiAgICAgIHB2Lm5hdHVyYWxPcmRlciBhLmNvdW50KCksIGIuY291bnQoKVxuKVxuICAgIHBxLnB1c2ggdmJveFxuICAgICMgZmlyc3Qgc2V0IG9mIGNvbG9ycywgc29ydGVkIGJ5IHBvcHVsYXRpb25cbiAgICBpdGVyIHBxLCBmcmFjdEJ5UG9wdWxhdGlvbnMgKiBtYXhjb2xvcnNcbiAgICAjIFJlLXNvcnQgYnkgdGhlIHByb2R1Y3Qgb2YgcGl4ZWwgb2NjdXBhbmN5IHRpbWVzIHRoZSBzaXplIGluIGNvbG9yIHNwYWNlLlxuICAgIHBxMiA9IG5ldyBQUXVldWUoKGEsIGIpIC0+XG4gICAgICBwdi5uYXR1cmFsT3JkZXIgYS5jb3VudCgpICogYS52b2x1bWUoKSwgYi5jb3VudCgpICogYi52b2x1bWUoKVxuKVxuICAgIHdoaWxlIHBxLnNpemUoKVxuICAgICAgcHEyLnB1c2ggcHEucG9wKClcbiAgICAjIG5leHQgc2V0IC0gZ2VuZXJhdGUgdGhlIG1lZGlhbiBjdXRzIHVzaW5nIHRoZSAobnBpeCAqIHZvbCkgc29ydGluZy5cbiAgICBpdGVyIHBxMiwgbWF4Y29sb3JzXG4gICAgIyBjYWxjdWxhdGUgdGhlIGFjdHVhbCBjb2xvcnNcbiAgICBjbWFwID0gbmV3IENNYXBcbiAgICB3aGlsZSBwcTIuc2l6ZSgpXG4gICAgICBjbWFwLnB1c2ggcHEyLnBvcCgpXG4gICAgY21hcFxuXG4gIFZCb3gucHJvdG90eXBlID1cbiAgICB2b2x1bWU6IChmb3JjZSkgLT5cbiAgICAgIHZib3ggPSB0aGlzXG4gICAgICBpZiAhdmJveC5fdm9sdW1lIG9yIGZvcmNlXG4gICAgICAgIHZib3guX3ZvbHVtZSA9ICh2Ym94LnIyIC0gKHZib3gucjEpICsgMSkgKiAodmJveC5nMiAtICh2Ym94LmcxKSArIDEpICogKHZib3guYjIgLSAodmJveC5iMSkgKyAxKVxuICAgICAgdmJveC5fdm9sdW1lXG4gICAgY291bnQ6IChmb3JjZSkgLT5cbiAgICAgIHZib3ggPSB0aGlzXG4gICAgICBoaXN0byA9IHZib3guaGlzdG9cbiAgICAgIGlmICF2Ym94Ll9jb3VudF9zZXQgb3IgZm9yY2VcbiAgICAgICAgbnBpeCA9IDBcbiAgICAgICAgaSA9IHVuZGVmaW5lZFxuICAgICAgICBqID0gdW5kZWZpbmVkXG4gICAgICAgIGsgPSB1bmRlZmluZWRcbiAgICAgICAgaSA9IHZib3gucjFcbiAgICAgICAgd2hpbGUgaSA8PSB2Ym94LnIyXG4gICAgICAgICAgaiA9IHZib3guZzFcbiAgICAgICAgICB3aGlsZSBqIDw9IHZib3guZzJcbiAgICAgICAgICAgIGsgPSB2Ym94LmIxXG4gICAgICAgICAgICB3aGlsZSBrIDw9IHZib3guYjJcbiAgICAgICAgICAgICAgYGluZGV4ID0gZ2V0Q29sb3JJbmRleChpLCBqLCBrKWBcbiAgICAgICAgICAgICAgbnBpeCArPSBoaXN0b1tpbmRleF0gb3IgMFxuICAgICAgICAgICAgICBrKytcbiAgICAgICAgICAgIGorK1xuICAgICAgICAgIGkrK1xuICAgICAgICB2Ym94Ll9jb3VudCA9IG5waXhcbiAgICAgICAgdmJveC5fY291bnRfc2V0ID0gdHJ1ZVxuICAgICAgdmJveC5fY291bnRcbiAgICBjb3B5OiAtPlxuICAgICAgdmJveCA9IHRoaXNcbiAgICAgIG5ldyBWQm94KHZib3gucjEsIHZib3gucjIsIHZib3guZzEsIHZib3guZzIsIHZib3guYjEsIHZib3guYjIsIHZib3guaGlzdG8pXG4gICAgYXZnOiAoZm9yY2UpIC0+XG4gICAgICB2Ym94ID0gdGhpc1xuICAgICAgaGlzdG8gPSB2Ym94Lmhpc3RvXG4gICAgICBpZiAhdmJveC5fYXZnIG9yIGZvcmNlXG4gICAgICAgIG50b3QgPSAwXG4gICAgICAgIG11bHQgPSAxIDw8IDggLSBzaWdiaXRzXG4gICAgICAgIHJzdW0gPSAwXG4gICAgICAgIGdzdW0gPSAwXG4gICAgICAgIGJzdW0gPSAwXG4gICAgICAgIGh2YWwgPSB1bmRlZmluZWRcbiAgICAgICAgaSA9IHVuZGVmaW5lZFxuICAgICAgICBqID0gdW5kZWZpbmVkXG4gICAgICAgIGsgPSB1bmRlZmluZWRcbiAgICAgICAgaGlzdG9pbmRleCA9IHVuZGVmaW5lZFxuICAgICAgICBpID0gdmJveC5yMVxuICAgICAgICB3aGlsZSBpIDw9IHZib3gucjJcbiAgICAgICAgICBqID0gdmJveC5nMVxuICAgICAgICAgIHdoaWxlIGogPD0gdmJveC5nMlxuICAgICAgICAgICAgayA9IHZib3guYjFcbiAgICAgICAgICAgIHdoaWxlIGsgPD0gdmJveC5iMlxuICAgICAgICAgICAgICBoaXN0b2luZGV4ID0gZ2V0Q29sb3JJbmRleChpLCBqLCBrKVxuICAgICAgICAgICAgICBodmFsID0gaGlzdG9baGlzdG9pbmRleF0gb3IgMFxuICAgICAgICAgICAgICBudG90ICs9IGh2YWxcbiAgICAgICAgICAgICAgcnN1bSArPSBodmFsICogKGkgKyAwLjUpICogbXVsdFxuICAgICAgICAgICAgICBnc3VtICs9IGh2YWwgKiAoaiArIDAuNSkgKiBtdWx0XG4gICAgICAgICAgICAgIGJzdW0gKz0gaHZhbCAqIChrICsgMC41KSAqIG11bHRcbiAgICAgICAgICAgICAgaysrXG4gICAgICAgICAgICBqKytcbiAgICAgICAgICBpKytcbiAgICAgICAgaWYgbnRvdFxuICAgICAgICAgIHZib3guX2F2ZyA9IFtcbiAgICAgICAgICAgIH4gfihyc3VtIC8gbnRvdClcbiAgICAgICAgICAgIH4gfihnc3VtIC8gbnRvdClcbiAgICAgICAgICAgIH4gfihic3VtIC8gbnRvdClcbiAgICAgICAgICBdXG4gICAgICAgIGVsc2VcbiAgICAgICAgICAjICAgICAgICAgICAgICAgICAgICBjb25zb2xlLmxvZygnZW1wdHkgYm94Jyk7XG4gICAgICAgICAgdmJveC5fYXZnID0gW1xuICAgICAgICAgICAgfiB+KG11bHQgKiAodmJveC5yMSArIHZib3gucjIgKyAxKSAvIDIpXG4gICAgICAgICAgICB+IH4obXVsdCAqICh2Ym94LmcxICsgdmJveC5nMiArIDEpIC8gMilcbiAgICAgICAgICAgIH4gfihtdWx0ICogKHZib3guYjEgKyB2Ym94LmIyICsgMSkgLyAyKVxuICAgICAgICAgIF1cbiAgICAgIHZib3guX2F2Z1xuICAgIGNvbnRhaW5zOiAocGl4ZWwpIC0+XG4gICAgICB2Ym94ID0gdGhpc1xuICAgICAgcnZhbCA9IHBpeGVsWzBdID4+IHJzaGlmdFxuICAgICAgYGd2YWwgPSBwaXhlbFsxXSA+PiByc2hpZnRgXG4gICAgICBgYnZhbCA9IHBpeGVsWzJdID4+IHJzaGlmdGBcbiAgICAgIHJ2YWwgPj0gdmJveC5yMSBhbmQgcnZhbCA8PSB2Ym94LnIyIGFuZCBndmFsID49IHZib3guZzEgYW5kIGd2YWwgPD0gdmJveC5nMiBhbmQgYnZhbCA+PSB2Ym94LmIxIGFuZCBidmFsIDw9IHZib3guYjJcbiAgQ01hcC5wcm90b3R5cGUgPVxuICAgIHB1c2g6ICh2Ym94KSAtPlxuICAgICAgQHZib3hlcy5wdXNoXG4gICAgICAgIHZib3g6IHZib3hcbiAgICAgICAgY29sb3I6IHZib3guYXZnKClcbiAgICAgIHJldHVyblxuICAgIHBhbGV0dGU6IC0+XG4gICAgICBAdmJveGVzLm1hcCAodmIpIC0+XG4gICAgICAgIHZiLmNvbG9yXG4gICAgc2l6ZTogLT5cbiAgICAgIEB2Ym94ZXMuc2l6ZSgpXG4gICAgbWFwOiAoY29sb3IpIC0+XG4gICAgICB2Ym94ZXMgPSBAdmJveGVzXG4gICAgICBpID0gMFxuICAgICAgd2hpbGUgaSA8IHZib3hlcy5zaXplKClcbiAgICAgICAgaWYgdmJveGVzLnBlZWsoaSkudmJveC5jb250YWlucyhjb2xvcilcbiAgICAgICAgICByZXR1cm4gdmJveGVzLnBlZWsoaSkuY29sb3JcbiAgICAgICAgaSsrXG4gICAgICBAbmVhcmVzdCBjb2xvclxuICAgIG5lYXJlc3Q6IChjb2xvcikgLT5cbiAgICAgIHZib3hlcyA9IEB2Ym94ZXNcbiAgICAgIGQxID0gdW5kZWZpbmVkXG4gICAgICBkMiA9IHVuZGVmaW5lZFxuICAgICAgcENvbG9yID0gdW5kZWZpbmVkXG4gICAgICBpID0gMFxuICAgICAgd2hpbGUgaSA8IHZib3hlcy5zaXplKClcbiAgICAgICAgZDIgPSBNYXRoLnNxcnQoKGNvbG9yWzBdIC0gKHZib3hlcy5wZWVrKGkpLmNvbG9yWzBdKSkgKiogMiArIChjb2xvclsxXSAtICh2Ym94ZXMucGVlayhpKS5jb2xvclsxXSkpICoqIDIgKyAoY29sb3JbMl0gLSAodmJveGVzLnBlZWsoaSkuY29sb3JbMl0pKSAqKiAyKVxuICAgICAgICBpZiBkMiA8IGQxIG9yIGBkMSA9PSB1bmRlZmluZWRgXG4gICAgICAgICAgZDEgPSBkMlxuICAgICAgICAgIHBDb2xvciA9IHZib3hlcy5wZWVrKGkpLmNvbG9yXG4gICAgICAgIGkrK1xuICAgICAgcENvbG9yXG4gICAgZm9yY2VidzogLT5cbiAgICAgICMgWFhYOiB3b24ndCAgd29yayB5ZXRcbiAgICAgIHZib3hlcyA9IEB2Ym94ZXNcbiAgICAgIHZib3hlcy5zb3J0IChhLCBiKSAtPlxuICAgICAgICBwdi5uYXR1cmFsT3JkZXIgcHYuc3VtKGEuY29sb3IpLCBwdi5zdW0oYi5jb2xvcilcbiAgICAgICMgZm9yY2UgZGFya2VzdCBjb2xvciB0byBibGFjayBpZiBldmVyeXRoaW5nIDwgNVxuICAgICAgbG93ZXN0ID0gdmJveGVzWzBdLmNvbG9yXG4gICAgICBpZiBsb3dlc3RbMF0gPCA1IGFuZCBsb3dlc3RbMV0gPCA1IGFuZCBsb3dlc3RbMl0gPCA1XG4gICAgICAgIHZib3hlc1swXS5jb2xvciA9IFtcbiAgICAgICAgICAwXG4gICAgICAgICAgMFxuICAgICAgICAgIDBcbiAgICAgICAgXVxuICAgICAgIyBmb3JjZSBsaWdodGVzdCBjb2xvciB0byB3aGl0ZSBpZiBldmVyeXRoaW5nID4gMjUxXG4gICAgICBpZHggPSB2Ym94ZXMubGVuZ3RoIC0gMVxuICAgICAgaGlnaGVzdCA9IHZib3hlc1tpZHhdLmNvbG9yXG4gICAgICBpZiBoaWdoZXN0WzBdID4gMjUxIGFuZCBoaWdoZXN0WzFdID4gMjUxIGFuZCBoaWdoZXN0WzJdID4gMjUxXG4gICAgICAgIHZib3hlc1tpZHhdLmNvbG9yID0gW1xuICAgICAgICAgIDI1NVxuICAgICAgICAgIDI1NVxuICAgICAgICAgIDI1NVxuICAgICAgICBdXG4gICAgICByZXR1cm5cbiAgeyBxdWFudGl6ZTogcXVhbnRpemUgfVxuXG4jIC0tLVxuIyBnZW5lcmF0ZWQgYnkganMyY29mZmVlIDIuMi4wIiwiIyBBZGQgdGhlIGZvbGxvd2luZyBsaW5lIHRvIHlvdXIgcHJvamVjdCBpbiBGcmFtZXIgU3R1ZGlvLiBcbiMgbXlNb2R1bGUgPSByZXF1aXJlIFwibXlNb2R1bGVcIlxuIyBSZWZlcmVuY2UgdGhlIGNvbnRlbnRzIGJ5IG5hbWUsIGxpa2UgbXlNb2R1bGUubXlGdW5jdGlvbigpIG9yIG15TW9kdWxlLm15VmFyXG5cbmV4cG9ydHMubXlWYXIgPSBcIm15VmFyaWFibGVcIlxuXG5leHBvcnRzLm15RnVuY3Rpb24gPSAtPlxuXHRwcmludCBcIm15RnVuY3Rpb24gaXMgcnVubmluZ1wiXG5cbmV4cG9ydHMubXlBcnJheSA9IFsxLCAyLCAzXSJdfQ==
