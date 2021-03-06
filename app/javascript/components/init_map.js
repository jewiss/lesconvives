import GMaps from 'gmaps/gmaps.js';

const initMap = () => {

  const mapElement = document.getElementById('map');
  if (mapElement) { // don't try to build a map if there's no div#map to inject in
    const markers = JSON.parse(mapElement.dataset.markers);
    const center = markers[0];
    const lat = center? center.lat : 0;
    const lng = center? center.lng : 0;
    const map = new GMaps({ el: '#map', lat: lat, lng: lng, disableDefaultUI: true });
    map.addMarkers(markers);
    map.addMarkers(markers);
    if (markers.length === 0) {
      map.setZoom(2);
    } else if (markers.length === 1) {
      map.setCenter(markers[0].lat, markers[0].lng);
      map.setZoom(14);
    } else if (window.location.hash == "#zoom") {
      map.setCenter(markers[0].lat, markers[0].lng, () => {
        map.setZoom(16)
      });
    } else {
      map.fitLatLngBounds(markers);
    };

    map.markers.forEach((marker) => {
    if (marker.details) {
      marker.addListener('click', function() {
        const element = document.querySelector(".resto-cards");
        element.style.display = "block";
        const restaurantName = marker.details.name;
        document.querySelector(".link-show-resto").href=`/restaurants/${marker.details.id}?event=${marker.details.event}`
        document.querySelector(".resto-img").src = `http://res.cloudinary.com/dykaopgu0/image/upload/c_fill/${marker.details.photo_key}`
        document.querySelector(".resto-name").innerText = `${restaurantName}`;
        const ratingIcon = '<i class="fas fa-star"></i>'
        const ratingIconMissing = '<i class="fas fa-star" id="level-missing"></i>'
        const rating = (ratingIcon.repeat(marker.details.rating) + ratingIconMissing.repeat(5 - marker.details.rating));
        document.querySelector(".resto-rating").innerHTML = ` ${rating}`;
        document.querySelector(".resto-short-address").innerText = `${marker.details.short_address}`;
        const sym = "€"
        const pricing = sym.repeat(marker.details.price_level)
        document.querySelector(".card-trip-pricing").innerText = pricing;

        });
      };
    });

    const meetpoint = document.getElementById('meetpoint')
    if (meetpoint) {
      meetpoint.addEventListener('click', (event) => {
        map.setCenter(markers[0].lat, markers[0].lng);
        if (map.map.zoom === 16) {
          map.setZoom(12)
        } else {
          map.setZoom(16)
        };
      });
    };
  };
};

export { initMap };


