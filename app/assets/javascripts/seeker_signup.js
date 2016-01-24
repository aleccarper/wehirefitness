var SeekerSignup = (function($, m) {

  var init = function() {
    $('#new_seeker').submit(submitForm)
  };

  var submitForm = function(event) {
    event.preventDefault();
    var $form = $(this).closest('form')
    var data = $form.serializeArray();
    data.categories = [];
    $form.find('.job-category').each(function(i, box) {
      if($(box).is(':checked')) {
        data.categories.push($(box).attr('value'));
      }
    });
    console.log(data);
  }

  return {
    init: init
  };

}(jQuery, SeekerSignup || {}));

$( document ).ready(function() {
  SeekerSignup.init();
});
