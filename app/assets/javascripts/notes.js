// Spider URLs for Content

var xhr;

$(document).ready(function(){
    
    // Add transport to URL as it's typed
    
    $('input#note_link').keyup(function(){
        var url = $(this).val();
        if( is_url(url) ) {
            if( !has_transport(url) ) {
                $(this).val('http://'+url);
                url = $(this).val();
            }
        }
    })
    $('input#note_link').change(function(){
        var url = $('input#note_link').val();
        if (is_url(url) && has_transport(url)) {
            get_url_meta(url);
        }
    })
})

function is_url(url) {
    if(url.match(/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/)) {
        return true; } else { return false; }
}

function has_transport(url) {
    if(url.match(/^https?:\/\//)) {
        return true; } else { return false; }
}

function get_url_meta(url) {    
    if(xhr) { xhr.abort(); }
    xhr = $.ajax({
        url: '/get_url_meta/',
        dataType: 'json',
        type: 'POST',
        data: { url: url },
        success: function(data) {
            console.log(data);
            $('input#note_name').val(data.name);
        }
    })
}