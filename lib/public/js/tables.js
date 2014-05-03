var children = [];

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
	addNodeToDB(node, search);
}

function obtainNodeParameters(){
	var name = obtainFromForm("nodeName");
	var cost = obtainFromForm("nodeCost");
	var father = obtainFromForm("nodeParent");
	var goal = obtainFromForm("nodeGoal");
	var isGoal = false;

	if(goal === "on"){
		isGoal = true;
	}

	var result = {"name": name, "cost" : cost, "father": father, "children": children, "goal": isGoal};

	document.getElementById("children").innerHTML = "Empty";
	children = [];
	return result;
}

function addNodeChildren(){
	var nodeChildName = obtainFromForm("nodeChild");
	var nodeChildCost = obtainFromForm("costNodeChild");

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

function obtainFromForm(id){
	var value = document.getElementById(id).value;
	document.getElementById(id).value = "";
	return value;
}

function addNodeToDB(node, search){
	var request = new XMLHttpRequest();
	request.open("POST", "/nodes/add_node/" + search, false);
	request.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
	request.send(JSON.stringify(node));
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