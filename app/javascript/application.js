// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails';
import 'controllers';

document.addEventListener('DOMContentLoaded', function () {
  function fadeOut(element) {
    element.style.transition = 'opacity 0.5s';
    element.style.opacity = 1;

    setTimeout(function () {
      element.style.opacity = 0;
      setTimeout(function () {
        element.style.display = 'none';
      }, 500);
    }, 3000);
  }

  const flashMessages = document.querySelectorAll('.flash');
  flashMessages.forEach(function (message) {
    fadeOut(message);
  });
});
