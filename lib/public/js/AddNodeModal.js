var children = [];

function AddNodeModal(){
}

AddNodeModal.show = function(){
	$('#add-popup').modal({
		show: true
	})
}

AddNodeModal.obtainNodeParameters = function(){
	var name = document.getElementById("nodeName").value;
	var cost = document.getElementById("nodeCost").value;
	var father = document.getElementById("nodeParent").value.split(',');
	var goal = document.getElementById("nodeGoal").checked;

	var result = {"name": name, "cost" : cost, "father": father, "children": children, "goal": goal};

	console.log(result);

	document.getElementById("children").innerHTML = "Empty";
	children = [];
	return result;
}

AddNodeModal.isValidNode = function(node){
	var isValid = true;
	if(node.name === ""){
		showErrorInField("form-name", true);
		isValid = false;
	}else{
		showErrorInField("form-name", false);
	}

	if(node.cost === ""){
		showErrorInField("form-cost", true);
		isValid = false;
	}else{
		showErrorInField("form-cost", false);
	}

	return isValid;
}

AddNodeModal.clearInput = function(){
	console.log("borrar");
	var formName = document.getElementById("form-name");
	var formCost = document.getElementById("form-cost");
	var name = document.getElementById("nodeName");
	var cost = document.getElementById("nodeCost");
	var father = document.getElementById("nodeParent");
	var goal = document.getElementById("nodeGoal");
	name.value = "";
	cost.value = "";
	father.value = "";
	goal.checked = false;
	formName.className = "form-group";
	formCost.className = "form-group";
}

function showErrorInField(field, show){
	var input = document.getElementById(field);

	if(show){
		input.className = "form-group has-error";
	}else{
		input.className = "form-group has-success";
	}

}

function addNodeChildren(){
	var nodeChildName = document.getElementById("nodeChild");
	var nodeChildCost = document.getElementById("costNodeChild");

	var child = {"name": nodeChildName.value, "path_cost": nodeChildCost.value}
	
	children.push(child);
	showChildren();

	nodeChildName.value = "";
	nodeChildCost.value = "";
}

function showChildren(){
	var show = "";
	children.forEach( function(node){
		show += node.name+"<sub>"+node.path_cost+"</sub> "
	});

	document.getElementById("children").innerHTML = show;
}