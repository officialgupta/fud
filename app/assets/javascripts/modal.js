$(document).ready(function(){
$("body").click(function(event){
  var container = $(".modal");
  if (!container.is(event.target) && container.has(event.target).length === 0){
    container.closest(".modal-wrap").addClass("closed");
  }
});

$(".open-modal").click(function(event){
  event.preventDefault();
  event.stopPropagation();
  $($(this).attr('href')).removeClass("closed");
});

});
