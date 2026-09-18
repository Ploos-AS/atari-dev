volatile unsigned long atari_dev_m1_signature;

void _start(void)
{
    atari_dev_m1_signature = 0x41544d31UL; /* "ATM1" */
    for (;;) {
        __asm__ volatile ("nop");
    }
}
