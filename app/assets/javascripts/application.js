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
//= require bootstrap-sprockets
//= require jquery.turbolinks
//= require jquery_ujs
//= require_tree .
$(document).ready(function() {
  var context = new AudioContext;
  if ($('.freq_information').length > 0 ) {

    var notes = $('.freq_information').data('notes').sort(function(a, b) {
      return parseFloat(a.frequency) - parseFloat(b.frequency);
    });
    var notesArray = [];
    var voices = [];

    if (notes !== undefined) {
      notes.forEach(function(note) {
        notesArray.push(note.frequency);
      });
    }
    for (let i = 0; i < notesArray.length; i++) {
      var voice = {};
      voice.vco = context.createOscillator();
      voice.vco.frequency.value = notesArray[i];
      voice.vca = context.createGain();
      voice.vca.gain.value = 0;
      voice.panNode = context.createStereoPanner();
      voice.panNode.pan.value = (Math.random() * (0 - 2) + 2) - 1
      voice.vco.connect(voice.vca);
      voice.vca.connect(voice.panNode);
      voice.panNode.connect(context.destination);
      voice.vco.start(0);
      voices.push(voice);
      $('.note' + i).click(function() {
        var $this = $(this);
        $this.toggleClass('note' + i);
        if($this.hasClass('note' + i)) {
          $this.text('Play Note');
          $this.toggleClass("btn-danger").toggleClass("btn-success");
          voices[i].vca.gain.value = 0;
        }
        else {
          $this.text('Stop Note');
          $this.toggleClass("btn-success").toggleClass("btn-danger");
          voices[i].vca.gain.value = .1;
        }
      });
      $('.stopper').click(function() {
        for (var i = 0; i < voices.length; i++) {
          voices[i].vca.gain.value = 0;
        }
      });
    }
  }
});




//= require turbolinks
