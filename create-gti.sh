#! /bin/bash
while IFS= read -r -u 4 line1 && IFS= read -r -u 5 line2; do
  echo "With file: $line1 and filter $line2"
  echo "Create GTI"

  maketime $line2 gti-${line1} "(elv.gt.10).and.(offset.lt.0.02).and.(PCU2_ON.eq.1)" NAME VALUE TIME no
##Using bright criteria##
done 4<"list_event" 5<"list_filter"
echo "GTI(s) have been created"
