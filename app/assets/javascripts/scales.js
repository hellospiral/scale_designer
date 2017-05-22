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
    for (let i = 0; i < notes.length; i++) {
      var voice = {};
      voice.vco = context.createOscillator();
      voice.vco.frequency.value = notes[i].frequency;
      voice.vca = context.createGain();
      voice.vca.gain.value = 0;
      voice.panNode = context.createStereoPanner();
      voice.panNode.pan.value = (Math.random() * (0 - 2) + 2) - 1
      voice.vco.connect(voice.vca);
      voice.vca.connect(voice.panNode);
      voice.panNode.connect(context.destination);
      voice.vco.start(0);
      voices.push(voice);
      $('.note' + notes[i].id).click(function() {
        var $this = $(this);
        $this.toggleClass('note' + notes[i].id);
        if($this.hasClass('note' + notes[i].id)) {
          $this.toggleClass("btn-danger").toggleClass("btn-success");
          $this.toggleClass("glyphicon-stop").toggleClass("glyphicon-play");
          voices[i].vca.gain.value = 0;
        }
        else {
          $this.toggleClass("btn-success").toggleClass("btn-danger");
          $this.toggleClass("glyphicon-play").toggleClass("glyphicon-stop");
          voices[i].vca.gain.value = .25;
        }
      });
      $('.stopper').click(function() {
        for (var i = 0; i < voices.length; i++) {
          voices[i].vca.gain.value = 0;
        }
      });
    }
    $('.stopper').click(function() {
      context.close();
    });
  }
});
