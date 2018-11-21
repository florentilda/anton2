BEGIN{
 count=0
}
{
 if( $1 ~ /[A-Za-z]/) {
  print ""
 } else { 
  if(NF > 2) {
   for(ii=1;ii<=NF;ii++) {
    printf("%12.7f",$ii)
    if( (count % 6) == 5) {
     print ""
    }
    count=count+1
   }
  #} if (NF == 1) {
   #printf("%d\n",$1)
  }else {
   print $0
  }
 }
}
