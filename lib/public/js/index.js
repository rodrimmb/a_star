window.onload=function(){
	refreshSearches();
};

function showModalAddSearch(){
	$('#add-search').modal({
	  show: true
	})
}

function addSearch(){
	var name = getNameOfSearch();
	addSearchToDB(name);
	refreshSearches();
}

function removeSearch(searchUrl){
	var value = confirm("Are you sure?");
	if (value == true){
  		removeSearchToDB(searchUrl);
		refreshSearches();
  	}
}

function refreshSearches(){
	clearTable();
	var searches = obtainSearches();
	searches.forEach(function(search){
		addSearchToTable(search);
	});
}

function clearTable(){
	var myNode = document.getElementById("name-searches");
	while (myNode.firstChild) {
	    myNode.removeChild(myNode.firstChild);
	}
}

function getNameOfSearch(){
	var name = document.getElementById("searchName").value;
	document.getElementById("searchName").value = "";
	return name;
}

function addSearchToTable(search){
	var tr = document.createElement("tr");
	var td = document.createElement("td");
	var a = document.createElement("a");
	var button = document.createElement("button");
	button.setAttribute('onclick', 'removeSearch(\"'+ search.url +'\")');
	button.setAttribute('class', 'btn btn-primary btn-sm glyphicon glyphicon-trash');
	a.setAttribute('href', '/work_space/'+search.url);
	var textnode=document.createTextNode(search.name);
	a.appendChild(textnode);
	td.appendChild(a);
	td.appendChild(button);
	tr.appendChild(td);
	document.getElementById("name-searches").appendChild(tr);
}

function obtainSearches(){
	var request = new XMLHttpRequest();
	request.open("GET", "searches/all_searches", false);
	request.send(null);
	var data = JSON.parse(request.responseText);
	return data;
}

function addSearchToDB(name){
	var request = new XMLHttpRequest();
	request.open("POST", "searches/add_search/"+name, false);
	request.send(null);
}

function removeSearchToDB(name){
	var request = new XMLHttpRequest();
	request.open("DELETE", "searches/search/"+name, false);
	request.send(null);
}