#include <stdio.h>

int main(void)
{
    static const char marker[] =
        "Ploos-AS atari-runtime minimal GEMDOS execution PASS\n";
    FILE *fp = fopen("C:\\MINPASS.TXT", "w");

    if (fp == NULL) {
        return 2;
    }
    if (fputs(marker, fp) == EOF) {
        fclose(fp);
        return 3;
    }
    if (fclose(fp) != 0) {
        return 4;
    }
    return 0;
}
