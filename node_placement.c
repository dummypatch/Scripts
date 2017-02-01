#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <numa.h>
#include <sys/types.h>

//#include <sys/types.h>		// struct bitmask*
#define MAKE_IT_DOUBLE

#define NR_NODES (8)		// DELL R815 has 8 nodes
#define NR_AVAIL_NODES (3)			// only for 4 nodes experiment
#define NR_CPUS_PER_NODE (4)	// 4 cpus per a node

#define CACHE_LINE_SIZE (64)
//#define BUF_SIZE ( 1024*1024*64 )		// original
#ifdef MAKE_IT_DOUBLE
#define BUF_SIZE ( 1 *1024*1024 )		// - L2 private cache size is 2MB per core in Opteron 6320
										// - just want to make sure that each thread don't need memory access,.
										// but clean cache.
										// - We can get the last private cache size within "/sys/devices/system/node/node0/cpu0/cache/index2"
										// Because this program assume that single L2 cache are aggressively accssed by two threads, thus
										// each thread just need half size(in this case :  1MB) of  the L2 $ size


#else //MAKE_IT_DOUBLE
#define BUF_SIZE ( 2 *1024*1024 )		// - L2 private cache size is 2MB per core in Opteron 6320
										// - just want to make sure that each thread don't need memory access,.
										// but clean cache.
										// - We can get the last private cache size within "/sys/devices/system/node/node0/cpu0/cache/index2"
#endif // MAKE_IT_DOUBLE

unsigned int cpuid[NR_NODES][NR_CPUS_PER_NODE] =
	{{0,1,2,3},			// for NODE 0
	 {4,5,6,7},			// for NODE 1
	 {16,17,18,19},		// for NODE 2
	 {20,21,22,23},		// for NODE 3
	 {24,25,26,27},		// for NODE 4
	 {28,29,30,31},		// for NODE 5
	 {8,9,10,11},		// for NODE 6
	 {12,13,14,15}};	// for NODE 7
	

unsigned long long len = BUF_SIZE;
unsigned long long cache_line_size = 64;
#ifdef MAKE_IT_DOUBLE
uint64_t iter=90000;		// 10 ~ 11 seconds
#else // MAKE_IT_DOUBLE
uint64_t iter=30000;		// 10 ~ 11 seconds
#endif //MAKE_IT_DOUBLE


struct thread_args{
	uint8_t *arr;
	unsigned long long idx;
	int nodeid;
	int cpuid;
	unsigned long long junk;
};

void *thread_func(void *args){
	struct thread_args *th_arg = (struct thread_args *)args;
	uint8_t *arr = NULL;
	unsigned long long junk;
	unsigned long long kk,ii,idx = 0;
	unsigned int nodeid = (*th_arg).nodeid;
	nodemask_t cur_nodemask;
	nodemask_zero(&cur_nodemask);
	idx = (*th_arg).idx;
	nodemask_set_compat(&cur_nodemask,nodeid);

	do{
		nodemask_t temp_nodemask;
		numa_run_on_node_mask_compat(&cur_nodemask);
		numa_set_membind_compat(&cur_nodemask);
		temp_nodemask = numa_get_run_node_mask_compat();
		
		if(nodemask_equal(&cur_nodemask,&temp_nodemask)){
			temp_nodemask = numa_get_membind_compat();
			if(nodemask_equal(&cur_nodemask,&temp_nodemask)){
				temp_nodemask = numa_get_membind_compat();
				break;
			}
		}
	}while(0);

	fprintf(stdout,"tid %lu is placed on node %d\n", (unsigned long)pthread_self(), nodeid);

	(*th_arg).arr = (uint8_t*)malloc(BUF_SIZE);
	arr = (*th_arg).arr;

	for(kk=0;kk<iter;kk++)
		for(ii = 0; ii < idx ; ii+=CACHE_LINE_SIZE)
			junk += arr[ii];

	th_arg->junk = junk;
}


void print_thread_id(pthread_t id)
{
	size_t i;
	for (i = sizeof(i); i; --i)
		printf("%02x", *(((unsigned char*) &id) + i - 1));
}



