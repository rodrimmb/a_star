var children = [];

window.onload=function(){
	showNodes();
};

function getSolution(){
    
    var items = "";

    $.post( "data/path_solution", function( data ) {

        $.each( data, function( key, val ) {
            items += val +" ";
        });
        printSolution(items);
    });
}

function printSolution(items){
    $("#path-solution").text(items);
}

function showModalAddNode(){
	$('#add-popup').modal({
	  show: true
	})
}

function getData(){
	var request = new XMLHttpRequest();
	request.open("GET", "data/example_json", false);
	request.send(null);
	var data = JSON.parse(request.responseText);
	return data;
}

function addNode(){
	var search = window.location.pathname.split("/")[2];
	var node = obtainNodeParameters();
	if(isValidNode(node)){
		addNodeToDB(node, search);
	}
}

function showNodes(){
	var search = window.location.pathname.split("/")[2];
	var nodes = getNodesFromServer(search);
	nodes.forEach(function(node, index){
		addNodesToTable(node, index+1);
	})

}

function addNodesToTable(node, index){
	var tr = document.createElement("tr");
	var tdNumber = document.createElement("td");
	var tdNode = document.createElement("td");
	var tdChildren = document.createElement("td");
	var tdParent = document.createElement("td");
	var tdGoal = document.createElement("td");

	var textNumber = document.createTextNode(index);
	var textName = document.createTextNode(node.name);
	var textGoal = document.createTextNode(node.goal);

	tdNumber.appendChild(textNumber);
	tdNode.appendChild(textName);
	tdGoal.appendChild(textGoal);

	tr.appendChild(tdNumber);
	tr.appendChild(tdNode);
	tr.appendChild(tdChildren);
	tr.appendChild(tdParent);
	tr.appendChild(tdGoal);

	document.getElementById("table-nodes-content").appendChild(tr);
}

function isValidNode(node){
	if(node.name === ""){
		showErrorInField("form-name", true);
		return false;
	}
	return true;
}

function showErrorInField(field, show){
	var input = obtainElementsById(field);

	if(show){
		input.className = "form-group has-error";
	}

}

function obtainNodeParameters(){
	var name = obtainElementsById("nodeName").value;
	var cost = obtainElementsById("nodeCost").value;
	var father = obtainElementsById("nodeParent").value;
	var goal = obtainElementsById("nodeGoal").checked;

	var result = {"name": name, "cost" : cost, "father": father, "children": children, "goal": goal};

	document.getElementById("children").innerHTML = "Empty";
	children = [];
	return result;
}

function addNodeChildren(){
	var nodeChildName = obtainElementsById("nodeChild");
	var nodeChildCost = obtainElementsById("costNodeChild");

	var child = {"name": nodeChildName, "path_cost": nodeChildCost}
	
	children.push(child);
	showChildren();
}

function showChildren(){
	var show = "";
	children.forEach( function(node){
		show += node.name+"<sub>"+node.path_cost+"</sub> "
	});

	document.getElementById("children").innerHTML = show;
}

function obtainElementsById(id){
	var value = document.getElementById(id);
	return value;
}

function addNodeToDB(node, search){
	var request = new XMLHttpRequest();
	request.open("POST", "/nodes/add_node/" + search, false);
	request.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
	request.send(JSON.stringify(node));
}

function getNodesFromServer(search){
	console.log("hace peticion");
	var request = new XMLHttpRequest();
	request.open("GET", "/nodes/all_nodes/" + search, false);
	request.send(null);
	var data = JSON.parse(request.responseText);
	//For development only
	console.log(data);
	return data;
}



/**
	Metodos que tengo que mejorar
**/
function printNodesInATable(id){
	var nodes = getData();
	var table = "";

	nodes.forEach( function(node){
		var row = generateRow(node);
		table += row;
	});

	printRowInTable(table, id);
}

function generateRow(node){	
	
	var row = "<tr>";
	row += "<td>"+node.recid+"</td>";
	row += "<td>"+node.name+"<sup>"+node.cost+"</td>";
	row += "<td>"+node.children+"</td>";
	row += "<td>"+node.father+"</td>";
	if(node.goal){
		row += "<td><span class='glyphicon glyphicon-ok'></span></td>";
	}else{
		row += "<td><span class='glyphicon glyphicon-remove'></span></td>";
	}
	row += "</tr>";
	return row;
}

function printRowInTable(row, id){
	var table = document.getElementById('table-nodes-content');
	table.innerHTML = row;
}