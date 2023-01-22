#include <stdio.h>

char litere_mari(char [],char []);

char litere_mici(char [],char []);

int main()
{
    char sir[100]="";
    printf("Introduceti sirul de caractere:\n");
    scanf("%s",&sir);
    
    char rez1[100]="";
    litere_mari(sir,rez1);
    printf("%s\n",rez1);
    
    char rez2[100]="";
    litere_mici(sir,rez2);
    printf("%s\n",rez2);
}