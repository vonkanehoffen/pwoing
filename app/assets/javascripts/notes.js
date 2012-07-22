
// Global JS -------------------------------------------------------------------

var xhr;

$(document).ready(function(){
    
    // Spider URLs for Content -------------------------------------------------
    
    var note_link = $('input#note_link');
    var note_title = $('input#note_title');

    // Add transport to URL as it's typed
    
    note_link.keyup(function(){
        var url = $(this).val();
        if( is_url(url) ) {
            if( !has_transport(url) ) {
                $(this).val('http://'+url);
                url = $(this).val();
            }
        }   
    })
    note_link.change(function(){
        var url = note_link.val();
        console.log("here");
        if (is_url(url) && has_transport(url)) {
            get_url_meta(url);
        }
    })
    
    function get_url_meta(url) {
        note_title.addClass('loading');
        if(xhr) { xhr.abort(); }
        xhr = $.ajax({
            url: '/get_url_meta/',
            dataType: 'json',
            type: 'POST',
            data: { url: url },
            success: function(data) {
                console.log(data);
                note_title.val(data.title);
                note_title.removeClass('loading');
            }
        })
    }
    
    // Search form Autocomplete ------------------------------------------------
    // TODO: Works but the autofill suggestions still show -
    // this doesn't happen with latest unforked typeahead
    var ac_data_src = $('input#search').data('autocomplete-source');
    $('input#search').typeahead({
        source: function (typeahead, query) {
            return $.get(ac_data_src, { query: query }, function (data) {
                return typeahead.process(data);
            });
        }
    });
})

// Helpers ---------------------------------------------------------------------

function is_url(url) {
    if(url.match(/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/)) {
        return true; } else { return false; }
}

function has_transport(url) {
    if(url.match(/^https?:\/\//)) {
        return true; } else { return false; }
}

