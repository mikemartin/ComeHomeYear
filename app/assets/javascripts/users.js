// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
(function($) {

  var input;

  function updateFieldWithLocation(evt) {
    $.when(geolocate()).then(updateField, showError);
    return false;
  };

  function geolocate() {
    var dfd = $.Deferred();

    navigator.geolocation.getCurrentPosition(function(position) {
      var lat = position.coords.latitude, lng = position.coords.longitude;

      return reverseGeocode(lat, lng).then(
        function(location) { dfd.resolve(location); },
        function() { dfd.reject(); }
      ).promise();
    });

    return dfd.promise();
  };

  function reverseGeocode(lat, lng) {
    return $.get('/reverse_geocode', {lat: lat, lng: lng}, function(data) {
      return data;
    });
  };

  function updateField(location) {
    input.val(location);
  };

  function showError() {
    console.log('failed to find location');
  };

  $(function() {
    input = $('#searchLocation');
    var autocomplete = new google.maps.places.Autocomplete(input[0]);
    $(document).delegate('a#getLocation', 'click', updateFieldWithLocation);
  });

}($));