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
	console.log(window.location.pathname);
	//var request = new XMLHttpRequest();
	//request.open("POST", "/add_node/:search", false);
	//request.send(null);
}


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

