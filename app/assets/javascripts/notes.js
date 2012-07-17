// Spider URLs for Content

$(document).ready(function(){
    $('input#note_link').keyup(function(){
        var url = $(this).val();
        if( is_url(url) ) {
            if( !has_transport(url) ) {
                $(this).val('http://'+url);
                url = $(this).val();
            }
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
