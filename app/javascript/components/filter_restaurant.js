const filterRating = () => {
  const ratingLabels = document.querySelectorAll('.rating-form label')
  ratingLabels.forEach((label) => {
    label.addEventListener('click', (event) => {
      const ratingArray = Array.from(ratingLabels)
      const ratingIndex = ratingArray.indexOf(event.currentTarget);
      ratingArray.forEach((rating) => {
        if (rating) {
          rating.classList.remove("active");
        }
        if (ratingArray.indexOf(rating) < ratingIndex) {
          rating.classList.add("active");
        };
      });
    });
  });
};


const filterPrice = () => {
  const priceLabels = document.querySelectorAll('.price-form label')
  priceLabels.forEach((label) => {

      label.classList.remove("active");

    label.addEventListener('click', (event) => {
      const priceArray = Array.from(priceLabels)
      const priceIndex = priceArray.indexOf(event.currentTarget);
      priceArray.forEach((price) => {
        if (price) {
        price.classList.remove("active");
        }
        if (priceArray.indexOf(price) < priceIndex) {
          price.classList.add("active");
        };
      });
    });
  });
};

export { filterRating, filterPrice };
