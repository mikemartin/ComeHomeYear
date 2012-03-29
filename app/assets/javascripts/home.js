// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

(function($, mapData) {

  var mapArea, map, markers, bounds;

  var mapOptions = {
    zoom: 2,
    maxZoom: 5,
    center: new google.maps.LatLng(-34.397, 150.644),
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

  $(function() {
    mapArea = $('#map');

    if (mapArea.length) {
      initializeMap(mapArea);
    }
  });

  function initializeMap(el) {
    map = new google.maps.Map(mapArea[0], mapOptions);
    if (mapData) { loadMarkers(); }
    if (!bounds.isEmpty()) { map.fitBounds(bounds); }
  };

  function loadMarkers() {
    var marker;

    markers = [];
    bounds = new google.maps.LatLngBounds;

    for (var i=0, l=mapData.length ; i < l ; i++) {
      marker = loadMarker(mapData[i]);
      marker.setMap(map);
      bounds.extend(marker.getPosition());
      markers.push(marker);
    }
  };

  function loadMarker(data) {
    var latlng = new google.maps.LatLng(data.coords[0], data.coords[1]);

    var marker = new google.maps.Marker({
      position: latlng,
      title: data.full_name
    });

    return marker;
  };

}($, window.mapData));
