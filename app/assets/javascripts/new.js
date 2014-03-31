$(document).ready(function() {
	$("#hidden_speaker_panel").on("click", function (e) { 
		$("#speakers_field").fadeToggle();
		$("#event_speakers").val("")
	})
})