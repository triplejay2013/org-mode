#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/time.h>



//I want to take advantage of GNU features
#define _GNU_SOURCE

//Define functions implemented below
void *theThread(void *);
void printStuff(char *, int);
void cpuSmoke(int);

int main(void) {

  //Automatic variables (these are private the the thread invoking main)
  pthread_t posixThreadId;
  int result;
  int threadExitStatus;
  void *pThreadExitStatus = &threadExitStatus;

  //Create and start the new thread with default (NULL) attributes
  result = pthread_create(&posixThreadId, NULL, theThread, NULL);
  if (result!=0) printf("pthread_create failed, error=%d\n",result);

  //Print some stuff to stdout
  printStuff("main", 1000);

  //Wait for the child thread to exit
  result = pthread_join(posixThreadId,pThreadExitStatus);
  if (result!=0) printf("pthread_join failed, error=%d\n",result);
  printf("threadExitStatus=%d\n",threadExitStatus);

  //Finished
  return 0;
}

void *theThread(void *arg) {

  //Print a bunch of stuff to stdout
  printStuff("thread",1000);

  pthread_exit((void *) 0);
}

void printStuff(char *id, int count) {
  int i;              //This is an automatic variable on the thread's private stack
  for(i=1;i<=count;i++) {
    printf("%s i=%d\n",id,i);
    //printf("%s ",id);  fflush(stdout);  cpuSmoke(100);  printf("i=%d\n",i);
    fflush(stdout);   //Force the buffer to be written
    //pthread_yield();  //Manually yield the CPU core
    cpuSmoke(1000);
  }
}

void cpuSmoke(int uSec) {
  struct timeval t1;     //Starting time
  struct timeval t2;     //Current time
  long long now;

  //Get the start time in uSeconds
  gettimeofday(&t1,NULL);  //What time are we starting
  unsigned long long start= t1.tv_sec*1000000L + t1.tv_usec;  //Microseconds since epoch

  //Loop stalls the CPU core until uSec have elapsed
  do {
    gettimeofday(&t2,NULL);  //Current time
    now = t2.tv_sec*1000000L + t2.tv_usec;
  } while (now < start+uSec);
}
