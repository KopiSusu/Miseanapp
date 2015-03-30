//= require jquery
//= require jquery_ujs

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}


resizeIt = function() {
  var str = $('text-area').value;
  var cols = $('text-area').cols;

  var linecount = 0;
  $A(str.split("\n")).each( function(l) {
    linecount += Math.ceil( l.length / cols ); // take into account long lines
  } )
  $('text-area').rows = linecount + 1;
};

Event.observe('text-area', 'keydown', resizeIt ); // you could attach to keyUp, etc if keydown doesn't work
resizeIt();


$(document).ready(function() {
  $('nav a').click(function(event) {
    var id = $(this).attr("href");
    var offset = 70;
    var target = $(id).offset().top - offset;
    $('html, body').animate({
      scrollTop: target
    }, 500);
    event.preventDefault();
  });

});

