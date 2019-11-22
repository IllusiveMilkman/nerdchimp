const buttonScraper =document.querySelector('#scraper-btn')
const userUrl =document.querySelector('#user-url')
const warningMessage = document.querySelector('#warning-message');
const loadingMessage = document.querySelector('#loading')
const formTitle = document.querySelector('#user_course_title')
const formDescription = document.querySelector('#user_course_description')
const formUrl = document.querySelector('#user_course_url')
const form = document.querySelector('#manual-input')
const courseFound = document.querySelector('#course-found')



buttonScraper.addEventListener('click', (event) => {
  event.preventDefault();
  // read input value cheeeeck!!
  console.log(window.location.href)
  const url = `${window.location.origin}/api/v1/scraper?user_url=${userUrl.value}`;


if (userUrl.value) {
  loadingMessage.innerHTML = `
    <i class="fas fa-spinner fa-spin"></i>
  `
  fetch(url)
    .then(response => response.json())
    .then((data) => {
      console.log(data);
        loadingMessage.innerHTML = "";
      if(data.id != null) {
        courseFound.classList.remove('d-none')
      } else {
        formTitle.value = data.title;
        formDescription.value = data.description;
        formUrl.value = userUrl.value;
        form.style.display = 'block';
      }

    });
} else {
  warningMessage.innerText = "No URL given"
  loadingMessage.innerHTML = ''

}


//   params = {user_url:userUrl.value};

// const data = {
//   message: {
//     body: "This is a message"}};
//   // check if ther is an input value
//   if (userUrl.value ) {
//     console.log(userUrl.value);
//     fetch(url);
//   } else {
//     return "NOT positive";
//   }
//   //if value call api with params

});
