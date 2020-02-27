const changeAvatarWhenParticipant = () =>{
 const buttonPlus = document.querySelectorAll(".btn-create");
  if (buttonPlus) {
    buttonPlus.forEach((btn) => {
      btn.addEventListener("click", (event) => {
        event.currentTarget.classList.toggle("fa-minus-circle");
        event.currentTarget.classList.toggle("fa-plus-circle")
      });
    });
  }
}

export { changeAvatarWhenParticipant };
