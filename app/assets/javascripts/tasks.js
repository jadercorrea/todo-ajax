$(document).on('click', '.js_tasks input[type=checkbox]', function() {
  tr = $(this).parent().parent().parent();
  add = 'even';
  remove = 'odd';

  if (tr.hasClass('even') === true) {
    add = 'odd';
    remove = 'even';
  }

  $(this).submit();
  tr.addClass(add).removeClass(remove);
});
