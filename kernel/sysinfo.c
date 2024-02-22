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
