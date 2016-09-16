// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
  var context = new AudioContext;
  var notes = $('.freq_information').data('notes');
  var notesArray = [];
  var voices = [];

  notes.forEach(function(note) {
    notesArray.push(note.frequency);
  });

  for (let i = 0; i < notesArray.length; i++) {
    var voice = {};
    voice.vco = context.createOscillator();
    voice.vco.frequency.value = notesArray[i];
    voice.vca = context.createGain();
    voice.vca.gain.value = 0;
    voice.vco.connect(voice.vca);
    voice.vca.connect(context.destination);
    voice.vco.start(0);
    voices.push(voice);
    $('#note' + i).click(function() {
      var clicks = $(this).data('clicks');
      if (!clicks) {
         voices[i].vca.gain.value = 1;
      } else {
         voices[i].vca.gain.value = 0;
      }
      $(this).data("clicks", !clicks);
    });
  }
});

//= require turbolinks
