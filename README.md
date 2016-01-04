# Graph-Dijkstra
Perl package Graph::Dijkstra
General purpose graph functions with Dijkstra farthest node and shortest path computations
Includes methods that input/output graph datasets from/to supported file formats

DESCRIPTION

Efficient implementation of Dijkstras shortest path algorithm in Perl using a Minimum Priority Queue (Array::Heap::ModifiablePriorityQueue**).

Computation methods.

        farthestNode() Shortest path to farthest node from an origin node
        shortestPath() Shortest path between two nodes
        vertexCenter() Jordan center node set (vertex center) with all points shortest path (APSP) matrix*

*Version 0.60 added a second implementation of the vertex center method using the Floyd Warshall algorithm.

File input output methods support the following graph file formats.

        GML (Graph Modelling Language, not to be confused with Geospatial Markup Language or Geography Markup Language), 
        JSON Graph Specification (latest draft specification), 
        GraphML (XML based), 
        GEXF (Graph Exchange XML Format), 
        NET (Pajek), and
        CSV (a simple text based format, "native" to this module ).

Graph::Dijkstra supports undirected and directed graphs including mixed graphs with both types of edges. Does not support loops (edge where sourceID == targetID) or negitive edge weights. Support for directed graphs/edges is new in version 0.50 (pre-production).

In this pre-production release, the internal graph data model is fixed.

        Graph has three attributes: 'label', 'creator', and 'edgedefault'.  'edgedefault' must be either 'directed' or 'undirected' and defaults to 'undirected'.
        
        Nodes (vertices) have three attributes: 'id' (simple scalar, required, unique), 'label' (optional string), and 'edges', a list (hash) of the node id values of connected nodes.
        
        Edges have four required and two optional attributes.  Required edge attributes: 'targetID' and 'sourceID' (node 'id' values that must exist), 'weight'(cost/value/distance/amount), and 'directed'.
        'directed' must be 'directed' or 'undirected' and defaults to the graph 'edgedefault' value. 'weight' must be a positive number (integer or real) greater than 0.
        Optional edge attributes: edge 'id' and edge 'label'.  Note that there is no uniqueness checked for edge 'id' values.  Could be added in later version.

The outputGraphto[file format] methods output data elements from the internal graph. If converting between two supported formats (eg., GML and GraphML), unsupported attributes from the input file (which are not saved in the internal graph) are *not* be written to the output file. Later releases will extend the internal graph data model.

This pre-production release has not been sufficiently tested with real-world graph data sets. It has been tested with rather large datasets (tens of thousands of nodes, hundreds of thousands of edges).

If you encounter a problem or have suggested improvements, please email the author and include a sample dataset. If providing a sample data set, please scrub it of any sensitive or confidential data.

**Array::Heap::ModifiablePriorityQueue, written in Perl, uses Array::Heap, an xs module.

