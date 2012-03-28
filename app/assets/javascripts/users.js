// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// Location field autocomplete using Google Places API
var input = document.getElementById('searchLocation');        
var autocomplete = new google.maps.places.Autocomplete(input); 

// Get current location and populate location field
$("#getLocation").click(initiate_geolocation);  

function initiate_geolocation() {  
  navigator.geolocation.getCurrentPosition(handle_geolocation_query);  
}  

function handle_geolocation_query(position){  
  alert('Lat: ' + position.coords.latitude + ' ' +  
        'Lon: ' + position.coords.longitude);  
}  