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

function setColorToSelectedArrow(openNode, successors, style){
	successors.forEach(function(successor){
		setColorToArrow(openNode.name,successor.name, style);
	})
}

function clearAllColors(){
	nodes.forEach(function(node){
		setColorToNode(node.name, "");
	});

	solution.forEach(function(node){
		if(solution.indexOf(node) < solution.length - 1){
			setColorToArrow(node, solution[solution.indexOf(node) + 1], "");
		}
	});
}

function setColorToArrow(source, destiny, classColor){
	var arrow = document.getElementById(source+"to"+destiny);

	arrow.removeAttribute("class");
	arrow.setAttribute("class", "edge " + classColor);
}
