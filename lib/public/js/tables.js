window.onload=function(){
	showNodes();
	showSolution();
	loadMathExpresions();
	drawGraph();
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
}

function showNodes(){
	var search = window.location.pathname.split("/")[2];
	var nodes = getNodesFromServer(search);
	clearTableNodes();
	nodes.forEach(function(node, index){
		addNodesToTable(node, index+1);
	})
}

function showSolution(){
	var search = window.location.pathname.split("/")[2];
	var solution = getSolutionFromServer(search);
	var steps = getStepsFromServer(search);
	
	var elementSolution = document.getElementById("path-solution");

	elementSolution.innerHTML = solution;
	elementSolution.setAttribute("class", "hide-element");

	steps.forEach(function(path){
		addNodesToTableSolution(path.id, path.open, path.successors, path.closed);
	});
}

function showAllSteps(){
	var solution = document.getElementById("path-solution");

	solution.removeAttribute("class");

	var tableSolution = document.getElementById("table-nodes-solution");

	for (var i = 1; i < tableSolution.childNodes.length; i++) {
		var element = document.getElementById("row"+i);
		element.removeAttribute("class");
	};
}

var cases = 0;
var steps = 0;
function showStepByStep(){
	var search = window.location.pathname.split("/")[2];
	var path_steps = getStepsFromServer(search);
	
	if(steps < path_steps.length){
		switch(cases){
			case 0:
				clearTableSolution();
				for(var i = 0; i<steps;i++){
					addNodesToTableSolution(
					path_steps[i].id, 
					path_steps[i].open, 
					path_steps[i].successors, 
					path_steps[i].closed);
				}
				addNodesToTableSolution(path_steps[steps].id, path_steps[steps].open, [], []);
				cases++;
				if(steps+1 == path_steps.length){
					steps++;
				}
			break;
			case 1:
				clearTableSolution();
				for(var i = 0; i<steps;i++){
					addNodesToTableSolution(
					path_steps[i].id, 
					path_steps[i].open, 
					path_steps[i].successors, 
					path_steps[i].closed);
				}
				addNodesToTableSolution(path_steps[steps].id, path_steps[steps].open, path_steps[steps].successors, []);
				cases++;
			break;
			case 2:
				clearTableSolution();
				for(var i = 0; i<steps;i++){
					addNodesToTableSolution(
					path_steps[i].id, 
					path_steps[i].open, 
					path_steps[i].successors, 
					path_steps[i].closed);
				}
				addNodesToTableSolution(
					path_steps[steps].id, 
					path_steps[steps].open, 
					path_steps[steps].successors, 
					path_steps[steps].closed);
				cases = 0;
				steps++;
			break;
		}
	}else{
		var solution = getSolutionFromServer(search);
		document.getElementById("path-solution").innerHTML = solution;
	}

	loadMathExpresions();
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

function addNodesToTableSolution(number, open, successors, closed){
	var tr = document.createElement("tr");

	var tdNumber = document.createElement("td");
	var tdOpen = generateTableCell(open);
	var tdSuccessors = generateTableCell(successors);
	var tdClosed = generateTableCell(closed);

	var textNumber = document.createTextNode(number);

	tdNumber.appendChild(textNumber);

	tr.setAttribute("id","row"+number);

	tr.appendChild(tdNumber);
	tr.appendChild(tdOpen);
	tr.appendChild(tdSuccessors);
	tr.appendChild(tdClosed);

	tr.setAttribute("class", "not-display");

	document.getElementById("table-nodes-solution").appendChild(tr);
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