/* ====================================================
#
#   Author        : jxd
#   Email         : genesisjxd@gmail.com
#   File Name     : sleep.c
#   Create Time   : 2024-08-07 20:58:29
#   Describe      : 6.S081 lab utils : sleep (easy)
#
#   Last Modified : 2024-08-08 21:53:50
# ====================================================*/

#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char* argv[]) {
  if (argc != 2) {
    fprintf(2, "Usage: sleep <ticks>\n");
    exit(1);
  }
  int time = atoi(argv[1]);
  sleep(time);

  exit(0);
}
