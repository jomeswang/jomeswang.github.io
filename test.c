#include <stdio.h>
int countDigit(int N, int D);
int main()
{
    int N, D;
    scanf("%d %d", &N, &D);
    printf("%d\n", countDigit(N, D));
}
int countDigit(int N, int D)
{
    int a = 0, b = 0;
    do
    {
        a = N % 10;
        if (a == D)
            b++;
        else
            continue;
    } while (a != 0);
    return b;
}