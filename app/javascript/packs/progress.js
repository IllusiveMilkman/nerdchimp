const courseBananas = document.querySelectorAll('#coursebananas')
const picker = document.querySelectorAll('#slider');
picker.forEach(i => {
  i.addEventListener('change', (event) => {
    fetch(`/users/${event.target.dataset.user}/user_courses/${event.target.dataset.course}`, {
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
          const progress = document.querySelectorAll(`#progress-${data.id}`)
          progress.forEach(i => {
            i.innerHTML = `Progress: <strong>${parseInt(data.course.duration - data.course_tracker)} hour(s) left</strong>`
          })
          const circle = document.querySelectorAll(`#graph-${data.id}`)
          circle.forEach(i => {
            i.setAttribute('data-percentage', `${parseInt(data.course_tracker / data.course.duration * 100)}`)


          })
          if (data.course_tracker === data.course.duration ){
            console.log('100')
            swal("🍌", "You earned a Banana!", "info", {button: "Cool!", } )
            var num = parseInt(coursebananas.innerText, 10)
            num += 1
            coursebananas.innerText = `${num} 🍌`
          }
      })
    }, error => {
      console.log(error);
    })
  });
});
