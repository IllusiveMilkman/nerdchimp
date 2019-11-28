const courseBananas = document.querySelectorAll('#coursebananas')
const picker = document.querySelectorAll('#slider');
picker.forEach(i => {
  i.addEventListener('change', (event) => {
    fetch(`/users/${event.target.dataset.user}/user_courses/${event.target.dataset.usercourse}`, {
      method: "PATCH",
      body: JSON.stringify({
        usercourse: {
          course_tracker: parseInt(event.target.value)
        },
        path_id: event.target.dataset.path
      }),
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': Rails.csrfToken()
      }
    })
    .then(response => {
      response.json()
        .then(data => {
          // Progress Data
          console.log(data)
          // Path Progress
          var td = document.querySelector('#total_duration')
          var tt = document.querySelector('#total_tracker')
          var tp = document.querySelector('#total_progress')
          var cp = document.querySelector('#circle_progress')

          td.innerHTML = `${data.total_duration} Hours in total`
          tt.innerHTML = `${parseInt(data.total_tracker)} Hours is completed`
          tp.innerHTML = `${data.progress} %`
          cp.setAttribute('data-percentage',`${data.progress}`)


          //Course Progress
          const progress = document.querySelectorAll(`#progress-${data.id}`)
          progress.forEach(i => {
            i.innerHTML = `<strong>${parseInt(data.course.duration - data.course_tracker)} hour(s) left</strong>`
          })
          // Progress Circle
          const circle = document.querySelectorAll(`#graph-${data.id}`)
          circle.forEach(i => {
            i.setAttribute('data-percentage', `${parseInt(data.course_tracker / data.course.duration * 100)}`)
            const value = i.querySelector('.progress-value p')
            value.innerText = `${parseInt(data.course_tracker / data.course.duration * 100)}%`

          })
          // Completed Courses - Bananas
          if (data.course_tracker === data.course.duration ){
            console.log('100')
            swal("🍌", "You earned a Banana!", "info", {button: "Cool!", } )
            var num = parseInt(coursebananas.innerText, 10)
            num += 1
            coursebananas.innerText = `${num} 🍌`

            // const cards = document.querySelectorAll(`#completed-${data.id}`)
            // cards.forEach(card => {
            //     card.style.border = "2px solid #51eba0"

            // })
          }
      })
    }, error => {
      console.log(error);
    })
  });
});
