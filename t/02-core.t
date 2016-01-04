use strict;
use warnings;

use Test::More tests=>11;


BEGIN {#1
    use_ok( 'Graph::Dijkstra' ) || print "Bail out!\n";
}

{#tests 2-7

	my $graph = Graph::Dijkstra->new();
	ok(defined($graph), 'Dijkstra->new()');
	
	$graph->node( { id=>'A', label=>'one' } );
	$graph->node( { id=>'B', label=>'two' } );
	$graph->node( { id=>'C', label=>'three' } );
	$graph->node( { id=>'D', label=>'four' } );
	$graph->node( { id=>'E', label=>'five' } );
	$graph->node( { id=>'F', label=>'six' } );
	$graph->node( { id=>'G', label=>'seven' } );
	$graph->node( { id=>'H', label=>'eight' } );
	$graph->node( { id=>'I', label=>'nine' } );
	$graph->node( { id=>'J', label=>'ten' } );
	$graph->node( { id=>'K', label=>'eleven' } );
	$graph->node( { id=>'L', label=>'twelve' } );
	$graph->node( { id=>'M', label=>'thirteen' } );
	$graph->node( { id=>'N', label=>'fourteen' } );
	ok( $graph->node('N')->{label} eq 'fourteen', "\$graph->node('N')->{label} eq 'fourteen'" );
	
	$graph->edge( { sourceID=>'A', targetID=>'B', weight=>4 } );
	$graph->edge( { sourceID=>'A', targetID=>'D', weight=>3 } );
	$graph->edge( { sourceID=>'A', targetID=>'E', weight=>7 } );
	$graph->edge( { sourceID=>'A', targetID=>'F', weight=>5 } );
	$graph->edge( { sourceID=>'B', targetID=>'C', weight=>7 } );
	$graph->edge( { sourceID=>'B', targetID=>'F', weight=>2 } );
	$graph->edge( { sourceID=>'C', targetID=>'F', weight=>3 } );
	$graph->edge( { sourceID=>'C', targetID=>'G', weight=>5 } );
	$graph->edge( { sourceID=>'D', targetID=>'E', weight=>5 } );
	$graph->edge( { sourceID=>'D', targetID=>'H', weight=>5 } );
	$graph->edge( { sourceID=>'E', targetID=>'F', weight=>3 } );
  $graph->edge( { sourceID=>'E', targetID=>'H', weight=>2 } );
  $graph->edge( { sourceID=>'F', targetID=>'G', weight=>4 } );
  $graph->edge( { sourceID=>'F', targetID=>'K', weight=>5 } );
  $graph->edge( { sourceID=>'G', targetID=>'K', weight=>2 } );
  $graph->edge( { sourceID=>'H', targetID=>'L', weight=>6 } );
  $graph->edge( { sourceID=>'I', targetID=>'J', weight=>2 } );
  $graph->edge( { sourceID=>'I', targetID=>'L', weight=>4 } );
  $graph->edge( { sourceID=>'I', targetID=>'M', weight=>7 } );
  $graph->edge( { sourceID=>'J', targetID=>'K', weight=>9 } );
  $graph->edge( { sourceID=>'K', targetID=>'N', weight=>6 } );
  $graph->edge( { sourceID=>'M', targetID=>'N', weight=>3 } );
	ok( $graph->edge( { sourceID=>'N', targetID=>'M' } )->{weight} == 3, "\$graph->edge( { sourceID=>'N', targetID=>'M' } )->{weight} == 3" );

	my %Solution = (originID=>'I');
	my $solutionCost = $graph->farthestNode(\%Solution);
	
	ok( ($solutionCost == 18 and $Solution{count} == 2),"\$graph->farthestNode(\\\%Solution) for originID='I'");
	
	%Solution = (originID=>'I', destinationID=>'A');
	my $pathCost = $graph->shortestPath(\%Solution);
	
	ok( ($pathCost == 18 and $Solution{edges}->[0]->{targetID} eq 'L'),"\$graph->shortestPath(\\\%Solution) for originID='I', destinationID='A'");

	my @nodelist = $graph->nodeList();
	ok ( scalar(@nodelist) == 14, '$graph->nodeList() returns 14 elements');
}

{#tests 8-11

	my $graph = Graph::Dijkstra->new();
	ok(defined($graph), 'Dijkstra->new()');
	
	$graph->node( { id=>'A', label=>'one' } );
	$graph->node( { id=>'B', label=>'two' } );
	
	$graph->edge( { sourceID=>'A',targetID=>'B',weight=>4 } );

	my %Solution = (originID=>'A');
	my $solutionCost = $graph->farthestNode(\%Solution);
	
	ok( ($solutionCost == 4 and $Solution{count} == 1),"\$graph->farthestNode(\\\%Solution) for originID='A'");
	
	%Solution = ( originID=>'A', destinationID=>'B');
	my $pathCost = $graph->shortestPath(\%Solution);
	
	ok( ($pathCost == 4 and $Solution{edges}->[0]->{targetID} eq 'B'),"\$graph->shortestPath(\\\%Solution) for originID='A', destinationID='B'");

	my @nodelist = $graph->nodeList();
	ok ( scalar(@nodelist) == 2, '$graph->nodeList() returns 2 elements');
}