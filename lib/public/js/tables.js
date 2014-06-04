window.onload=function(){
	drawGraph();
	showNodes();
	showSolution();
	loadMathExpresions();
};

function showModalAddNode(){
	AddNodeModal.show();
}

function refreshTableNodes(){
	clearTableNodes();
	showNodes();
	loadMathExpresions();
}

function loadMathExpresions(){
	MathJax.Hub.Queue(["Typeset",MathJax.Hub]);
}

function addNode(){
	var search = window.location.pathname.split("/")[2];
	var node = AddNodeModal.obtainNodeParameters();
	if(AddNodeModal.isValidNode(node)){
		addNodeToDB(node, search);
		AddNodeModal.clearInput();
	}
	refreshTableNodes();
	drawGraph();
}

var nodes = null;

function showNodes(){
	var search = window.location.pathname.split("/")[2];
	nodes = getNodesFromServer(search);
	clearTableNodes();
	nodes.forEach(function(node, index){
		addNodesToTable(node, index+1);
	})
}

var solution = null;
var steps = null;

function showSolution(){
	var search = window.location.pathname.split("/")[2];
	solution = getSolutionFromServer(search);
	steps = getStepsFromServer(search);

	var elementSolution = document.getElementById("path-solution");

	elementSolution.innerHTML = solution;
	elementSolution.setAttribute("class", "hide-element");

	clearTableSolution();

	cases = 0;
	stepByStep = 1;

	steps.forEach(function(path){
		addNodesToTableSolution(path.id, path.open, path.successors, path.closed);
	});

	clearAllColors();

	loadMathExpresions();
}

function showAllSteps(){
	var solution = document.getElementById("path-solution");

	solution.removeAttribute("class");

	var tableSolution = document.getElementById("table-nodes-solution");

	for (var i = 1; i < tableSolution.childNodes.length+1; i++) {
		var row = document.getElementById("row"+i);
		for(var j = 1; j < row.childNodes.length; j++){
			var cell = row.childNodes[j];
			cell.removeAttribute("class");
		}
		row.removeAttribute("class");
	}

	clearAllColors();
}

var cases = 0;
var stepByStep = 1;

function showStepByStep(){
	var tableSolution = document.getElementById("table-nodes-solution");
	var row = document.getElementById("row"+stepByStep);

	if(cases == 0){
		row.removeAttribute("class");
	}

	switch(cases){
		case 0:
			row.childNodes[1].removeAttribute("class");
			cases++;

			setColorToNode(steps[stepByStep - 1].open[0].name, "open");

			break;
		case 1:
			row.childNodes[2].removeAttribute("class");
			cases++;

			steps[stepByStep - 1].successors.forEach(function(node){
				setColorToNode(node.name, "successors");
			});

			if(stepByStep == tableSolution.childNodes.length){
				showAllSteps();
			}
			break;
		case 2:
			row.childNodes[3].removeAttribute("class");

			steps[stepByStep - 1].closed.forEach(function(node){
				setColorToNode(node.name, "closed");
			});

			steps[stepByStep - 1].successors.forEach(function(node){
				setColorToNode(node.name, "");
			});

			if(stepByStep == tableSolution.childNodes.length){
				showSolution();
				cases = 0;
				stepByStep = 1;
			}else{
				cases = 0;
				stepByStep++;
			}
			break;
	}

}

function clearTableNodes(){
	var table = document.getElementById("table-nodes-content");
	while (table.firstChild) {
	    table.removeChild(table.firstChild);
	}
}

function clearTableSolution(){
	var table = document.getElementById("table-nodes-solution");
	while (table.firstChild) {
	    table.removeChild(table.firstChild);
	}
}

function addNodesToTableSolution(number, open, successors, closed){
	var tr = document.createElement("tr");

	var tdNumber = document.createElement("td");
	var tdOpen = generateTableCell(open);
	var tdSuccessors = generateTableCell(successors);
	var tdClosed = generateTableCell(closed);

	tdOpen.setAttribute("class", "hide-element");
	tdSuccessors.setAttribute("class", "hide-element");
	tdClosed.setAttribute("class", "hide-element");

	var textNumber = document.createTextNode(number);

	tdNumber.appendChild(textNumber);

	tr.setAttribute("id","row"+number);

	tr.appendChild(tdNumber);
	tr.appendChild(tdOpen);
	tr.appendChild(tdSuccessors);
	tr.appendChild(tdClosed);

	tr.setAttribute("class", "hide-element");

	document.getElementById("table-nodes-solution").appendChild(tr);
}

