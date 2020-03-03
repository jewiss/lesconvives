const addLoader = () => {
  const loader = document.getElementById('loader');
  loader.addEventListener('click', (event)=> {
    const gifLoader = document.querySelector(".loader-gif")
    gifLoader.classList.add("active")
  });
};
export { addLoader };
