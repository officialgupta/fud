$(document).ready(function(){
    $container = $('.recipes-container').masonry({
      itemSelector: 'li',
      transitionDuration: 0
    });
    $container.masonry();
  })
