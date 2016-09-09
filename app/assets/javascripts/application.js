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
  var freq1 = parseFloat($('.freq_information').data('freq1'));

  console.log(typeof(freq1));


  var SynthPad = (function() {
    // Variables
    var myCanvas;
    var frequencyLabel;
    var volumeLabel;

    var myAudioContext;
    var oscillator;
    var gainNode;



    // Constructor
    var SynthPad = function() {
      myCanvas = document.getElementById('synth-pad');
      frequencyLabel = document.getElementById('frequency');
      volumeLabel = document.getElementById('volume');

      // Create an audio context.
      window.AudioContext = window.AudioContext || window.webkitAudioContext;
      myAudioContext = new window.AudioContext();

      SynthPad.setupEventListeners();
    };


    // Event Listeners
    SynthPad.setupEventListeners = function() {

      // Disables scrolling on touch devices.
      document.body.addEventListener('touchmove', function(event) {
        event.preventDefault();
      }, false);

      myCanvas.addEventListener('mousedown', SynthPad.playSound);
      myCanvas.addEventListener('touchstart', SynthPad.playSound);

      myCanvas.addEventListener('mouseup', SynthPad.stopSound);
      document.addEventListener('mouseleave', SynthPad.stopSound);
      myCanvas.addEventListener('touchend', SynthPad.stopSound);
    };


    // Play a note.
    SynthPad.playSound = function(event) {
      oscillator = myAudioContext.createOscillator();
      gainNode = myAudioContext.createGain();

      oscillator.type = 'sawtooth'

      gainNode.connect(myAudioContext.destination);
      oscillator.connect(gainNode);

      // SynthPad.updateFrequency(event);

      oscillator.frequency.value = freq1;

      frequencyLabel.innerHTML = freq1 + ' Hz';


      oscillator.start(0);

      // myCanvas.addEventListener('mousemove', SynthPad.updateFrequency);
      // myCanvas.addEventListener('touchmove', SynthPad.updateFrequency);

      myCanvas.addEventListener('mouseout', SynthPad.stopSound);
    };


    // Stop the audio.
    SynthPad.stopSound = function(event) {
      oscillator.stop(0);

      myCanvas.removeEventListener('mousemove', SynthPad.updateFrequency);
      myCanvas.removeEventListener('touchmove', SynthPad.updateFrequency);
      myCanvas.removeEventListener('mouseout', SynthPad.stopSound);
    };


    // Calculate the note frequency.
    // SynthPad.calculateNote = function(posX) {
    //   var noteDifference = highNote - lowNote;
    //   var noteOffset = (noteDifference / myCanvas.offsetWidth) * (posX - myCanvas.offsetLeft);
    //   return lowNote + noteOffset;
    // };


    // Calculate the volume.
    SynthPad.calculateVolume = function(posY) {
      var volumeLevel = 1 - (((100 / myCanvas.offsetHeight) * (posY - myCanvas.offsetTop)) / 100);
      return volumeLevel;
    };


    // Fetch the new frequency and volume.
    SynthPad.calculateFrequency = function(x, y) {
      var noteValue = SynthPad.calculateNote(x);
      var volumeValue = SynthPad.calculateVolume(y);

      // oscillator.frequency.value = noteValue;
      gainNode.gain.value = volumeValue;

    //  frequencyLabel.innerHTML = Math.floor(noteValue) + ' Hz';
      volumeLabel.innerHTML = Math.floor(volumeValue * 100) + '%';
    };


    // Update the note frequency.
    // SynthPad.updateFrequency = function(event) {
    //   if (event.type == 'mousedown' || event.type == 'mousemove') {
    //     SynthPad.calculateFrequency(event.x, event.y);
    //   } else if (event.type == 'touchstart' || event.type == 'touchmove') {
    //     var touch = event.touches[0];
    //     SynthPad.calculateFrequency(touch.pageX, touch.pageY);
    //   }
    // };


    // Export SynthPad.
    return SynthPad;
  })();


  // Initialize the page.
  window.onload = function() {
    var synthPad = new SynthPad();
  }
});

//= require turbolinks