SYNOPSIS

  use Graph::Dijkstra;
  
  # create the object
  my $graph = Graph::Dijkstra->new();  #create the graph object with default attribute values
  my $graph = Graph::Dijkstra->new( {label=>'my graph label', creator=>'my name', edgedefault=>'undirected'} );  #create the graph object setting the label, creator, and/or edgedefault attibutes
  my $graph = Graph::Dijkstra->inputGraphfromCSV($filename);  #load graph from supported file format creating the graph object.
  
  #SET method to update graph attributes
  $graph->graph( {label=>'my graph label', creator=>'my name', edgedefault='directed'} );
  
  #GET method to return graph attributes in hash (reference)(eg., $graphAttribs->{label}, $graphAttribs->{creator})
  my $graphAttribs = $graph->graph();
  my $graphLabel = $graph->graph()->{label}; #references label attribute of graph
  
  #SET methods to create, update, and delete (remove) nodes and edges
  $graph->node( {id=>0, label=>'nodeA'} );   #create or update existing node.  id must be a simple scalar.
  $graph->node( {id=>1, label=>'nodeB'} );   #label is optional and should be string
  $graph->node( {id=>2, label=>'nodeC'} );
  $graph->edge( {sourceID=>0, targetID=>1, weight=>3, id=>'A', label=>'edge 0 to 1', directed='directed'} );  #create or update edge between sourceID and targetID;  weight (cost) must be > 0
  $graph->edge( {sourceID=>1, targetID=>2, weight=>2} );
  $graph->removeNode( 0 );
  $graph->removeEdge( {sourceID=>0, targetID=1} );
  
  #GET methods for nodes and edges
  my $nodeAttribs = $graph->node( 0 );  #returns hash reference (eg., $nodeAttribs->{id}, $nodeAttribs->{label}) or undef if node id 0 not found
  my $nodeLabel = $graph->node( 0 )->{label}; #references label attribute of node with ID value of 0
  my $bool = $graph->nodeExists( 0 );
  my $edgeAttribs = $graph->edge( { sourceID=>0, targetID=>1} );
  my $edgeWeight = $graph->edge( { sourceID=>0, targetID=>1} )->{weight};  #references weight attribute of edge that connects sourceID to targetID
  my $bool = $graph->edgeExists( { sourceID=>0, targetID=>1 } );
  my @nodes = $graph->nodeList();  #returns array of all nodes in the internal graph, each array element is a hash (reference) containing the node ID and label attributes
  my $bool = $graph->adjacent( { sourceID=>0, targetID=>1 } );
  my @nodes = $graph->adjacentNodes( 0 ); #returns list of node IDs connected by an edge with node ID 0
  
  #methods to input graph from a supported file format
  #inputGraphfrom[Format] methods can also be invoked as class methods which return the graph object on success
  $graph->inputGraphfromGML('mygraphfile.gml');
  $graph->inputGraphfromCSV('mygraphfile.csv');
  my $graph = Graph::Dijkstra->inputGraphfromCSV('mygraphfile.csv');
  $graph->inputGraphfromJSON('mygraphfile.json');   #JSON Graph Specification
  $graph->inputGraphfromGraphML('mygraphfile.graphml.xml', {keyEdgeValueID => 'weight', keyNodeLabelID => 'name'} );
  $graph->inputGraphfromGEXF('mygraphfile.gexf.xml' );
  $graph->inputGraphfromNET('mygraphfile.pajek.net' );   #NET (Pajek) format
  
  #methods to output internal graph to a supported file format
  $graph->outputGraphtoGML('mygraphfile.gml', 'creator name');
  $graph->outputGraphtoCSV('mygraphfile.csv');
  $graph->outputGraphtoJSON('mygraphfile.json');
  $graph->outputGraphtoGraphML('mygraphfile.graphml.xml', {keyEdgeWeightID => 'weight',keyEdgeWeightAttrName => 'weight', keyNodeLabelID => 'name', keyNodeLabelID => 'name'});
  $graph->outputGraphtoGEXF('mygraphfile.gexf.xml');
  $graph->outputGraphtoNET('mygraphfile.pajek.net');
  
  #class methods that validate the contents of XML files against the GraphML and GEXF schemas
  my ($bool, $errmsg) = Graph::Dijkstra->validateGraphMLxml('mygraphfile.graphml.xml');
  my ($bool, $errmsg) = Graph::Dijkstra->validateGEXFxml('mygraphfile.gexf.xml');
  
  #Dijkstra shortest path computation methods
  
  use Data::Dumper;
  my %Solution = ();
  
  #shortest path to farthest node from origin node
  %Solution = (originID => 0);
  if (my $solutionWeight = $graph->farthestNode( \%Solution )) {
        print Dumper(\%Solution);
  }
  
  #shortest path between two nodes (from origin to destination)
  %Solution = (originID => 0, destinationID => 2);
  if (my $pathCost = $graph->shortestPath( \%Solution ) ) {
        print Dumper(\%Solution);
  }
  
  #Jordan or vertex center with all points shortest path (APSP) matrix
  my %solutionMatrix = ();
  if (my $graphMinMax = $graph->vertexCenter(\%solutionMatrix) ) {
        print  {$verboseOutfile} "Center Node Set 'eccentricity', minimal greatest distance to all other nodes $graphMinMax\n";
        print  {$verboseOutfile} "Center Node Set = ", join(',', @{$solutionMatrix{centerNodeSet}} ), "\n";
        
        my @nodeList = (sort keys %{$solutionMatrix{row}});
        print  {$verboseOutfile} 'From/To,', join(',',@nodeList), "\n";
        foreach my $fromNode (@nodeList) {
                print  {$verboseOutfile} "$fromNode";
                foreach my $toNode (@nodeList) {
                        print  {$verboseOutfile} ",$solutionMatrix{row}{$fromNode}{$toNode}";
                }
                print  {$verboseOutfile} "\n";
        }
        $graph->outputAPSPmatrixtoCSV(\%solutionMatrix, 'APSP.csv');
  }
  
  #Alternative implementation of Jordan (vertex center) with APSP matrix method using Floyd Warhsall algorithm
  %solutionMatrix = ();
  my $graphMinMax = $graph->vertexCenterFloydWarshall(\%solutionMatrix);
  
  
  #Misc class methods
  
  #turn on / off verbose output to STDOUT or optional $filehandle
  Dijkstra::Graph->VERBOSE($bool, $filehandle);   
   
  #attribute hashRef to string
  my $attribStr = $graph->stringifyAttribs( $graph->graph() );  #( creator=>'', edgedefault=>'undirected', label=>'' )
  
  #string to attribute hashRef
  my $attribHref = Dijkstra::Graph->hashifyAttribs( $attribStr );   #{'creator' => '', 'edgedefault' => 'undirected', 'label' => '' }


TODOs

Add data attributes including:

  node graph coordinates (xy coordinates and/or lat/long),
  node and edge style (eg., line style, color)

Review and update inputGraphfrom[format] methods to consistently set default edge weight to 1 or allow caller to provide default edge weight.

Test very large graph datasets using a 64bit version of perl (without the 2GB process limit).

Add validateJSONgraph class method that validates contents of JSON file against JSON graph specification (dependent upon JSV::Validator package installing correctly)

Evaluate and refactor code to move the input/output graph functions to one or more separate packages to reduce the code size of the Graph::Dijkstra package. For example, put the input graph from file methods in a separate package and refactor to return a graph object. For example:

  use Graph::Dijkstra;
  use Graph::Dijkstra::Input;
   
  my $graph = Graph::Dijkstra::Input::inputGraphfromGraphML($filename);
 
#or maybe as functional call
 
  my $graph = inputGraphfromGraphML($filename);

Evaluate support for user defined graph, node, and edge attributes (metadata).

Continue to evaluate performance of vertexCenter methods. Add a progress indicator triggered by the verbose setting.

Input welcome. Please email author with suggestions. Graph data sets for testing (purged of sensitive/confidential data) are welcome and appreciated.
