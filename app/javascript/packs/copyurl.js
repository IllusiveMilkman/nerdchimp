// One cannot copy to the clipboard directly.  The solution below
// adds a temporary element to your page, inserts the url as the value of the
// temporary element and then selects and copies it to the clipboard.
// Thereafter it removes the element again.

var $temp = $('<input id="temporary-input-for-clipboard">');
var $url = $(location).attr('href');

$('#url-button').on('click', function() {
  $("body").append($temp); // Create a temporary element
  $temp.val($url).select(); // Set the value of temporary element and select that value
  document.execCommand("copy"); // copy it to the OS clipboard
  $temp.remove(); // Remove the temporary element
  $("#url-message").text("URL copied!");
})
