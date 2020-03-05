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
        map.setCenter(markers[0].lat, markers[0].lng);
        if (map.map.zoom === 16) {
          map.setZoom(12)
        } else {
          map.setZoom(16)
        };

      console.log(map.map.zoom)
      });
    }
  }
}

export { initMap };
