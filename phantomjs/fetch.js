var url = 'http://misc.tokyoenvious.net/holidays/holidays.html';

if (phantom.args[0]) {
  url += '#' + phantom.args[0];
}

var page = require('webpage').create();
page.open(url, function (status) {
  if (status !== 'success') {
    console.error('GET ' + url + ' faield: ' + status);
  } else {
    var headline = page.evaluate(function () {
      return document.querySelector('marquee, #content p').textContent;
    });

    console.log(headline);
  }

  phantom.exit();
});
