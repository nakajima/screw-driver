(function($) {
  // $(Screw).bind('before', function() { $.ajaxQueue.post('/before'); });
  $(Screw).bind('after', function() {
    $.ajaxQueue.post('/after', {
      complete: function() { $.ajaxQueue.post('/exit'); }
    });
  });
  
  $(Screw).bind('loaded', function() {
    $('.it').bind('passed', function(e) {
      $.ajaxQueue.post('/passed');
    });
    
    $('.it').bind('failed', function(e, reason) {
      if (reason.fileName || reason.lineNumber) { // ERROR
        return $.ajaxQueue.post('/errored', {
          data: { name: $(this).find('h2').text(), reason: reason }
        });
      }
      
      $.ajaxQueue.post('/failed', { // FAILURE
        data: { name: $(this).find('h2').text(), reason: reason }
      });
    });
  });
})(jQuery);