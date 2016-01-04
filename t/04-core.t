use strict;
use warnings;

use Test::More tests=>9;


BEGIN {#1
    use_ok( 'Graph::Dijkstra' ) || print "Bail out!\n";
}

{#tests 2-8

	my $graph = Graph::Dijkstra->new( {edgedefault=>'directed'});
	ok(defined($graph), "Dijkstra->new({edgedefault=>'directed'})");
	
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
	$graph->node( { id=>'N',  label=>'fourteen' } );
	$graph->node( { id=>'O',  label=>'fifteen' } );
	
	$graph->edge( { sourceID=>'A', targetID=>'B', weight=>4, label=>'edge 1', id=>'A1' } );
	$graph->edge( { sourceID=>'A', targetID=>'C', weight=>3 } );
	$graph->edge( { sourceID=>'B', targetID=>'D', weight=>7 } );
	$graph->edge( { sourceID=>'B', targetID=>'E', weight=>5 } );
	$graph->edge( { sourceID=>'C', targetID=>'F', weight=>7 } );
	$graph->edge( { sourceID=>'C', targetID=>'G', weight=>2 } );
	$graph->edge( { sourceID=>'D', targetID=>'H', weight=>3 } );
	$graph->edge( { sourceID=>'D', targetID=>'I', weight=>5 } );
	$graph->edge( { sourceID=>'E', targetID=>'J', weight=>5 } );
	$graph->edge( { sourceID=>'E', targetID=>'K', weight=>5 } );
	$graph->edge( { sourceID=>'F', targetID=>'L', weight=>3 } );
	$graph->edge( { sourceID=>'F', targetID=>'M', weight=>2 } );
	$graph->edge( { sourceID=>'G', targetID=>'N', weight=>4 } );
	$graph->edge( { sourceID=>'G', targetID=>'O', weight=>5 } );
	
	$graph->edge( { sourceID=>'I', targetID=>'A', weight=>10 } );
	$graph->edge( { sourceID=>'K', targetID=>'A', weight=>11 } );
	$graph->edge( { sourceID=>'M', targetID=>'A', weight=>12 } );
	$graph->edge( { sourceID=>'O', targetID=>'A', weight=>13 } );
	
	$graph->edge( { sourceID=>'H', targetID=>'I', weight=>2 } );
	$graph->edge( { sourceID=>'J', targetID=>'K', weight=>2 } );
	$graph->edge( { sourceID=>'L', targetID=>'M', weight=>2 } );
	$graph->edge( { sourceID=>'N', targetID=>'O', weight=>2 } );
	
	my $edgeHref = $graph->edge( { sourceID=>'A', targetID=>'B' } );
	ok( (($edgeHref->{label} eq 'edge 1') and ($edgeHref->{id} eq 'A1') and ($edgeHref->{directed} eq 'directed') and ($edgeHref->{weight} == 4)), "edge 'A'->'B' label=>'edge 1' id=>'A1' directed=>'directed' weight=>4");
	
	$graph->edge( { sourceID=>'A', targetID=>'B', label=>'Thomas' } );
	
	$edgeHref = $graph->edge( { sourceID=>'A', targetID=>'B' } );
	ok( (($edgeHref->{label} eq 'Thomas') and ($edgeHref->{id} eq 'A1') and ($edgeHref->{directed} eq 'directed') and ($edgeHref->{weight} == 4)), "edge 'A'->'B' label=>'Thomas' id=>'A1' directed=>'directed' weight=>4");
	
	is($graph->edge( { sourceID=>'A', targetID=>'B', directed=>'undirected' } ), undef, "\$graph->edge( { sourceID=>'A', targetID=>'B', directed=>'undirected' } ) undefined as expected");
	
	my %Solution = (originID=>'O',destinationID=>'K');

	ok ( ($graph->shortestPath(\%Solution) == 27 and $Solution{edges}->[3]->{sourceID} eq 'E'), "shortestPath '0' 'K' weight 27" );
	
	%Solution = (originID=>'B');
	
	ok ( ($graph->farthestNode(\%Solution) == 34 and $Solution{path}{1}{destinationID} eq 'L'), "farthestNode from 'B' is 'L' at weight 34");
	
	my %solutionMatrix = ();
	
	my $graphMinMax = $graph->vertexCenter(\%solutionMatrix);
	
	ok ( ($graphMinMax == 16 and $solutionMatrix{centerNodeSet}[0] eq 'A'), "vertexCenter node is 'A' with eccentricity 16");
	
	%solutionMatrix = ();
	
	$graphMinMax = $graph->vertexCenterFloydWarshall(\%solutionMatrix);
	
	ok ( ($graphMinMax == 16 and $solutionMatrix{centerNodeSet}[0] eq 'A'), "vertexCenterFloydWarshall node is 'A' with eccentricity 16");
	
}
exit(0);