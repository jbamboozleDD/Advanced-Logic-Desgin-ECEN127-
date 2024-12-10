#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int main() {
	//create two arrays to hold the values of the verilog and c values
	int results_C[200]; // Verilog results
	int results_V[200]; // C results
	bool output = true;
	int phaseC, resultC;
	int phaseV, resultV;
	FILE *C_result = fopen("outputwave.csv", "r");
	FILE *V_result = fopen("outputwave_verilog.csv", "r");

	for (int i = 0; i < 200; i++) {
		fscanf(C_result, "%d,%d", &phaseC, &resultC);
		fscanf(V_result, "%d,%d", &phaseV, &resultV);
		//printf("%d, %d\n", phaseC, phaseV);
		//printf("%d, %d\n", resultC, resultV);
		if ((phaseV != phaseC) || (resultV != resultC)) {
			output = false;
			break;
		}
	}

	if (output) {
		printf("PASS\n");
	}
	else {
		printf("FAIL\n");
	}

	fclose(C_result);
	fclose(V_result);

	return 0;

}
