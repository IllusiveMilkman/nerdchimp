import Sortable from 'sortablejs';


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

    console.log(`${groupName} - ${listType} - ${userPathNo}`);

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
          animation: 150
      });
    };

  })
});
