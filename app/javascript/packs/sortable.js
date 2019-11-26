import Sortable from 'sortablejs';

// Function to return array of duplicate values in an array
// Examples:
// getNotUnique([1, 2, 2, 4, 4]) ==> [2, 4]
// getNotUnique([1, 2, 3]) ==> []
function getNotUnique(array) {
    var map = new Map();
    array.forEach(a => map.set(a, (map.get(a) || 0) + 1));
    return array.filter(a => map.get(a) > 1);
};

// Wait until page is loaded before runnning code:
document.addEventListener("DOMContentLoaded", function() {
  // console.log('Your document is ready!');

  addEventListenerToPathCourses();

  // Sortable Lists from here
  const sortableList = document.querySelectorAll('.sortable-list'); // Select ALL lists on page

  if (sortableList.length == 0) return; // Don't run the rest of this function if there are no lists.

  sortableList.forEach((list) => {
    const element = list;
    const groupName = element.dataset.groupname;
    const listType = element.dataset.ltype;
    const userPathNo = element.dataset.userpathno;

    // console.log(`${groupName} - ${listType} - ${userPathNo}`);

    if (listType == 'library') {
      Sortable.create(element, {
        group: {
            name: groupName,
            pull: 'clone',
            put: false // Do not allow items to be put into this list
        },
        animation: 150
      });
    } else {
      Sortable.create(element, {
        group: {
            name: groupName,
            pull: 'clone'
        },
        animation: 150,

        // Callback to the event of dropping a card into a list
        onAdd: function (evt) {
          console.log("onAdd callback activated")

          if (deleteIfDuplicateCourse(evt)) {
            console.log("duplicate found... NOT adding a delete button, or updating order.");
            // Add course to path if not yet present
          } else {
            console.log("No duplicate found - Add delete button and update order.")
            addDeleteButtonToCourse(evt);
            addEventListenerToPathCourses();
            updateOrderOfCourses(evt);
          }
        },

        // Callback to the event of changing the position of a course within a path
        onEnd: function (evt) {
          console.log("onEnd callback activated")
          // console.log('onEnd called')
          updateOrderOfCourses(evt);
        },

        // The onSort function is most likely unecessary, but keeping here in case it comes up later on in designs
        // Called by any change to the list (add / update / remove)
        onSort: function (/**Event*/evt) {
          // same properties as onEnd
          console.log("onSort callback activated")
        }
      });
    };

  })
});

function deleteIfDuplicateCourse(evt) {
  // console.log("newly added item:");
  // console.log(evt);
  // console.log(evt.item);

  let pathElement = evt.to;

  let ListItems = pathElement.querySelectorAll("li");;

  // create an array of all list items
  let idArray = [];
  ListItems.forEach ( (item) => {
    idArray.push(item.dataset.courseid)
  });

  // Extract only duplicates from array
  let duplicateArray = getNotUnique(idArray);

  // Remove duplicates from duplicates array
  // E.g. [42, 42] ==> [42]
  let uniqueDuplicates = duplicateArray.filter((v, i, a) => a.indexOf(v) === i);

  // We can now iterate over each duplicate (there should always only be one either way)
  uniqueDuplicates.forEach ( (duplicateId) => {
      evt.item.remove(); // Removes the item that was dragged into the path (the duplicate)
      document.querySelector('.modal-body').innerHTML = "<p>You already have this course in your path. We've remove it for you.</p>";
      $("#ModalCenter").modal();
    });

  // check if array is empty or does not exist.
  // If there are items in the array, it translate to duplicates being present, thus true.
  console.log(uniqueDuplicates.length > 0);
  return (uniqueDuplicates.length > 0) ? true : false;
};

function updateOrderOfCourses(evt) {
  console.log('updateOrder... called');
  let pathElement = evt.to;
  // console.log(pathElement);
  // console.log(pathElement.dataset.pathid);

  let ListItems = pathElement.querySelectorAll("li");;
  // console.log(ListItems);

  let idArray = [];
  ListItems.forEach ( (item) => {
    idArray.push(parseInt(item.dataset.courseid, 10));
  });
  // console.log(idArray);

  // AJAX with fecth() and sending JSON to the controller via /persist_position path
  let persist_url = `${window.location.origin}/persist?id_array=${idArray}&path_id=${pathElement.dataset.pathid}`;
  // console.log(persist_url);

  fetch(persist_url);
}

function addDeleteButtonToCourse(event) {
  // console.log("addDelete... called");
  // console.log(event);
  // console.log(event.currentTarget);
  // console.log(`Course: ${event.clone.dataset.courseid}`);
  // console.log(`Path: ${event.to.dataset.pathid}`);
  // console.log(`User: ${event.clone.dataset.userid}`);

  let user_id = event.clone.dataset.userid; // The user id from the cloned course object
  let course_id = event.clone.dataset.courseid; // The course id of the new element
  let path_id = event.to.dataset.pathid; // The path id of the destination path
  let list_item = document.querySelector(`ul[data-pathid="${path_id}"]>li[data-courseid="${course_id}"]`);

  // Insert the delete link into the card
  let delete_link = `<span> | </span><a confirm="Are you sure?" class="path-course" data-remote="true" rel="nofollow" data-method="delete" href="/users/${user_id}/users_courses_paths/${path_id}?course_id=${course_id}"><i class="fas fa-trash-alt"></i></a>`;
  list_item.innerHTML += delete_link;
}

function addEventListenerToPathCourses() {
  // Delete button and event on sortable lists.
  let pathCourses = document.querySelectorAll('.path-course');
  pathCourses.forEach( (course) => {
    course.addEventListener('click', (event) => {
      event.currentTarget.parentElement.remove(); // Remove the list item (parent element)
    });
  });
}
