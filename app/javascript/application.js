// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails';
import 'controllers';

document.addEventListener('DOMContentLoaded', function () {
  // Function to fade out an element
  function fadeOut(element) {
    element.style.opacity = 1;

    (function fade() {
      if ((element.style.opacity -= 0.1) < 0) {
        element.style.display = 'none';
      } else {
        requestAnimationFrame(fade);
      }
    })();
  }

  // Automatically fade out flash messages after 3 seconds
  const flashMessages = document.querySelectorAll('.flash-messages');
  flashMessages.forEach(function (message) {
    message.style.display = 'block';
    setTimeout(function () {
      fadeOut(message);
    }, 3000);
  });
});







