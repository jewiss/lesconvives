const filterRating = () => {
  const ratingLabels = document.querySelectorAll('.rating-form label')
  ratingLabels.forEach((label) => {
    label.addEventListener('click', (event) => {
      console.log(event.currentTarget)
      console.log(ratingLabels)
      ratingLabels.indexOf(event.currentTarget);
    });
  });
};

export { filterRating };
