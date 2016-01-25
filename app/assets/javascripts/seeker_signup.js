var SeekerSignup = (function($, m) {

  var init = function() {
    $('#new_seeker').validate({
        rules: {
          'seeker[name]': { required: true },
          'seeker[email]': { required: true },
          'seeker[city]': { required: true }
        },
        submitHandler: function(form) {
          submitForm();
        }
      });
  };

  var submitForm = function() {
    var $form = $('#new_seeker');
    var data = $form.serializeArray();
    data.categories = [];

    $form.find('.job-category').each(function(i, box) {
      if($(box).is(':checked')) {
        data.categories.push($(box).attr('value'));
      }
    });

    $.ajax({
      method: 'POST',
      data: data,
      url: $form.attr('action')
    }).done(function(response) {
      if(response.errors) {
        alert('Something went wrong :(');
      } else {
        alert('Thanks for signing up!');
      }
    });

    return false;
  }

  return {
    init: init
  };

}(jQuery, SeekerSignup || {}));

$( document ).ready(function() {
  SeekerSignup.init();
});
