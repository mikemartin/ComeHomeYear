(function() {

  var getCurrentLocation = function() {
    var dfd = $.Deferred();

    navigator.geolocation.getCurrentPosition(function(position) {
      var lat = position.coords.latitude, lng = position.coords.longitude;
      reverseGeocode(lat, lng).then(function(location) {
        dfd.resolve(location);
      });
    });

    return dfd.promise();
  };

  var reverseGeocode = function(lat, lng) {
    return $.get('/reverse_geocode', {lat: lat, lng: lng}, function(data) {
      return data;
    });
  };

  this.ComeHome.geolocation = {
    getCurrentLocation: getCurrentLocation
  };

}).call(this);