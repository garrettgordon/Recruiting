$(document).ready(function() {
	$("#event_speakers").val("")
	$("#hidden_speaker_panel").on("click", function (e) { 
		$("#speakers_field").fadeToggle();
		$("#event_speakers").val("")
	})
})