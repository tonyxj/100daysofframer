// Generated by CoffeeScript 1.10.0
(function() {
  var PepEvents, PepLayer,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  require("./pepjs");

  PepEvents = {
    PointerMove: "pointermove",
    PointerDown: "pointerdown",
    PointerUp: "pointerup",
    PointerOver: "pointerover",
    PointerOut: "pointerout",
    PointerEnter: "pointerenter",
    PointerLeave: "pointerleave",
    PointerCancel: "pointercancel"
  };

  exports.PointerEvents = PepEvents;

  PepLayer = (function(superClass) {
    extend(PepLayer, superClass);

    function PepLayer(options) {
      if (options == null) {
        options = {};
      }
      PepLayer.__super__.constructor.call(this, options);
      this._element.setAttribute("touch-action", "none");
      this._element.onpointermove = null;
      this._element.onpointerdown = null;
      this._element.onpointerup = null;
      this._element.onpointerover = null;
      this._element.onpointerout = null;
      this._element.onpointerenter = null;
      this._element.onpointerleave = null;
      this._element.onpointercancel = null;
    }

    return PepLayer;

  })(Framer.Layer);

  exports.PointerEventLayer = PepLayer;

}).call(this);