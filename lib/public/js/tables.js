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



function getData(){
	var request = new XMLHttpRequest();
	request.open("GET", "data/example_json", false);
	request.send(null);
	var data = JSON.parse(request.responseText);
	return data;
}

function showModalAddNode(){
	AddNodeModal.show();
}

function addNode(){
	var search = window.location.pathname.split("/")[2];
	var node = AddNodeModal.obtainNodeParameters();
	if(AddNodeModal.isValidNode(node)){
		addNodeToDB(node, search);
		AddNodeModal.clearInput();
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

function obtainElementsById(id){
	return document.getElementById(id);
}

function addNodeToDB(node, search){
	var request = new XMLHttpRequest();
	request.open("POST", "/nodes/add_node/" + search, false);
	request.setRequestHeader("Content-Type", "application/text");
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