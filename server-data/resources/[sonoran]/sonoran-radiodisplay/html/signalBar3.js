(function () {
	window.addEventListener("message", function (event) {
		switch (event.data.data.strength) {
			case 1:
				this.document.body.style.backgroundColor = "#474747";
				break;
			case 2:
				this.document.body.style.backgroundColor = "#474747";
				break;
			case 3:
				this.document.body.style.backgroundColor = "#9acd32";
				break;
			case 4:
				this.document.body.style.backgroundColor = "#0c0";
				break;
			case 5:
				this.document.body.style.backgroundColor = "#474747";
				break;
			default:
				break;
		}
	});
})();
