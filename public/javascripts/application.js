// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var delay = (function() {
  var timer = 0;
  return function(callback, ms){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  };
})();


  $(function () {
    // Sorting and pagination links.
    $('#products_list th a, #products_list .pagination a').live('click',
      function () {
        $.getScript(this.href);
        if (history && history.pushState) { history.pushState(null, document.title, this.href); }
        return false;
      }
    );


  // Search form.
  $('#products_search input#search').keyup(function () {
    delay(
      function(){
        if (history && history.pushState) {
          history.replaceState(null, document.title, $("#products_search").attr("action") + "?" + $("#products_search").serialize());
        }
        $.get($('#products_search').attr('action'),
          $('#products_search').serialize(), null, 'script');
        return false;
      }, 500);
  });


  $('#products_search').submit(function () {
    $.get(this.action, $(this).serialize(), null, 'script');
    return false;
    });
  });

   $(window).bind("popstate", function() {
      $.getScript(location.href);
    });

