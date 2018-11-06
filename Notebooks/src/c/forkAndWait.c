#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>






void newFork(){
	//Create a duplicate process
	int pid = fork(); //Fork will return twice
	//Fork 'creats' a thread to run child and parent concurrently
	//This code block after the fork() call is executed twice!
	if (pid==0){
		for(int i=0; i<1000; ++i){
			printf("I am Luke Skywalker!\n");
		}
		exit(0);//ends current process
	} else if(pid>0){
		int exitStatus;
		for(int i=0; i<1000; ++i){
			printf("I am Darth Vader\n");
		}	
		wait(&exitStatus);//saves child exitStatus into named var. Waits til 
		//child exits before continues
		exit(0);
	}
	perror("There is a disturbance in the force.");
	exit(-1);
}

int main(){
	newFork();
	return 0;
}
