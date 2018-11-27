#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/time.h>






#define _GNU_SOURCE
long counter = 0;
int n = 20;

void *increment(void *arg){
	for(int i = 0; i < n; ++i){
		++counter;
	}
	pthread_exit((void *) 0);
}

void decrement(){
	for(int i = 0; i < n; ++i){
		--counter;
	}
}

int main(void){
	pthread_t posixThreadId;
	int result;
	int threadExitStatus;
	void *pThreadExitStatus = &threadExitStatus;
	
	decrement();
	printf("Counter: %ld\n", counter);

	result = pthread_create(&posixThreadId, NULL, increment, NULL);
	if (result != 0) printf("pthread_create failed, error=%d\n", result);
	result = pthread_join(posixThreadId,pThreadExitStatus);
	if (result != 0) printf("Pthread_join failed, error=%d\n", result);
	
	printf("Counter: %ld\n", counter);

	return 0;
}
