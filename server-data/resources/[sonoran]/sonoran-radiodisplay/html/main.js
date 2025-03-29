(function () {
	window.addEventListener("message", function (event) {
		switch (event.data.screen) {
			case "main_screen":
				this.document.getElementById("talk_group").innerHTML = event.data.data.talkgroup;
				this.document.getElementById("channel_name").innerHTML = event.data.data.channelname;
				this.document.getElementById("now_talking").innerHTML = event.data.data.nowtalking?.name || "";
				if (event.data.data.nowtalking?.name !== "" && event.data.data.nowtalking?.isMe) {
					document.getElementById("now_talking").style.display = 'block';
					this.document.body.style.backgroundColor = "#C6B28B";
				} else if (event.data.data.nowtalking?.name !== "" && !event.data.data.nowtalking?.isMe) {
					document.getElementById("now_talking").style.display = 'block';
					this.document.body.style.backgroundColor = "rgb(153, 207, 151)";
				} else {
					document.getElementById("now_talking").style.display = 'none';
					this.document.body.style.backgroundColor = "#fff";
				}
				break;
			case "power_off":
				this.document.getElementById("talk_group").innerHTML = "";
				this.document.getElementById("channel_name").innerHTML = "";
				this.document.getElementById("now_talking").innerHTML = "";
				this.document.body.style.backgroundColor = "rgb(0, 0, 0)";
				this.document.getElementById("svg_row").style.display = "none";
				break;
			case "power_on":
				this.document.getElementById("svg_row").style.display = "flex";
				this.document.getElementById("talk_group").innerHTML = "";
				this.document.getElementById("channel_name").innerHTML = "";
				this.document.getElementById("now_talking").innerHTML = "";
				this.document.body.style.backgroundColor = "#fff";
				break;
			default:
				break;
		}
	});
})();
