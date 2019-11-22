
const picker = document.querySelectorAll('#slider');
picker.forEach(i => {
  i.addEventListener('change', (event) => {
    fetch(`http://localhost:3000/users/${event.target.dataset.user}/user_courses/${event.target.dataset.course}`, {
      method: "PATCH",
      body: JSON.stringify({
        usercourse: {
          course_tracker: parseInt(event.target.value)
        }
      }),
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': Rails.csrfToken()
      }
    })
    .then(response => {
      response.json()
        .then(data => {
          console.log(data)
      })
    }, error => {
      console.log(error);
    })
  });
});
