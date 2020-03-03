import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('address_full_address');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocomplete };
