# lab3 - page table

页表相关

## Speed up system calls (easy)

简单说一下要我们干什么：查询进程PID时，需要保存当前用户进程的数据，切换到内核
态，调用`getpid()`函数后把结果传回到用户态。

由于`PID`在进程创建开始就已经确定了，所以可以使用一块内核态和用户态
共享的只读的内存，这样就可以直接在用户态读取了。

我们只需要用页表映射到这块内存即可。

开始这个实验之前，强烈建议先看看`kernel/proc.c`中的`allocproc`函数、
`freeproc`函数、`proc_pagetable`函数, 和`user/ulib.c`中的`ugetpid`函数。

### `allocproc()`:

首先就是一个循环，遍历所有进程，遇到没分配的进程(也就是`state = UNUSED`),
然后跳转到found。

found里面就是分配内存给`proc`里的一些部分。
```C
if ((p->trapframe = (struct trapframe *)kalloc()) == 0) {
        freeproc(p);
        release(&p->lock);
        return 0;
}

p->pagetable = proc_pagetable(p);
    if (p->pagetable == 0) {
        freeproc(p);
        release(&p->lock);
        return 0;
}
```

### `freeproc()`：
就是把`allocproc`里面分配的内存都销毁。没什么好说的。
需要注意的就是，`trapframe`除了直接销毁外，还需要把页表里面的映射
也一起取消(在`proc_freepagetable()`函数)。

### `proc_pagetable()`:

首先使用`uvmcreate`创建一个页表，然后使用`mappages`来建立虚拟内存到
物理内存的映射。

```C
pagetable_t pagetable;

// An empty page table.
pagetable = uvmcreate();
if (pagetable == 0)
    return 0;

 // map the trapframe just below TRAMPOLINE, for trampoline.S.
if (mappages(pagetable, TRAPFRAME, PGSIZE, (uint64)(p->trapframe),
             PTE_R | PTE_W) < 0) {
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    uvmfree(pagetable, 0);
    return 0;
}
```

可以看到，映射的物理地址是`proc`里面的实例，所以显然完我们需要在
`struct proc`里新建一个成员变量。


### ugetpid()

这个函数很简单，就两行。首先从虚拟地址为`USYSCALL`的内存中读取`uysycall`，
然后直接从`usyscall`中读取出`pid`。很显然，我们需要在`proc_pagetable`中
调用`mappages()`来建立这个映射。

### solution
在`kernel/proc.h`的`struct proc`添加成员变量：
```C
struct proc {
    struct usyscall *usyspage;
}
```

在`kernel/proc.c`中的`allocproc`中给`p->usyspage`分配空间并初始化：
```C
// lab3 - execcise 1 - hint 2
// Allocate a usyscall page
if ((p->usyspage = (struct usyscall *)kalloc()) == 0) {
    freeproc(p);
    release(&p->lock);
    return 0;
}
p->usyspage->pid = p->pid;
```

在`proc_pagetable`中建立页表映射:
```C
 // lab3 - exercise 1 - hint 1 & hint 2
// map USYSCALL to struct usyscall, and
// initialize it to PID of the current process
if (mappages(pagetable, USYSCALL, PGSIZE, (uint64)(p->usyspage)
             , PTE_R | PTE_U) < 0) {
    uvmunmap(pagetable, USYSCALL, 1, 0);
    uvmfree(pagetable, 0);
    return 0;
}
```

然后在`freeproc`中销毁内存：
```C
if (p->usyspage)
    kfree((void*)p->usyspage);
p->usyspage = 0;
```

在`proc_freepagetable`清空页表映射:
```C
uvmunmap(pagetable, USYSCALL, 1, 0);
```


