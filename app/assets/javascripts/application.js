//= require jquery
//= require jquery_ujs
//= require turbolinks
//
//= require tether/dist/js/tether
//
//= require bootstrap/js/dist/util
//= require bootstrap/js/dist/alert
//= require bootstrap/js/dist/button
//= require bootstrap/js/dist/carousel
//= require bootstrap/js/dist/collapse
//= require bootstrap/js/dist/dropdown
//= require bootstrap/js/dist/modal
//= require bootstrap/js/dist/scrollspy
//= require bootstrap/js/dist/tab
//= require bootstrap/js/dist/tooltip
//= require bootstrap/js/dist/popover
//
//= require URI.js/src/URI.js

$(document).on('click', function(e){
  $('#menu').remove();
  $('*').removeClass("on");
  $target = $(e.target);

  if($target.closest('.b-svg-map g').length > 0) {

    if($target.is('rect, circle, ellipse, polyline, polygon, path')) {

      var uri = new URI(window.location)
      var map_id = uri.segment(1)
      var list = "";
      $.get( "/areas/find__id__by__map_id__and__ref", { map_id: map_id, ref: $target.closest('g').attr('id') } ).done(function(data){
        if(data != null) {
          list = '<li><a href="/areas/' + data.id + '">' + data.title + '</a></li>';
        } else {
          var params = $.param({map_id: map_id, ref: $target.closest('g').attr('id')});
          list = '<li><a href="/areas/new?' + params + '">Новая площадь</a></li>';
        }

        svg = e.target.getBBox();
        $('<ul />').attr({id: 'menu'}).
          css({
            position: 'absolute',
            top: svg.y + svg.height/2,
            left: svg.x + svg.width/2
          }).append(list).appendTo('.b-svg-map')
        
        $(e.target).addClass("on");
      });
    }
  }
})

$(document).on("turbolinks:load", function() {
  $('[data-toggle="tooltip"]').tooltip()
})
