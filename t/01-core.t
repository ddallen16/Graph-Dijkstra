use strict;
use warnings;

use Test::More tests => 40;

BEGIN {#1
    use_ok( 'Graph::Dijkstra' ) || print "Bail out!\n";
}

{# infinity test
	my $PINF = 1e9999;
	ok("$PINF" eq '1.#INF', "positive infinity, $PINF");
}

{#tests 3-6


#	my $graph = Graph::Dijkstra->new();
#	ok(defined($graph), 'Dijkstra->new()');
	
	my $filename = 't/data/graphML2.xml';
	ok(-e $filename, "found $filename");
	
	my $graph = Graph::Dijkstra->inputGraphfromGraphML($filename);
	ok(defined($graph),'$Graph::Dijkstra->inputGraphfromGraphML($filename)');
	
	my %Solution = (originID=>'1');
	my $solutionCost = $graph->farthestNode(\%Solution);
	
	ok( ($solutionCost == 1.8 and $Solution{path}{1}{destinationID} eq '5'),"GraphML: \$graph->farthestNode(\\\%Solution) for originID='1'");
	
	%Solution = (originID=>'1', destinationID=>'5');
	my $pathCost = $graph->shortestPath(\%Solution);
	
	ok( ($pathCost == 1.8 and $Solution{edges}->[0]->{targetID} eq '3'),"GraphML: \$graph->shortestPath(\\\%Solution) for originID='1', destinationID='5'");
	
#	$filename = 't/data/graphML2.csv';
#	$graph->outputGraphtoCSV($filename);
}

{#tests 7-10

#	my $graph = Graph::Dijkstra->new();
	
	my $filename = 't/data/graphML2.gml';
	ok(-e $filename, "found $filename");
	
	my $graph = Graph::Dijkstra->inputGraphfromGML($filename);
	ok(defined($graph),'Graph::Dijkstra->inputGraphfromGML($filename)');
	
	my %Solution = (originID=>'1');
	my $solutionCost = $graph->farthestNode(\%Solution);
	
	ok( ($solutionCost == 1.8 and $Solution{path}{1}{destinationID} eq '5'),"GML: \$graph->farthestNode(\\\%Solution) for originID='1'");
	
	%Solution = (originID=>'1', destinationID=>'5');
	my $pathCost = $graph->shortestPath(\%Solution);
	
	ok( ($pathCost == 1.8 and $Solution{edges}->[0]->{targetID} eq '3'),"GML: \$graph->shortestPath(\\\%Solution) for originID='1', destinationID='5'");

}


{#tests 11-14

#	my $graph = Graph::Dijkstra->new();
	
	my $filename = 't/data/graphML2.json';
	ok(-e $filename, "found $filename");
	
	my $graph = Graph::Dijkstra->inputGraphfromJSON($filename);
	ok(defined($graph),'Graph::Dijkstra->inputGraphfromJSON($filename)');
	
	my %Solution = (originID=>'1');
	my $solutionCost = $graph->farthestNode(\%Solution);
	
	ok( ($solutionCost == 1.8 and $Solution{path}{1}{destinationID} eq '5'),"JSON: \$graph->farthestNode(\\\%Solution) for originID='1'");
	
	%Solution = (originID=>'1', destinationID=>'5');
	my $pathCost = $graph->shortestPath(\%Solution);
	
	ok( ($pathCost == 1.8 and $Solution{edges}->[0]->{targetID} eq '3'),"JSON: \$graph->shortestPath(\\\%Solution) for originID='1', destinationID='5'");

}


{#tests 15-18

#	my $graph = Graph::Dijkstra->new();
	
	my $filename = 't/data/graphML2.csv';
	
	ok(-e $filename, "found $filename");
	
	my $graph = Graph::Dijkstra->inputGraphfromCSV($filename);
	ok(defined($graph),'Graph::Dijkstra->inputGraphfromCSV($filename)');
	
	my %Solution = (originID=>'1');
	my $solutionCost = $graph->farthestNode(\%Solution);
	
	ok( ($solutionCost == 1.8 and $Solution{path}{1}{destinationID} eq '5'),"CSV: \$graph->farthestNode(\\\%Solution) for originID='1'");
	
	%Solution = (originID=>'1', destinationID=>'5');
	my $pathCost = $graph->shortestPath(\%Solution);
	
	ok( ($pathCost == 1.8 and $Solution{edges}->[0]->{targetID} eq '3'),"CSV: \$graph->shortestPath(\\\%Solution) for originID='1', destinationID='5'");

}

{# 19-24
#	my $graph = Graph::Dijkstra->new();
	
	my $filename = 't/data/graphML2.xml';
	my $graph = Graph::Dijkstra->inputGraphfromGraphML($filename);
	
	$graph->graph( {label=>'G', creator=>'test test'} );
	
	$filename = 't/data/graphML3.csv';
	$graph->outputGraphtoCSV($filename);
	ok(-e $filename, '$graph->outputGraphtoCSV($filename);');
	
	$filename = 't/data/graphML3.gml';
	$graph->outputGraphtoGML($filename, 'Test Test');
	ok(-e $filename, "\$graph->outputGraphtoGML(\$filename, 'Test Test');");
	
	$filename = 't/data/graphML3.json';
	$graph->outputGraphtoJSON($filename);
	ok(-e $filename, '$graph->outputGraphtoJSON($filename);');
	
	$filename = 't/data/graphML3.graphml.xml';
	$graph->outputGraphtoGraphML($filename, {});
	ok(-e $filename, '$graph->outputGraphtoGraphML($filename, {});');
	
	$filename = 't/data/graphML3.gexf.xml';
	$graph->outputGraphtoGEXF($filename);
	ok(-e $filename, '$graph->outputGraphtoGEXF($filename);');
	
	$filename = 't/data/graphML3.pajek.net';
	$graph->outputGraphtoNET($filename);
	ok(-e $filename, '$graph->outputGraphtoNET($filename);');
	

}

