$(document).on('turbolinks:load', function() {
  if ( $('.chat-input').val().length == 0) {
    $(".chat-btn").prop('disabled', true);
  }

  $('.chat-input').on('keydown keyup keypress change', function() {
    if ( $(this).val().length > 0 ) {
      $(".chat-btn").prop('disabled', false);
    } else {
      $(".chat-btn").prop('disabled', true);
    }
  });
});


