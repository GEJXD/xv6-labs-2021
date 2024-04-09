# xv6-labs-2021
MIT 6.S081 2021的实验。

xv6是一个基于RISC-V的操作系统，提供了最基本的Unix-like系统内核，只包括基本的
内核加载、进程启动、文件系统等。课程要求在该基础上，实现新的系统调用、优化页表调用、
实现缓冲区锁、同步锁等。

一共11个实验，每个实验侧重点均不同，每个实验都在保证上一个实验功能能正常实现的基础上
进行，最终的操作系统包括了大部分常见的Linux内核功能。


## lab-1 Unix utilities
相关代码见[utils分支](https://github.com/GEJXD/xv6-labs-2021/tree/util).

实现思路见博客[MIT 6.S081 lab1：Unix utilities](https://gejxd.github.io/2024/02/25/MIT-6.S081-lab1-Unix%E5%AE%9E%E7%94%A8%E7%A8%8B%E5%BA%8F/)

## lab-2 System call
相关代码及解释见[syscall分支](https://github.com/GEJXD/xv6-labs-2021/tree/syscall)

思路见博客[MIT 6.S081 lab2：System Calls](https://gejxd.github.io/2024/02/25/MIT-6.S081-lab2-System%20Calls/)

## lab-3 Page tables
相关代码及解释见[pgtbl分支](https://github.com/GEJXD/xv6-labs-2021/tree/pgtbl).

思路见博客[MIT 6.S081 lab3：page tables_](https://gejxd.github.io/2024/03/13/MIT-6.S081-lab03/)
