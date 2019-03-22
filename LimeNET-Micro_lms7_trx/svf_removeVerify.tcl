proc RemoveVerification {} {

   set in  [open ../LimeNET-Micro_bitstreams/LimeNET-Micro_lms7_trx_HW_2.1_org.svf r]
   set out [open ../LimeNET-Micro_bitstreams/LimeNET-Micro_lms7_trx_HW_2.1.svf w]
   set verify 0
   set lastline foobar


   while {[gets  $in line] != -1} {
      set commentline [string match -nocase *!* $line]
      set verifyline [string match -nocase *Verify* $lastline]
      set DSMline [string match -nocase *DSM* $lastline]
      if {$commentline == 1} {
         if {$verifyline == 0} {
         set verify 0
         } elseif {$DSMline == 0} {
         set verify 1
         }
      }
      if { $verify == 0 } {
      puts $out $line
      }
      set lastline $line   
      }
      
   close $in
   close $out
}