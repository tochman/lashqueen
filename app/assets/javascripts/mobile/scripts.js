$(document).ready(function(){

	jQuery.uaMatch = function( ua ) {
	ua = ua.toLowerCase();

	var match = /(chrome)[ \/]([\w.]+)/.exec( ua ) ||
	    /(webkit)[ \/]([\w.]+)/.exec( ua ) ||
	    /(opera)(?:.*version|)[ \/]([\w.]+)/.exec( ua ) ||
	    /(msie) ([\w.]+)/.exec( ua ) ||
	    ua.indexOf("compatible") < 0 && /(mozilla)(?:.*? rv:([\w.]+)|)/.exec( ua ) ||
	    [];

	return {
	  browser: match[ 1 ] || "",
	  version: match[ 2 ] || "0"
	};
	};

	if ( !jQuery.browser ) {
	matched = jQuery.uaMatch( navigator.userAgent );
	browser = {};

	if ( matched.browser ) {
	  browser[ matched.browser ] = true;
	  browser.version = matched.version;
	}

	if ( browser.chrome ) {
	  browser.webkit = true;
	} else if ( browser.webkit ) {
	  browser.safari = true;
	}

	jQuery.browser = browser;
	}

	$.each($.browser, function(k, v){
	if(v===true) $('html').addClass(k);
	});

    $( function() {
        $( "#popupBasic" ).enhanceWithin().popup();
    });

});

$( document ).on( "pagecreate", "#page", function() {
    $( document ).on( "swipeleft swiperight", "#page", function( e ) {
        // We check if there is no open panel on the page because otherwise
        // a swipe to close the left panel would also open the right panel (and v.v.).
        // We do this by checking the data that the framework stores on the page element (panel: open).
        if ( $( ".ui-page-active" ).jqmData( "panel" ) !== "open" ) {
            if ( e.type === "swipeleft" ) {
                $( "#nav-panel" ).panel( "open" );
            } else if ( e.type === "swiperight" ) {
                $( "#nav-panel" ).panel( "open" );
            }
        }
    });
});