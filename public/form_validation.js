$(document).bind("keyup click", function(){
  if (valid_content() && valid_phone_num()) {
    $("#submit_button").removeAttr("disabled");
  } else {
    $("#submit_button").attr("disabled", "disabled");
  }
});

function valid_content() {
  var content_length = $("#text_content").val().length;
  return content_length > 0 && content_length < 140;
}

function valid_phone_num() {
  var phone_num = $("#text_phone_number").val();
  return phone_num.length == 10 && phone_num == phone_num.replace(/\D/g, '')
}