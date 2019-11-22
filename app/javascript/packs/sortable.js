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
              let toDelete = pathElement.querySelector(`li[data-courseid="${duplicateId}"]`);
              toDelete.remove();
              document.querySelector('.modal-body').innerHTML = "<p>You already have this course in your path. We've remove it for you.</p>";
              $("#ModalCenter").modal();
            });
        },

        // Callback event on moving any card
        // Here we will create an array of the element id's within the ul
        onEnd: function (evt) {
          // console.log('onEnd called')

          let pathElement = evt.to;
          console.log(pathElement);
          console.log(pathElement.dataset.pathid);

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
      });
    };

  })
});
