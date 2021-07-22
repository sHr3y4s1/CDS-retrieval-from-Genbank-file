print "Enter the file name:" ;
$filename=<STDIN>;
chomp $filename;

open (FILE, $filename);                     #open genbank file

@file = <FILE>; 
close FILE;

$gb=join ('',@file);                        #assign all content of file into variable gb

$fline=index($gb,"ORIGIN");                 #extracting the sequence
$seq=substr($gb,$fline+6);

$seq =~ s/\s+//g;                           #removing spaces, tabs and numeric characters 
$seq =~ s/\d+//g;
$seq =~ s/\/\///;

$rest=$gb;

while($gb=~/CDS/g)                          #extracting all coding sequences 
{
   $cds=index($rest,"CDS");
   $rest=substr($rest,$cds+3);
   $pos=substr($rest,0,index($rest,"\n"));
   $pos =~ s/\s+//g;
   @start=split('\.\.>?',$pos);
   $codr=substr($seq,@start[0]-1,@start[1]-@start[0]+1);  
   print "---------","\n";
   print uc($codr),"\n";  
}