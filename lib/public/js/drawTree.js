var redraw;

var drawing = function() {
    var width = $(document).width()*55/100;
    var height = $(document).height() - 50;

    /* Showcase of the Bellman-Ford search algorithm finding shortest paths 
       from one point to every node */
    
    /*  */

    /* We need to write a new node renderer function to display the computed
       distance.
       (the Raphael graph drawing implementation of Dracula can draw this shape,
       please consult the RaphaelJS reference for details http://raphaeljs.com/) */
    var render = function(r, n) {
            /* the Raphael set is obligatory, containing all you want to display */
            var set = r.set()
            .push(
                r
                    .rect(n.point[0]-30, n.point[1]-13, 60, 44)
                    .attr({"fill": "#5bc", r : "12px", "stroke-width" : n.distance == 0 ? "3px" : "1px" })
            )
            .push(
                r
                    .text(n.point[0], n.point[1] + 10, (n.label || n.id) + "\n(" + (n.distance == undefined ? "Infinity" : n.distance) + ")")
            );
            return set;
        };
    
    var g = new Graph();
    
    /* modify the edge creation to attach random weights */
    g.edgeFactory.build = function(source, target) {
    	var e = jQuery.extend(true, {}, this.template);
    	e.source = source;
    	e.target = target;
    	e.style.label = e.weight = Math.floor(Math.random() * 10) + 1;
    	return e;
    }
    
    /* creating nodes and passing the new renderer function to overwrite the default one */
    g.addNode("S", {render:render}); // TODO add currying support for nicer code
    g.addNode("A", {render:render});
    g.addNode("B", {render:render});
    g.addNode("C", {render:render});
    g.addNode("G", {render:render});

    /* connections */
    g.addEdge("S", "A", {weight:9, directed: true, stroke : "#bfa",fill : "#56f"}); // also supports directed graphs, but currently doesn't look that nice
    g.addEdge("S", "B", {directed: true});
    g.addEdge("A", "B", {directed: true, stroke : "#bfa",fill : "#56f"});
    g.addEdge("A", "C", {directed: true});
    g.addEdge("A", "G", {directed: true});
    g.addEdge("B", "C", {directed: true, stroke : "#bfa",fill : "#56f"});
    g.addEdge("C", "G", {directed: true, stroke : "#bfa",fill : "#56f"});

    /* random edge weights (our undirected graph is modelled as a bidirectional graph) */
/*    for(e in g.edges)
        if(g.edges[e].backedge != undefined) {
            g.edges[e].weight = Math.floor(Math.random()*10) + 1;
            g.edges[e].backedge.weight = g.edges[e].weight;
        }
*/
    /* layout the graph using the Spring layout implementation */
    var layouter = new Graph.Layout.Spring(g);
    
    /* draw the graph using the RaphaelJS draw implementation */

    /* calculating the shortest paths via Bellman Ford */
//    bellman_ford(g, g.nodes["Berlin"]);
    
    /* calculating the shortest paths via Dijkstra */
    //dijkstra(g, g.nodes["G"]);
    
    /* calculating the shortest paths via Floyd-Warshall */
    //floyd_warshall(g, g.nodes["G"]);


    /* colourising the shortest paths and setting labels */
    /*for(e in g.edges) {
        if(g.edges[e].target.predecessor === g.edges[e].source || g.edges[e].source.predecessor === g.edges[e].target) {
            g.edges[e].style.stroke = "#bfa";
            g.edges[e].style.fill = "#56f";
        } else {
            g.edges[e].style.stroke = "#aaa";
        }
    }*/
    
    var renderer = new Graph.Renderer.Raphael('canvas', g, width, height);

    redraw = function() {
        layouter.layout();
        renderer.draw();
    };
    
/*    var pos=0;
    step = function(dir) {
        pos+=dir;
        var renderer = new Graph.Renderer.Raphael('canvas', g.snapshots[pos], width, height);
        renderer.draw();
    };*/
};