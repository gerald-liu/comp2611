
#------- Text Segment ----------
        .text

        .globl __start
__start:
        lui	$s0, 63
        ori	$s0, 65520
        
        srl	$s0, $s0, 5
