 // Note this is important!

const flatPicker = () => {
  flatpickr('.datepicker', {
    altInput: true,
    minDate: "today",
    position: "auto",
  });

  flatpickr('.hourpicker', {
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    minuteIncrement: 10,
    defaultDate: "20:30",
  });
};

export { flatPicker };
