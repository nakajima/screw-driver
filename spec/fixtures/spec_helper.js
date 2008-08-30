$(Screw).ready(function() {
  var results = [ ];

  var report = function() {
    var result = results.shift();
    if (!result) { return; }

    if (result.passed) {
      return $.post(result.url, {
        name: (result.event ? jQuery(result.event.target).find('h2').text() : ''),
        reason: $.print(result.info)
      });
    }

    // ERROR
    if (result.info.line) {
      return $.post('/errored', {
        name: jQuery(result.event.target).find('h2').text(),
        reason: result.info
      });
    }

    // FAILURE
    $.post(result.url, {
      name: jQuery(result.event.target).find('h2').text(),
      reason: result.info
    });
  }

  window.setInterval(report, 50);
  
  var finish = function() {
    if (results.length > 0) { return window.setTimeout(finish, 100); }
    $.post('/after');
    window.setTimeout(function() { $.post('/exit') }, 200);
  }
  
  $('.it').bind('passed', function(e) { results.push({ url: '/passed', passed: true }); });
  $('.it').bind('failed', function(e, reason) { results.push({ url: '/failed', info: reason, event: e }) });
  $(Screw).bind('before', function() { $.post('/before') });
  $(Screw).bind('after', function() { window.setTimeout(finish, 500); });
});