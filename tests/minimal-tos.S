        .text
        .globl  _main
_main:
        /* GEMDOS Fcreate("C:\\MINPASS.TXT", 0) */
        clr.w   -(%sp)
        pea     marker_name
        move.w  #60,-(%sp)
        trap    #1
        addq.l  #8,%sp
        tst.l   %d0
        bmi.s   fail
        move.w  %d0,%d2

        /* GEMDOS Fwrite(handle, marker_len, marker_text) */
        pea     marker_text
        move.l  #marker_len,-(%sp)
        move.w  %d2,-(%sp)
        move.w  #64,-(%sp)
        trap    #1
        lea     12(%sp),%sp
        cmp.l   #marker_len,%d0
        bne.s   fail

        /* GEMDOS Fclose(handle) */
        move.w  %d2,-(%sp)
        move.w  #62,-(%sp)
        trap    #1
        addq.l  #4,%sp
        tst.l   %d0
        bmi.s   fail

        moveq   #0,%d0
        rts

fail:
        moveq   #1,%d0
        rts

        .data
marker_name:
        .asciz  "C:\\MINPASS.TXT"
marker_text:
        .ascii  "Ploos-AS atari-runtime minimal GEMDOS execution PASS\r\n"
        .equ    marker_len, .-marker_text
