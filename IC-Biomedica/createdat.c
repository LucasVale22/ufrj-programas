#include <stdio.h>
#include <wfdb/wfdb.h>

int main(){


	int i;
	WFDB_Sample v[2];
	WFDB_Siginfo s[2];
	
	if (isigopen("100s", s, 2) < 2)
		exit(1);

	FILE *fileDat = fopen("100.dat", "w");
	while (getvec(v) >= 0) {
		printf("%d\t%d\n", v[0], v[1]);
		fprintf(fileDat, "%d\n%d\n", v[0], v[1]);
	}



	return 0;
}
