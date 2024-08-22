/* ====================================================
#
#   Author        : jxd
#   Email         : genesisjxd@gmail.com
#   File Name     : sysinfo.c
#   Create Time   : 2024-08-21 22:34:01
#   Describe      : add a system call that collects information about the running system
#
#   Last Modified : 2024-08-21 22:34:58
# ====================================================*/

#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"
#include "sysinfo.h"

extern uint64 freemem();
extern uint32 num_proc();

uint64 sys_sysinfo(void) {
    struct sysinfo info;
    struct proc* p = myproc();

    uint64 addr;
    if (argaddr(0, &addr) < 0) return -1;

    info.freemem = freemem();
    info.nproc = num_proc();

    if (copyout(p->pagetable, addr, (char*)&info, sizeof(info)) < 0)
        return -1;

    return 0;
}
