let panicState = false;
let panicInterval = null;
(function () {
	window.addEventListener("message", function (event) {
		switch (event.data.screen) {
			case "power_off":
				break;
			case "power_on":
				break;
			case "panic_toggle":
				// Toggle panic state
				panicState = event.data.data.state
				handlePanicState();
				break;
			default:
				break;
		}
	});
})();

function handlePanicState() {
    if (panicState) {
        if (!panicInterval) {
            panicInterval = setInterval(() => {
                document.body.style.backgroundColor =
                    document.body.style.backgroundColor === "rgb(247, 115, 0)" ? "#bd242f80" : "rgb(247, 115, 0)";
            }, 250);
        }
    } else {
        clearInterval(panicInterval);
        panicInterval = null;
        document.body.style.backgroundColor = "rgb(247, 115, 0)"; // Reset to default
    }
}