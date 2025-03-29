(function () {
	window.addEventListener("message", function (event) {
		switch (event.data.screen) {
			case "power_off":
				this.document.getElementById("power_button").style.fill = "rgb(215, 14, 14)";
				break;
			case "power_on":
				this.document.getElementById("power_button").style.fill = "rgb(22, 144, 0)";
				break;
			default:
				break;
		}
	});
})();
