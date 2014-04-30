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
	//var node = obtainNodeParameters();
	addNodeToDB(null, search);
}

function addNodeToDB(node, search){
	var request = new XMLHttpRequest();
	request.open("POST", "/nodes/add_node/" + search, false);
	request.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
	request.send(JSON.stringify({name:"John Rambo", time:"2pm"}));
}

/*
{   "name": "A", 
	"cost": 4, 
	"father": null, 
	"children": [
		{ "name":"B", "path_cost":1 },
		{"name":"C", "path_cost":3}
	], 
	"goal": false },
*/





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