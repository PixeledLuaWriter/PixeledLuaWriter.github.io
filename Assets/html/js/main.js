$(document).ready(function() {
    setTimeout(function() {
        $('body').addClass('loaded');
    }, 12000);
    setTimeout(function() {
      document.getElementById('loader-wrapper').remove();
    }, 13000);
});
