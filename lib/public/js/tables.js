window.onload=function(){
	showNodes();
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
	obtainElementsById("path-solution").innerHTML = solution;
	showAllSteps()
}

function showAllSteps(){
	var search = window.location.pathname.split("/")[2];
	var solution = getStepsFromServer(search);
	solution.forEach(function(path){
		addNodesToTableSolution(path);
	});
	loadMathExpresions();
}

function clearTableNodes(){
	var table = document.getElementById("table-nodes-content");
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
	var textNode = createNodeForTable(node.name, node.cost, "");
	var textGoal = document.createTextNode(node.goal);
	var textParent = document.createTextNode(node.father);

	var mathElement = createElemantMathML();
	node.children.forEach(function(child){
		var textChild = createNodeForTable(child.name,"",child.path_cost);
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

function addNodesToTableSolution(path){
	var tr = document.createElement("tr");

	var tdNumber = document.createElement("td");
	var tdOpen = document.createElement("td");
	var tdSuccessors = document.createElement("td");
	var tdClosed = document.createElement("td");

	var textNumber = document.createTextNode(path.id);

	var textOpen = createNodeForTable(path.open.name, path.open.cost, path.open.path_cost);
	var textOpenParent = createFatherOf(path.open.father);

	tdNumber.appendChild(textNumber);

	var mathOpen = createElemantMathML();

	mathOpen.appendChild(textOpenParent);
	mathOpen.appendChild(textOpen)

	tdOpen.appendChild(mathOpen);

	var mathSuccessors = createElemantMathML();
	path.successors.forEach(function(successor){
		var textSuccessor = createNodeForTable(successor.name, successor.cost, successor.path_cost);
		var textSuccessorParent = createFatherOf(successor.father);

		mathSuccessors.appendChild(textSuccessorParent);
		mathSuccessors.appendChild(textSuccessor);
	});

	tdSuccessors.appendChild(mathSuccessors);

	var mathClosed = createElemantMathML();
	path.closed.forEach(function(closed){
		var textClosed = createNodeForTable(closed.name, closed.cost, closed.path_cost);
		var textClosedParent = createFatherOf(closed.father);

		mathClosed.appendChild(textClosedParent);
		mathClosed.appendChild(textClosed);
	});

	tdClosed.appendChild(mathClosed);

	tr.appendChild(tdNumber);
	tr.appendChild(tdOpen);
	tr.appendChild(tdSuccessors);
	tr.appendChild(tdClosed);

	//return tr;
	document.getElementById("table-nodes-solution").appendChild(tr);
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

function createNodeForTable(node, cost, path){
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

function obtainElementsById(id){
	return document.getElementById(id);
}

function addNodeToDB(node, search){
	var request = new XMLHttpRequest();
	request.open("POST", "/nodes/add_node/" + search, false);
	request.setRequestHeader("Content-Type", "application/text");
	console.log(JSON.stringify(node));
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