// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

import "bootstrap";
import { initMap } from '../components/init_map.js';
import { changeAvatarWhenParticipant } from '../components/create_participant.js';
import { filterRating } from '../components/filter_restaurant';
import { filterPrice} from '../components/filter_restaurant';
import flatpickr from "flatpickr"
import "flatpickr/dist/themes/airbnb.css"
import { flatPicker } from "../plugins/flatpickr";
import { initAutocomplete } from "../plugins/init_autocomplete";
import { getUserLocation } from "../components/get_geolocation";
import { addLoader } from "../components/loader";
import { selectRestaurant } from "../components/select_restaurant";

document.addEventListener('turbolinks:load', () => {
  filterRating();
  filterPrice();
  initMap();
  changeAvatarWhenParticipant();
  flatPicker();
  initAutocomplete();
  getUserLocation();
  if (document.getElementById('loader')) {
  	addLoader();
  }
  selectRestaurant();
});







