// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
(function() {

  var updateFieldWithLocation = function(el) {
    $.when(ComeHome.geolocation.getCurrentLocation()).then(
      function(location) { el.val(location); },
      function() { console.error('failed to get position'); }
    );
  };

  var trackCoords = function(coords) {
    $('#user_crop_x').val(Math.floor(coords.x * photoRatio));
    $('#user_crop_y').val(Math.floor(coords.y * photoRatio));
    $('#user_crop_w').val(Math.floor(coords.w * photoRatio));
    $('#user_crop_h').val(Math.floor(coords.h * photoRatio));
  };

  $(function() {
    var input = $('#searchLocation');
    
    if (input.length) {
      new google.maps.places.Autocomplete(input[0]);

      $(document).delegate('a#getLocation', 'click', function() {
        updateFieldWithLocation(input);
      });
    }

    var canvas = $('#canvas img');

    if (canvas.length) {
      canvas.Jcrop({
        aspectRatio: 1,
        allowSelect: true,
        allowMove: true,
        allowResize: true,
        minSize: [320, 320],
        maxSize: [320, 320],
        setSelect: [0, 0, 320, 320],
        onChange: trackCoords,
        onSelect: trackCoords
      });
    }
  });

}).call(this);