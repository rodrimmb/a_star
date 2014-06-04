function drawGraph(){
	var search = window.location.pathname.split("/")[2];
	var graph = document.getElementById("graph");
	graph.innerHTML = obtainGraph(search);
}

function obtainGraph(search){
	var request = new XMLHttpRequest();
	request.open("GET", "/solution/graph/" + search, false);
	request.send(null);
	var data = request.responseText;
	return data;
}



function setColorToNode(element, classColor){
	var node = document.getElementById(element);

	node.removeAttribute("class");
	node.setAttribute("class", "node " + classColor);
}

function clearAllColors(){
	nodes.forEach(function(node){
		setColorToNode(node.name, "");
	});
}
