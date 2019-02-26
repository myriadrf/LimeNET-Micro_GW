set module [lindex $quartus(args) 0]

#if [string match "quartus_asm" $module] {
qexec "quartus_cpf -c ../LimeNET-Micro_bitstreams/gen_pof_file.cof"
post_message "*******************************************************************"
post_message "Generated programming file: LimeNET-Micro_lms7_trx_HW_2.0.pof" -submsgs [list "Output file saved in ../LimeNET-Micro_bitstreams/ directory"]
post_message "*******************************************************************"
file copy -force -- output_files/LimeNET-Micro_lms7_trx.sof ../LimeNET-Micro_bitstreams/LimeNET-Micro_lms7_trx_HW_2.0.sof
qexec "quartus_cpf -c -q 1.5MHz -g 3.3 -n p ../LimeNET-Micro_bitstreams/LimeNET-Micro_lms7_trx_HW_2.0.pof ../LimeNET-Micro_bitstreams/LimeNET-Micro_lms7_trx_HW_2.0_org.svf"

source svf_removeVerify.tcl
RemoveVerification
post_message "*******************************************************************"
post_message "Generated programming file: LimeNET-Micro_lms7_trx_HW_2.0.svf" -submsgs [list "Output file saved in ../LimeNET-Micro_bitstreams/ directory"]
post_message "*******************************************************************"

#}