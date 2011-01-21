$(document).ready(function(){

  $('#utkonos_search').click(function() {
    element = $(this);
    method = element.attr('data-method');
	  url = element.attr('data-action');
		var data_input = element.attr('data-input');
		if (data_input) {
		  data = data_input + "=" + $("#" + data_input).val();
		} else
  		data = null;

		$.get(url, data, function(data){
  		$.fancybox({
  		'href' : data,
  		'title' : 'Поиск в Утконосе',
  		'type' : 'iframe',
  		'width' : '75%',
  		'height' : '75%',
  		'autoScale' : false,
  		'transitionIn' : 'none',
  		'transitionOut' : 'none'
  		});
		});
		return false;
  });
});

