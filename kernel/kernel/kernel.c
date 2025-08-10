#include <stdio.h>
#include <kernel/tty.h>

void kernel_main(void) {
    terminal_initialize();
    puts("Hello, kernel World!");
    for (int i = 0; i < 20; i++) {
        puts("e");
    }
    printf("The Bottom\n");
    printf("The Bottom\n");
    printf("\bc");
    printf("The Bottom\n");
    terminal_scroll(3);
}