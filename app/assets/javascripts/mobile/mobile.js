//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery.mobile
//= require_directory .
//= require turbolinks

$(document).on("page:fetch", startSpinner);
$(document).on("page:receive", stopSpinner);
