const getUserLocation = () => {
  const userPosition = document.getElementById('my-position');
  if (userPosition) {
    userPosition.addEventListener("click", (event) => {
      event.preventDefault();
      navigator.geolocation.getCurrentPosition((data) => {
        console.log(data);
        const latitude = document.getElementById('address_latitude');
        latitude.value = data.coords.latitude;
        const longitude = document.getElementById('address_longitude');
        longitude.value = data.coords.longitude;
        const geolocationForm = document.getElementById("geolocation-form");
        geolocationForm.submit();
      });
    });
  };
};

export { getUserLocation };
