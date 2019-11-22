
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
          const progress = document.querySelector('#progress')
          progress.innerHTML = `Progress: ${parseInt(data.course_tracker / data.course.duration * 100)}%`
      })
    }, error => {
      console.log(error);
    })
  });
});
