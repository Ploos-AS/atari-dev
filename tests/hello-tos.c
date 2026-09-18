#include <stdio.h>

int main(void)
{
    FILE *fp;

    puts("Ploos-AS atari-dev M2 qualification");
    fp = fopen("C:\\M2PASS.TXT", "w");
    if (fp == NULL) {
        return 2;
    }
    fputs("Ploos-AS atari-dev M2 execution PASS\n", fp);
    if (fclose(fp) != 0) {
        return 3;
    }
    return 0;
}
