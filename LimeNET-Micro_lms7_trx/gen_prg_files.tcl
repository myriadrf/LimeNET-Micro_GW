qexec "quartus_cpf -c ../LimeNET-Micro_bitstreams/gen_pof_file.cof"
post_message "*******************************************************************"
post_message "Generated programming file: LimeNET-Micro_lms7_trx_HW_2.0.pof" -submsgs [list "Output file saved in ../LimeNET-Micro_bitstreams/ directory"]
post_message "*******************************************************************"
file copy -force -- output_files/LimeNET-Micro_lms7_trx.sof ../LimeNET-Micro_bitstreams/LimeNET-Micro_lms7_trx_HW_2.0.sof