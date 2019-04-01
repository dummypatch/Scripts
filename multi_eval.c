/*
 * copyright (c) wonjun song
 * all rights reserved.
 */
//    written by wonjun song

#define _gnu_source
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <pthread.h>
#include <sys/types.h>
#include <time.h>
//#include <sys/time.h>
#include <inttypes.h>
#include <unistd.h>
#include <sched.h>
//#include <numa.h>
//#include <numaif.h>
#include <signal.h>

#ifdef amd_config
#define max_core 4 // scal13 per socket
#define socket_num 1  // scal13 per socket
#define smt_on 1      // scal13 per socket
#define max_itr 5 // scal10 per socket
#else // amd_config
//#define max_core 12 // scal13 per socket
//#define max_core 40   // scal13 per socket
#define max_core 20   // scal13 per socket
#define socket_num 2  // scal13 per socket
#define smt_on 2      // scal13 per socket
#define max_itr 5 // scal10 per socket
#endif // amd_config

#define MAX_NR_PROG (8)	
#define MAX_BUF_SIZE (1000)
//shawn check
pthread_mutex_t mutx;
unsigned long global_check=0;
unsigned long done_all=0;

typedef struct thread_args {
	int prog_id;
	char** cmd;
    int cur_iter;
	int max_iter;
} thread_t;


uint64_t get_elapsed(struct timespec *start, struct timespec *end){
    uint64_t dur;
    if (start->tv_nsec > end->tv_nsec)
       //nano,  dur = (uint64_t)(end->tv_sec - 1 - start->tv_sec) * 1000000000 +  (1000000000 + end->tv_nsec - start->tv_nsec);
        dur = (uint64_t)(end->tv_sec - 1 - start->tv_sec) * 1000 + (1000 + (end->tv_nsec - start->tv_nsec)/1000000);
    else
       //nano,  dur = (uint64_t)(end->tv_sec - start->tv_sec) * 1000000000 + (end->tv_nsec - start->tv_nsec);
        dur = (uint64_t)(end->tv_sec - start->tv_sec) * 1000 + (end->tv_nsec - start->tv_nsec)/1000000;
    return dur;
}

void *process_gen(void *args){
	int ii;
	thread_t* thread_args = (thread_t*)args;
	char *shell = "/bin/sh";
	char **cmd = thread_args->cmd;
	int cur_iter = thread_args->cur_iter;
	int max_iter = thread_args->max_iter;
	int prog_id = thread_args->prog_id;
	struct timespec start,end;
	uint64_t nsdiff;
	uint64_t total_time = 0;
	for(;cur_iter<max_iter;cur_iter++){

		clock_gettime(CLOCK_REALTIME,&start);
		pid_t pid = fork();
		if(pid  < 0 ){	// fork fail
			perror("fork error\n");
			exit(1);
		}else if (pid ==0){ // child
			printf("PROGRAM EXECUTION CONTINUE : %s\n",cmd[2]);
			execvp(shell,cmd);
		}else{	// parent
			int status;
			waitpid(pid,&status,0);
			clock_gettime(CLOCK_REALTIME,&end);
			nsdiff = get_elapsed(&start,&end);
			printf("\"%s\"'s Execution Time %d trial  => %.2lf ms\n",cmd[2],cur_iter,(double)nsdiff);

			pthread_mutex_lock(&mutx);
			done_all = ((unsigned long)1 << prog_id) | done_all;
			pthread_mutex_unlock(&mutx);
			printf("done_all : %d\n",done_all);

			if(global_check == done_all){
				printf("Evaluation finishing..\n");
				kill(0,SIGKILL);
			}

		}
	}
}


static char* app_0[] = {"/bin/sh","-c","numactl --cpunodebind=0,1,6,7 ~/Workloads/CRONO/apps/bc/bc 16 65536 16" };
static char* app_1[] = {"/bin/sh","-c","numactl --cpunodebind=2,3,4,5 ~/Workloads/CRONO/apps/apsp/apsp 16 65536 16"};
static char* shell = "/bin/sh";
static char* shell_arg = "-c";
int main(int argc, char *argv[]) {
	int ii;
	int program_num = 0;
	program_num = argc - 1;
	if (program_num < 0) exit(0);
	printf("program_num : %d\n",program_num);
	char prog_name[MAX_NR_PROG][MAX_BUF_SIZE] = {0,};
	pthread_mutex_init(&mutx,NULL);

	for(ii=0;ii<program_num;ii++){
		strncpy(prog_name[ii],argv[ii+1],strlen(argv[ii+1]));
		printf("args[%d] : %s \n",ii,prog_name[ii]);
	}



	pthread_t threads[program_num];
	thread_t thread_args[program_num];
	char* cmd[program_num][4];
	for (ii=0;ii<program_num;ii++){
		thread_args[ii].prog_id = ii;
		//thread_args[ii].cmd = prog_name[ii];
		cmd[ii][0] = shell;
		cmd[ii][1] = shell_arg;
		cmd[ii][2] = prog_name[ii];
		cmd[ii][3] = 0;
		thread_args[ii].cmd = cmd[ii];
		thread_args[ii].cur_iter = 0;
		thread_args[ii].max_iter = 100000;
		printf("thread_args[%d] : cmd : %s, cur_iter : %d, max_iter : %d\n",ii,thread_args[ii].cmd[2], thread_args[ii].cur_iter,thread_args[ii].max_iter);
	}


	for(ii=0;ii<program_num;ii++){
		global_check = ((unsigned long)1 << (thread_args[ii].prog_id)) | global_check;
	}
	printf("global_check : %d\n",global_check);

	for(ii=0;ii<program_num;ii++){
		pthread_create(&(threads[ii]),NULL,process_gen, (void *)(&thread_args[ii]));
	}

	for(ii=0;ii<program_num;ii++){
		pthread_join(threads[ii],NULL);
	}

    return 0;

}
