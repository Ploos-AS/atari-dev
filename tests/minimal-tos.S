        .text
        .globl  _start
_start:
        /* GEMDOS Fcreate("C:\\MINPASS.TXT", 0) */
        clr.w   -(%sp)
        pea     marker_name
        move.w  #0x3c,-(%sp)
        trap    #1
        addq.l  #8,%sp
        tst.l   %d0
        bmi.s   fail
        move.w  %d0,%d2

        /* GEMDOS Fwrite(handle, marker_len, marker_text) */
        pea     marker_text
        move.l  #marker_len,-(%sp)
        move.w  %d2,-(%sp)
        move.w  #0x40,-(%sp)
        trap    #1
        lea     12(%sp),%sp
        cmp.l   #marker_len,%d0
        bne.s   fail

        /* GEMDOS Fclose(handle) */
        move.w  %d2,-(%sp)
        move.w  #0x3e,-(%sp)
        trap    #1
        addq.l  #4,%sp
        tst.l   %d0
        bmi.s   fail

        /* GEMDOS Pterm0(): terminate cleanly instead of relying on a CRT caller. */
        clr.w   -(%sp)
        trap    #1

fail:
        /* GEMDOS Pterm(1): function 0x4c, exit status 1. */
        move.w  #1,-(%sp)
        move.w  #0x4c,-(%sp)
        trap    #1

        .data
marker_name:
        .asciz  "C:\\MINPASS.TXT"
marker_text:
        .ascii  "Ploos-AS atari-runtime minimal GEMDOS execution PASS\r\n"
        .equ    marker_len, .-marker_text
