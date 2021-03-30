$(document).ready(function() {
    setTimeout(function() {
        $('body').addClass('loaded');
    }, 3000);
    setTimeout(function() {
      document.getElementById('loader-wrapper').remove();
    }, 4000);
});
