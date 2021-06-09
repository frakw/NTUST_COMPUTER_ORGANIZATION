int global_init = 87;
int global_non_init;
void function();

int main(){
	int local_init = 66;
	int local_non_init;

	int* dynamic = new int[10];
	function();
	return 0;
}

void function(){
	static int static_variable_init = 1;
	static int static_variable_non_init;
}
