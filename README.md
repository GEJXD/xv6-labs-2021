## System call tracing (moderate)

自己实现一个系统调用，能够追踪打印其他系统调用。

看完要求后完全是懵的，寻思这不会lab2就要徒手撸汇编什么的吧。然后
仔细看了看`hints`加上其他人的提示，才知道是在内核中修改。。。

简单说一下`xv6`执行系统调用的过程。所有的系统调用都有一个标识符，
定义在`kernel/syscall.h`文件里面:

```c++
#define SYS_fork    1
#define SYS_exit    2
#define SYS_wait    3
#define SYS_pipe    4
#define SYS_read    5
#define SYS_kill    6
#define SYS_exec    7
#define SYS_fstat   8
#define SYS_chdir   9
#define SYS_dup    10
#define SYS_getpid 11
#define SYS_sbrk   12
#define SYS_sleep  13
#define SYS_uptime 14
#define SYS_open   15
#define SYS_write  16
#define SYS_mknod  17
#define SYS_unlink 18
#define SYS_link   19
#define SYS_mkdir  20
#define SYS_close  21
```

之后在各个相应的文件中实现单独的系统调用函数，接口声明在`user/user.h`
中，并且复写一次声明在`kernel/syscall.c`文件中。类似的还有`user/usys.pl`
文件。

当`xv6`需要执行系统调用的时候，系统首先执行`ecall syscall_num`指令，
其中syscall_num为需要执行的系统调用编号，操作系统跳转到内核态。

最后系统执行`kernel/syscall.c`中的`syscall`函数来调用对应的系统调用。

由于所有的系统调用都是通过`syscall`来调用的，所以我们直接在`syscall`中
编写输出的代码即可。

首先根据提示，在相应文件里面添加`sys_trace`的存根。大部分东西都在`hints`
里面提到了。

好像只需要在`kernel/syscall.c`中对应的代码块中添加：

```C
extern uint64 sys_sysinfo(void);

// 在*syscalls[]()数组中添加下面一项
[SYS_trace] sys_trace,

// 由于还要输出系统调用名字，在写一个数组，把所有系统调用名字
// 放进去。
static char *syscall_name[] = {
    "#", // to make index start from 1;
    "fork", "exit", "wait", "pipe", "read", "kill", "exec",
    "fstat", "chdir", "dup", "getpid", "sbrk", "sleep", "uptime",
    "open", "write", "mknod", "unlink", "link", "mkdir", "close",
    "trace"
};
```

在`kernel/sysproc.c`中添加:

```C
// lab2 - trace system call: hint 3
// add a sys_trace() function in kernel/sysproc.c
uint64 sys_trace() {
  int n;
  if (argint(0, &n) < 0) {
    return -1;
  }

  struct proc *p = myproc();
  p->trace_mask = n;

  return 0;
}
```

在`kernel/proc.h`中的`proc`结构体中添加新的成员变量：`uint 64 trace_mask`

在`kernel/fork`中的`fork`函数添加：`np->trace_mask = p->trace_mask`;

在'kernel/syscall.c'中的`syscall`函数添加响应的输出：

```C
if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
        p->trapframe->a0 = syscalls[num]();
        uint32 trace_mask = p->trace_mask;
        if  ((trace_mask >> num) & 1) {
          printf("%d: syscall %s -> %d\n", p->pid, syscall_name[num], p->trapframe->a0);
        }
    } else {
        printf("%d %s: unknown sys call %d\n", p->pid, p->name, num);
        p->trapframe->a0 = -1;
    }
```

然后发现所有前几个例子能正常追踪了。但是`grep hello README`也
依然输出了最终结果。经过debug发现，在`kernel/proc.c`文件中的`freeproc`
函数中，需要把`p->trace_mask`清零。

```C
    p->trace_mask = 0;
```

然后就能正常tracing系统调用了。

## sysinfo (moderate)

先按照上一个任务的方法加入一个 sysinfo 系统调用. 这里在 kernel 文件夹下再写一个 sysinfo.c 来实现这个系统调用. 在 Makefile 的 OBJS 加入 $K/sysinfo.o \.

`sysinfo.c`如下：

```C
#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "stat.h"
#include "spinlock.h"
#include "proc.h"
#include "sysinfo.h"

extern uint64 freemem();
extern uint64 num_proc();

int copy_sysinfo(struct sysinfo *info, uint64 addr) {
  struct proc *p = myproc();
  if (copyout(p->pagetable, addr, (char *)info, sizeof(*info)) < 0)
    return -1;

  return 0;
}

uint64 sys_sysinfo(void) {
  struct sysinfo info;
  uint64 info_addr;
  if (argaddr(0, &info_addr) < 0)
    return -1;

  info.freemem = freemem();
  info.nproc = num_proc();

  return copy_sysinfo(&info, info_addr);
}
```

看`sys_fstat()`函数就能大概知道为什么要这么写。这样就把内核态的
一个`sysinfo`结构体拷贝出来了。

然后是`freemem()`和`num_proc()`。

在`kernel/kalloc.c`中添加：

```C
// lab2 - sysinfo system call:
// return the number of bytes of free memory.
uint64 freemem() {
  struct run *r;
  acquire(&kmem.lock);
  r = kmem.freelist;

  uint64 free_size = 0;
  while (r) {
    if (!r) break;
    free_size += PGSIZE;
    r = r->next;
  }

  release(&kmem.lock);

  return free_size;
}
```

翻阅`kalloc.c`之前的代码可以知道，`kmem`里面维护了一个空闲内存的链表，
遍历这个链表就知道有多少页面是空闲的。累加页面大小`PGSIZE`即可。

在`kernel/proc.c`中添加：

```C
// lab2 - sysinfo system call
// return the number of processes whose state is not UNUSED
uint64 num_proc() {
  struct proc *p;
  uint64 n = 0;

  for (p = proc;p < &proc[NPROC];p ++) {
    if (p->state != UNUSED)
      n += 1;
  }

  return  n;
}
```

翻`procdump`函数可以知道，`proc`数组中存放的是所有进程控制块的地址，
所以遍历`proc`即可。

