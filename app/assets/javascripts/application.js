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

var callback = function(list, $b_svg_map, e){
  svg = e.target.getBBox();
  $('<ul />').attr({class: 'menu'}).
    css({
      position: 'absolute',
      top: svg.y + svg.height/1.5 + $b_svg_map.find('svg').position().top,
      left: svg.x + svg.width/1.5 + $b_svg_map.find('svg').position().left
    }).append(list).appendTo($b_svg_map)
  
  $(e.target).addClass("on");
}

$(document).on('click', function(e){
  $('.menu').remove();
  $('*').removeClass("on");
  $target = $(e.target);

  $b_svg_map = $target.closest('.b-svg-map')
  if($b_svg_map.length > 0) {

    if($target.is('rect, circle, ellipse, polyline, polygon, path')) {

      var current_uri = new URI(window.location.pathname)
      //var map_id = uri.segment(1)

      var map_id = $b_svg_map.data('map-id');
      var list = "";

      $.get( "/areas/find__id__by__map_id__and__ref", { map_id: map_id, ref: $target.closest('g').attr('id') } ).done(function(data){
        var params = {
          previous_url: encodeURI(current_uri)
        };

        if(data != null) {
          list = '<li><a href="/areas/' + data.id + '?' + $.param(params) + '">Торговая площадь: ' + data.title + '</a></li>';
          $.get('/areas/' + data.id + '/today_renter').done(function(data){
            if(data != null) {
              list = list + '<li><a href="/renters/'+data.id + '?' + $.param(params) + '">Арендатор: '+data.title+'</a></li>';
            }
            callback(list, $b_svg_map, e);
          })
        } else {
          params = $.extend(params,{
            map_id: map_id,
            ref: $target.closest('g').attr('id'),
          });
          list = '<li><a href="/areas/new?' + $.param(params) + '">Новая площадь</a></li>';
          callback(list, $b_svg_map, e);
        }
      });
    }
  }
})

$(document).on("turbolinks:load", function() {
  $('[data-toggle="tooltip"]').tooltip()
})
