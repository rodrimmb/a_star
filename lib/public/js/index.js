function showModalAddSearch(){
	$('#add-search').modal({
	  show: true
	})
}

function addSearch(){
	var name = getNameOfSearch();
	//addSerchToDB(name);
	addSearchToTable(name);
}

function removeSearch(){
	
}

function refreshSearches(){
	/*var searches = obtainSearches();
	searches.forEach(function(search){
		addSearchToTable(search.name);
	});*/
}

function getNameOfSearch(){
	var name = document.getElementById("searchName").value;
	document.getElementById("searchName").value = "";
	return name;
}

function addSearchToTable(name){
	var tr = document.createElement("tr");
	var td = document.createElement("td");
	var textnode=document.createTextNode(name);
	td.appendChild(textnode);
	tr.appendChild(td)
	document.getElementById("name-searches").appendChild(tr);
}

function obtainSearches(){

}

function addSearchToDB(name){
	
}