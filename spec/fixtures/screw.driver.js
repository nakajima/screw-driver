(function($) {
  $(Screw).bind('before', function() {
    $.ajaxQueue.post('/before');
  });
  
  $(Screw).bind('after', function() {
    $.ajaxQueue.post('/after');
    $.ajaxQueue.post('/exit');
  });
  
  $(Screw).bind('loaded', function() {
    $('.it').bind('passed', function(e) {
      $.ajaxQueue.post('/passed');
    });
    
    $('.it').bind('failed', function(e, reason) {
      var specName = $(this).find('h2').text();
      
      // ERROR
      if (reason.fileName || reason.lineNumber || reason.line) {
        return $.ajaxQueue.post('/errored', {
          data: { name: specName, reason: reason }
        });
      }
      
      // FAILURE
      $.ajaxQueue.post('/failed', {
        data: { name: specName, reason: reason }
      });
    });
  });
})(jQuery);