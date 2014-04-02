function readSolution(){
    
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