(function(b) {
    function c(a, b) {
        this.options = b;
        this.root = a
    }
    c.prototype.init = function() {
        var wt = 646;
        var ht = 473;     
        
        var a = "",
            d = "",
            c = "auto",
            g = "",
            h = "",
            e, f, a = a + ('<img src="' + this.root.find("img").first().attr("src") + '" class="hsmap-image img-responsive">');
        this.root.find(".hs-spot-object").each(function() {
            "rect" == b(this).data("type") ? (d = "hs-rect", e = b(this).data("x"), f = b(this).data("y")) : (d = "hs-spot", e = b(this).data("x") - b(this).data("width") / 2, f = b(this).data("y") - b(this).data("height") / 2);
            g = "visible" == b(this).data("visible") ? "visible" : "";
            c = !1 == b(this).data("tooltip-auto-width") ?
                b(this).data("tooltip-width") + "px" : "auto";
            h = b(this).data("popup-position");
            a += '<div data-x="'+ b(this).data("x") +'" data-y="'+ b(this).data("y") +'" class="' + d + " " + g + " " + h + ' hs-spot-object" style="left: ' + e + "px; top: " + f + "px; width: " + b(this).data("width") + "px; height: " + b(this).data("height") + 'px;">';
            a += '\t<div class="hs-spot-shape"></div><div class="hs-spot-shape-inner"></div><div class="hs-spot-shape-inner-two"></div>';
            a += '\t<div class="hs-spot-tooltip-outer">';
            a += '\t\t<div class="hs-tooltip-buffer"></div>';
            a += '\t\t<div class="hs-tooltip-wrap" style="width: ' +
                c + ';">';
            a += '\t\t\t<div class="hs-tooltip">';
            a += b(this).html();
            a += "\t\t\t</div>";
            a += "\t\t</div>";
            a += "\t</div>";
            a += "</div>"
        });

        var _this = this;
        function reload(_this){
            var imagen = _this.root.find("img").first();
            var imagenx = imagen.width();
            var imageny = imagen.height();            
            // console.log('width imagen: ' + imagenx);            
            var wboton = 15;
            if(imagenx<500) wboton = 20;
            if(imagenx<400) wboton = 30;
                _this.root.find(".hs-spot-object").each(function(index,element) {
                    var xpr = ( $(this).data("x") - wboton ) / wt;
                    var ypr = ( $(this).data("y") - wboton ) / ht;
                    var xtemp = imagenx * xpr;
                    var ytemp = imageny * ypr;
                    b(this).css({left:xtemp,top:ytemp});
                    // console.log('xorig: ' + b(this).data("x") + ' | xtemp: ' + xtemp);

                });
        }
        
        jQuery( window ).resize(function() {
            reload(_this);
        });
    
        this.root.html(a);
        this.root.removeClass("hs-loading");
        this.root.addClass(this.options.show_on);
        this.root.addClass(this.options.color_scheme);
        this.options.transparent_spots && this.root.addClass("transparent-spots");
        if ("click" == this.options.show_on) b(".hs-spot-object").on("click", function() {
            b(this).toggleClass("visible-tooltip")
        });
        "mouseover" == this.options.show_on && (b(".hs-spot-object").on("mouseover",
            function() {
                b(this).addClass("visible-tooltip")
            }), b(".hs-spot-object").on("mouseout", function() {
            b(this).removeClass("visible-tooltip")
        }));
        this.root.addClass("hs-loaded")
        reload(_this);

    };
    b.fn.hotspot = function(a) {
        O = b.extend(!0, {
            show_on: "mouseover",
            transparent_spots: !0,
            color_scheme: "red"
        }, a);
        return this.each(function() {
            (new c(b(this), O)).init()
        })
    }
})(jQuery);
