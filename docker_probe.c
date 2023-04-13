#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <string.h>
#include <sys/capability.h>
#include <unistd.h>
// Driver code
int main()
{   
    // pid_t pid;
    // cap_t cap;
    // int pid = 1586414;
    // char buf[1024];
    // sprintf(buf, "getpcaps %d > cap_output.txt", pid);
    // system(buf);
	// cap = cap_get_pid(pid);
    // char foo[sizeof(cap_t)];
    // memcpy(foo, cap, sizeof cap);
    printf("PID = %d\n", pid);
    system("capsh --current");
    // printf("Foo = %s\n", cap);
    
    return 0;
}
