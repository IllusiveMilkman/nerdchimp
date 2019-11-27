const userPhoto = document.querySelector('#user_photo')
const fakeButton = document.querySelector('#fake-button')

if (fakeButton) {
fakeButton.addEventListener('click', (event) => {
event.preventDefault()
userPhoto.click()
})
}
