# 1 "variable.cpp"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/opt/riscv/sysroot/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "variable.cpp"
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
