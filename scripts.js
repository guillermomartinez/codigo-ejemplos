// Get all videos from playlist
document.querySelectorAll('.ytd-playlist-panel-renderer #wc-endpoint').forEach(function(element){
    var href = element.getAttribute('href');
    // console.log(href);
    if (href) {
        var url_base = 'https://www.youtube.com';
        var url_string = url_base+href;
        // console.log(url_string);
        var url = new URL(url_string);
        var id = url.searchParams.get("v");
        // console.log(id);
        if(id){        
            url_base+'/watch?v='+id;
            console.log(url_base+'/watch?v='+id);
        }
    }
})
