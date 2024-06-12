let showTime = 7500;
let maxLines = 8;
let textColor = "255, 255, 255";

window.onload = (e) => {
	window.addEventListener('message', onEventRecieved);
};

function AppendToFeed(id, string) {
	if ($("#killfeed-container").children().length >= maxLines) {
		$("#killfeed-container").children().first().remove();
	};

	$("#killfeed-container").append(string);

	let lineContainer = $('.kill-container[data-id=' + id + ']');
	let killLine = $('.kill-line[data-line-id=' + id + ']');

	lineContainer.hide().fadeIn(100).delay(showTime+600).fadeOut();
	setTimeout(function(){
		killLine.addClass("animate__animated");
		killLine.addClass("animate__flipOutX");
		setTimeout(function(){
			killLine.remove();
		}, 600); // 500 (+ 100 for margin)
	}, showTime);  // time it lasts
};

function addKill(data) {
	const id = data.id;
	const image = data.image;
	const design = data.design;
	const noScoped = data.noScoped;
	const headshot = data.headshot;
	const driveBy = data.driveBy;
	const dist = data.dist;

	let victim = data.victim;
	let killer = data.killer;
	
	let duplicate = $(`.kill-line[data-line-id=${id}]`);
	if (duplicate.length > 0) {
		duplicate.remove();
	};

	// string creation
	let appendString = `<div data-line-id="${id}" class="kill-line animate__animated animate__fadeInRight"><div data-id="${id}" class="kill-container ${design}">`;

	if (killer.name != undefined) {
		if (killer.tag != undefined) {
			appendString = appendString + `<p class="text tag" style="color: rgb(${textColor});">${killer.tag}</p>`;
		};
		appendString = appendString + `<p class="text line-clamp name" style="color: rgb(${textColor});">${killer.name}</p>`;
	} else {
		appendString = appendString + '<p class="none"></p>';
	};
	
	if (image != undefined) {
		appendString = appendString + `<img src="images/${image}.png" alt="${image}" class="weapon-image">`;
	};

	if (noScoped == true) {
		appendString = appendString + '<img src="images/noscoped.png" alt="noscoped" class="icon-image">';
	};

	if (driveBy != false && driveBy != undefined) {
		appendString = appendString + `<img src="images/${driveBy}.png" alt="driveBy" class="icon-image">`;
	};

	if (headshot == true) {
		appendString = appendString + '<img src="images/headshot.png" alt="headshot" class="icon-image">';
	};

	if (victim.name != undefined) {
		if (victim.tag != undefined) {
			appendString = appendString + `<p class="text tag" style="color: rgb(${textColor});">${victim.tag}</p>`;
		};
		appendString = appendString + `<p class="text line-clamp name" style="color: rgb(${textColor});">${victim.name}</p>`;

		if (dist != false && dist != undefined) {
			appendString = appendString + `<p class="text dist" style="color: rgb(${textColor});">${dist}</p>`;
		};
	};

	appendString = appendString + '</div></div>';
	
	AppendToFeed(id, appendString)
};

function onEventRecieved(info) {
	let event = info.data;
	if (event.data == undefined) {
		console.error("event.data was nil!");
		return;
	};

	if (event.action == "addKill") {
		addKill(event.data);
	} else if (event.action == "toggleKillfeed") {
		if (event.data.state == true) {
			$("#killfeed-container").show()
		} else {
			$("#killfeed-container").hide()
		}
	} else if (event.action == "setConfig") {
		showTime = event.data.showTime;
		maxLines = event.data.maxLines;
	} else {
		console.log("event.action was not specified");
	}
};
