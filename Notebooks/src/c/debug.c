#include <stdio.h>
#include <stdlib.h>






//in makefile
//use debug target
/*
	CFLAGS = -Wall -std=c99
	EXE=foo

	all: $(EXE)

	debug: CFLAGS += -DDEBUG -g -Og
	debug: $(EXE)
	
	$(EXE): foo.o
		gcc $^ -o $@
*/

//uncomment if in debug.h
//#ifdef DEBUG
#define DPRINT(s) printf("DEBUG: %s\n", s)
//#else
//#define DPRINT(s)
//#endif

int main(){
	//Example usage
	DPRINT("Entering a string/function foo!");
	//This is expanded into printf("DEBUG: %s\n", "Enetering a string/function foo!")
}