function addNodesToTable(node, index){
	var tr = document.createElement("tr");
	var tdNumber = document.createElement("td");
	var tdNode = document.createElement("td");
	var tdChildren = document.createElement("td");
	var tdParent = document.createElement("td");
	var tdGoal = document.createElement("td");

	var textNumber = document.createTextNode(index);
	var textNode = createNodeForTable(node.name, node.cost, "",false);
	var textGoal = document.createTextNode(node.goal);
	var textParent = document.createTextNode(node.father);

	var mathElement = createElemantMathML();
	node.children.forEach(function(child){
		var textChild = createNodeForTable(child.name,"",child.path_cost,false);
		mathElement.appendChild(textChild);
	});

	var nodeTable = createElemantMathML();
	nodeTable.appendChild(textNode);

	tdChildren.appendChild(mathElement);

	tdNumber.appendChild(textNumber);
	tdNode.appendChild(nodeTable);
	tdGoal.appendChild(textGoal);
	tdParent.appendChild(textParent);

	tr.appendChild(tdNumber);
	tr.appendChild(tdNode);
	tr.appendChild(tdChildren);
	tr.appendChild(tdParent);
	tr.appendChild(tdGoal);

	document.getElementById("table-nodes-content").appendChild(tr);
}

function generateTableCell(cellElements){
	var cell = document.createElement("td");
	var mathElement = createElemantMathML();

	cellElements.forEach(function(element){
		var textElement = createNodeForTable(element.name, element.cost, element.path_cost, element.deleted);
		var textElementParent = createFatherOf(element.father);

		mathElement.appendChild(textElementParent);
		mathElement.appendChild(textElement);
	});

	cell.appendChild(mathElement);
	return cell;
}

function createFatherOf(father){
	var msub = document.createElement("msub");
	var mi = document.createElement("mi");
	var parent = document.createElement("mi");

	var textParent = document.createTextNode(father);

	parent.appendChild(textParent);

	msub.appendChild(mi);
	msub.appendChild(parent);

	return msub;
}

function createNodeForTable(node, cost, path, deleted){
	var msubsup = document.createElement("msubsup");
	var mi = document.createElement("mi");
	var superindice = document.createElement("mn");
	var subindice = document.createElement("mn");

	var nodeName = document.createTextNode(node);
	var nodeCost = document.createTextNode(cost);
	var nodePath = document.createTextNode(path);

	mi.appendChild(nodeName);
	superindice.appendChild(nodeCost);
	subindice.appendChild(nodePath);

	if(deleted == true){
		mi.setAttribute("mathcolor", "#cc0000");
	}

	msubsup.appendChild(mi);
	msubsup.appendChild(subindice);
	msubsup.appendChild(superindice);

	return msubsup;
}

function createElemantMathML(){
	var math = document.createElement("math");
	math.setAttribute('xmlns', "http://www.w3.org/1998/Math/MathML");
	return math;
}

function addNodeToDB(node, search){
	var request = new XMLHttpRequest();
	request.open("POST", "/nodes/add_node/" + search, false);
	request.setRequestHeader("Content-Type", "application/text");
	request.send(JSON.stringify(node));
}

function getNodesFromServer(search){
	var request = new XMLHttpRequest();
	request.open("GET", "/nodes/all_nodes/" + search, false);
	request.send(null);
	var data = JSON.parse(request.responseText);
	return data;
}

function getSolutionFromServer(search){
	var request = new XMLHttpRequest();
	request.open("GET", "/solution/" + search, false);
	request.send(null);
	var data = JSON.parse(request.responseText);
	return data;
}

function getStepsFromServer(search){
	var request = new XMLHttpRequest();
	request.open("GET", "/solution/path/" + search, false);
	request.send(null);
	var data = JSON.parse(request.responseText);
	return data;
}
