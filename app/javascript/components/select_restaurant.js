const selectRestaurant = () => {
  const select = document.querySelectorAll('.restaurant-select')
  if (select) {
    select.forEach((restaurant) => {
    restaurant.addEventListener('click', (event) => {
      if (restaurant.classList.contains("active"))
          restaurant.classList.remove("active");
        else
          restaurant.classList.add("active");
          $.ajax({type: "POST", url: "/selected_restaurants", data: {restaurant: restaurant.dataset.selectedRestaurant, event: restaurant.dataset.selectedEvent }})
          });
    });
  };
};

export { selectRestaurant };
