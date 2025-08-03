#include <stdio.h>
#include <kernel/tty.h>

void kernel_main(void) {
    terminal_initialize();
    puts("Hello, kernel World!");
    for (int i = 0; i < 20; i++) {
        puts("e");
    }
    puts("The Bottom");
    puts("The Bottom");
    puts("The Bottom");
    puts("The Bottom");
    terminal_scroll(3);
}