#!/usr/bin/perl  

use strict; 
  
my @pids; 
my $max = 4; 
my $children = 0; 

for(my $i = 0; $i < 10; $i++) { 
      my $pid; 
      if($children == $max) { 
            $pid = wait(); 
            $children--; 
      } 
      my $pid = fork();
      die("Cannot for\n") if (! defined $pid);
      if( $pid ) { # parent proc
          $children++; 
          print "Parent: forked child $i : $pid\n"; 
          push @pids, $pid; 
      } else { # child proc
          my $rc = child($i, $pid); 
          exit; 
      } 
} 

# wait for all child proc
for my $pid (@pids) {
    my $a = waitpid($pid, 0); # return the pid finished
    my $rc = $? >> 8; # remove signal / dump bits from rc
    print "PID $pid finished with rc $rc\n";
#      waitpid $pid, 0; 
} 
print "DONE.\n"; 

sub child() { 
      my $id = $_[0]; 
      my $pid = $_[1];
      sleep(1); 
      print "CHILD ID: $id : $pid\n"; 
      return '1';
      exit; 
}
