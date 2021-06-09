#include <iostream>
int fib(int n){
 
    if(n==0)
        return 0;
 
    if(n==1)
        return 1;
 
    return (fib(n-1)+fib(n-2));
 
}

int main(){
	int n;
	std::cout << "Please input an integer to show the last value of Fibonacci Sequence :\n";
	std::cin >> n;
	std::cout << "The Fibonacci Sequence is " << fib(n) << std::endl;
	return 0;
}
