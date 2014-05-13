var children = [];

function AddNodeModal(){
}

AddNodeModal.show = function(){
	$('#add-popup').modal({
		show: true
	})
}

AddNodeModal.obtainNodeParameters = function(){
	var name = obtainElementsById("nodeName").value;
	var cost = obtainElementsById("nodeCost").value;
	var father = obtainElementsById("nodeParent").value.split(',');
	var goal = obtainElementsById("nodeGoal").checked;

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
	var formName = obtainElementsById("form-name");
	var formCost = obtainElementsById("form-cost");
	var name = obtainElementsById("nodeName");
	var cost = obtainElementsById("nodeCost");
	var father = obtainElementsById("nodeParent");
	var goal = obtainElementsById("nodeGoal");
	name.value = "";
	cost.value = "";
	father.value = "";
	goal.checked = false;
	formName.className = "form-group";
	formCost.className = "form-group";
}

function showErrorInField(field, show){
	var input = obtainElementsById(field);

	if(show){
		input.className = "form-group has-error";
	}else{
		input.className = "form-group has-success";
	}

}

function addNodeChildren(){
	var nodeChildName = obtainElementsById("nodeChild");
	var nodeChildCost = obtainElementsById("costNodeChild");

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