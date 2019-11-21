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
            // same properties as onEnd
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
          // Changed sorting within list
          // onUpdate: function (evt) {
          //   // same properties as onEnd
          //   console.log('You have changed the order of the list')
          // },
          onEnd: function (/**Event*/evt) {
            console.log('onEnd called')
            console.log(evt.to)    // target list
            // var itemEl = evt.item;  // dragged HTMLElement
            // evt.to;
            // evt.from;  // previous list
            // evt.oldIndex;  // element's old index within old parent
            // evt.newIndex;  // element's new index within new parent
            // evt.oldDraggableIndex; // element's old index within old parent, only counting draggable elements
            // evt.newDraggableIndex; // element's new index within new parent, only counting draggable elements
            // evt.clone // the clone element
            // evt.pullMode;  // when item is in another sortable: `"clone"` if cloning, `true` if moving
          }
      });
    };

  })
});