int main(int argc, char ** argv)
{
	long long unsigned index = BUF_SIZE / sizeof(long long unsigned);
	long long unsigned ii,jj,count,junk,total_sum=0;
	unsigned int num_threads = NR_AVAIL_NODES * NR_CPUS_PER_NODE ;
#ifdef MAKE_IT_DOUBLE
	pthread_t busy_threads[num_threads*2];	//  make it double 
	struct thread_args th_args[num_threads*2];
#else // MAKE_IT_DOUBLE
	pthread_t busy_threads[num_threads];
	struct thread_args th_args[num_threads];
#endif // MAKE_IT_DOUBLE
	nodemask_t nodelist;
	nodemask_zero(&nodelist);




	if (argc > 1 && argc <= 4){
		if(0 <= atoi(argv[1]) && atoi(argv[1]) < NR_NODES &&
			0 <= atoi(argv[2]) && atoi(argv[2]) < NR_NODES &&
			0 <= atoi(argv[3]) && atoi(argv[3]) < NR_NODES){
			nodemask_set_compat(&nodelist, atoi(argv[1]));
			nodemask_set_compat(&nodelist, atoi(argv[2]));
			nodemask_set_compat(&nodelist, atoi(argv[3]));
		}else{
			fprintf(stdout,"[ERROR] 0 <= node id < %d\n",NR_NODES);
			exit(EXIT_FAILURE);
		}
		fprintf(stdout,"nodelist : ");
		count = 0;
		for(ii=0;ii<NR_NODES;ii++){
			if(nodemask_isset_compat(&nodelist,ii)){
				fprintf(stdout,"%d(cpuid :  ",ii);
				for(jj=0;jj<NR_CPUS_PER_NODE;jj++){
					th_args[count].nodeid = ii;
					th_args[count].cpuid = cpuid[ii][jj];
					th_args[count].idx = len;
					th_args[count].junk = 0;
					th_args[count].arr = NULL;
					fprintf(stdout,"%d,",th_args[count].cpuid);
					count++;
				}
				fprintf(stdout,") ");
			}
		}

#ifdef MAKE_IT_DOUBLE
		for(ii=0;ii<NR_NODES;ii++){
			if(nodemask_isset_compat(&nodelist,ii)){
				fprintf(stdout,"second group %d(cpuid :  ",ii);
				for(jj=0;jj<NR_CPUS_PER_NODE;jj++){
					th_args[count].nodeid = ii;
					th_args[count].cpuid = cpuid[ii][jj];
					th_args[count].idx = len;
					th_args[count].junk = 0;
					th_args[count].arr = NULL;
					fprintf(stdout,"secound group %d,",th_args[count].cpuid);
					count++;
				}
			}
		}
#endif // MAKE_IT_DOUBLE

		fprintf(stdout,"\n");
	}else{
		fprintf(stdout,"USAGE :\n");
		fprintf(stdout,"\t\t$ %s busy_nodeid_1 busy_nodeid_2 busy_nodeid_3\n", argv[0]);
	}

	
#ifdef MAKE_IT_DOUBLE
	for(ii=0;ii<num_threads*2;ii++){
#else // MAKE_IT_DOUBLE
	for(ii=0;ii<num_threads;ii++){
#endif // MAKE_IT_DOUBLE
		pthread_create(&(busy_threads[ii]),NULL,thread_func,(void*)(&th_args[ii]));
	}

#ifdef MAKE_IT_DOUBLE
	for(ii=0;ii<num_threads*2;ii++){
#else // MAKE_IT_DOUBLE
	for(ii=0;ii<num_threads;ii++){
#endif // MAKE_IT_DOUBLE
		pthread_join(busy_threads[ii],NULL);
	}

#ifdef MAKE_IT_DOUBLE
	for(ii=0;ii<num_threads*2;ii++){
#else // MAKE_IT_DOUBLE
	for(ii=0;ii<num_threads;ii++){
#endif // MAKE_IT_DOUBLE
		junk += th_args[ii].junk;
		free(th_args[ii].arr);
	}
	printf("junk : %llu\n",junk);
	return 0;
}