{# 25-26

#	my $graph = Graph::Dijkstra->new();
	
	my $filename = 't/data/graphML3.csv';
	my $graph = Graph::Dijkstra->inputGraphfromCSV($filename);
	
	ok(defined($graph),'Graph::Dijkstra->inputGraphfromCSV($filename)');

	my %Solution = (originID=>'1');
	my $solutionCost = $graph->farthestNode(\%Solution);
	
	ok( ($solutionCost == 1.8 and $Solution{path}{1}{destinationID} eq '5'),"CSV: \$graph->farthestNode(\\\%Solution) for originID='1'");
	
	unlink($filename);
}

{# 27-28

#	my $graph = Graph::Dijkstra->new();
	
	my $filename = 't/data/graphML3.json';
	my $graph = Graph::Dijkstra->inputGraphfromJSON($filename);
	
	ok(defined($graph),'Graph::Dijkstra->inputGraphfromJSON($filename)');

	my %Solution = (originID=>'1');
	my $solutionCost = $graph->farthestNode(\%Solution);
	
	ok( ($solutionCost == 1.8 and $Solution{path}{1}{destinationID} eq '5'),"JSON: \$graph->farthestNode(\\\%Solution) for originID='1'");
	
	unlink($filename);
}

{# 29-32

#	my $graph = Graph::Dijkstra->new();
	
	my $filename = 't/data/graphML3.gexf.xml';
	my $graph = Graph::Dijkstra->inputGraphfromGEXF($filename);
	
	ok(defined($graph),'Graph::Dijkstra->inputGraphfromGEXF($filename)');

	my %Solution = (originID=>'1');
	my $solutionCost = $graph->farthestNode(\%Solution);
	
	ok( ($solutionCost == 1.8 and $Solution{path}{1}{destinationID} eq '5'),"GEXF: \$graph->farthestNode(\\\%Solution) for originID='1'");
	
	ok( $graph->graph()->{label} eq 'G', "\$graph->graph()->{label} eq 'G'");
	
	my ($status, $errmsg) = Graph::Dijkstra->validateGEXFxml($filename);
	ok( ($status or $errmsg eq 'GEXF xml schema URL not accessible'), 'Graph::Dijkstra->validateGEXFxml($filename)');
	
	
	unlink($filename);
}

{# 33-34

#	my $graph = Graph::Dijkstra->new();
	
	my $filename = 't/data/graphML3.gml';
	my $graph = Graph::Dijkstra->inputGraphfromGML($filename);
	ok(defined($graph),'Graph::Dijkstra->inputGraphfromGML($filename)');

	my %Solution = (originID=>'1');
	my $solutionCost = $graph->farthestNode(\%Solution);
	
	ok( ($solutionCost == 1.8 and $Solution{path}{1}{destinationID} eq '5'),"GML: \$graph->farthestNode(\\\%Solution) for originID='1'");
	
	unlink($filename);
}

{# 35-38

#	my $graph = Graph::Dijkstra->new();
	
	my $filename = 't/data/graphML3.graphml.xml';
	my $graph = Graph::Dijkstra->inputGraphfromGraphML($filename);
	ok(defined($graph),'Graph::Dijkstra->inputGraphfromGraphML($filename)');

	my %Solution = (originID=>'1');
	my $solutionCost = $graph->farthestNode(\%Solution);
	
	ok( ($solutionCost == 1.8 and $Solution{path}{1}{destinationID} eq '5'),"GraphML: \$graph->farthestNode(\\\%Solution) for originID='1'");
	
	ok( $graph->graph()->{creator} eq 'test test', "\$graph->graph()->{creator} eq 'test test'");
	
	my ($status, $errmsg) = Graph::Dijkstra->validateGraphMLxml($filename);
	ok( ($status or $errmsg eq 'GraphML xml schema URL not accessible'), 'Graph::Dijkstra->validateGraphMLxml($filename)');
	
	unlink($filename);
}


{# 39-40

#	my $graph = Graph::Dijkstra->new();
	
	my $filename = 't/data/graphML3.pajek.net';
	my $graph = Graph::Dijkstra->inputGraphfromNET($filename);
	ok(defined($graph),'Graph::Dijkstra->inputGraphfromNET($filename)');

	my %Solution = (originID=>'1');
	my $solutionCost = $graph->farthestNode(\%Solution);
	
	ok( ($solutionCost == 1.8 and $Solution{path}{1}{destinationID} eq '5'),"NET: \$graph->farthestNode(\\\%Solution) for originID='1'");
	
	unlink($filename);
}



exit(0);