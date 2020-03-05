import GMaps from 'gmaps/gmaps.js';

const initMap = () => {

  const mapElement = document.getElementById('map');
  if (mapElement) { // don't try to build a map if there's no div#map to inject in
    const map = new GMaps({ el: '#map', lat: 0, lng: 0, disableDefaultUI: true });
    const markers = JSON.parse(mapElement.dataset.markers);
    map.addMarkers(markers);
    if (markers.length === 0) {
      map.setZoom(2);
    } else if (markers.length === 1) {
      map.setCenter(markers[0].lat, markers[0].lng);
      map.setZoom(14);
    } else {
      map.fitLatLngBounds(markers);
    }
    const meetpoint = document.getElementById('meetpoint')
    if (meetpoint) {
      meetpoint.addEventListener('click', (event) => {
        map.setZoom(16)
      });
    }

    map.markers.forEach((marker) => {
      marker.addListener('click', function() {
        if (marker.details) {
          console.log(marker.details);
          const restaurantName = marker.details.name;
          document.querySelector(".resto-img").src = `http://res.cloudinary.com/dykaopgu0/image/upload/c_fill/${marker.details.photo_key}`
          document.querySelector(".resto-name").innerText = `${restaurantName}`;
          const ratingIcon = '<i class="fas fa-star"></i>'
          const ratingIconMissing = '<i class="fas fa-star" id="level-missing"></i>'
          const rating = (ratingIcon.repeat(marker.details.rating) + ratingIconMissing.repeat(5 - marker.details.rating));
          document.querySelector(".resto-rating").innerHTML = `${rating}`;
          // let times = marker.details.rating;
          // for(let i=0; i < times; i++){
          //   document.querySelector(".resto-rating").insertAdjacentHTML("beforeend", '<i class="fas fa-star"></i>');
          // }
          // for(let i=0; i < (5 - times); i++){
          //   document.querySelector(".resto-rating").insertAdjacentHTML("beforeend", '<i class="fas fa-star" id="level-missing"></i>');
          // }
          document.querySelector(".resto-short-address").innerText = `${marker.details.short_address}`;
          const sym = "€"
          const pricing = sym.repeat(marker.details.price_level)
          document.querySelector(".card-trip-pricing").innerText = pricing;
        }
      });
    })

    // (marker => marker.getPosition().lat());


  }

}

export { initMap };


