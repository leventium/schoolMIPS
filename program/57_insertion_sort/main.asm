# void insertion_sort(int* arr, int len) {
#     int i = 0;
#     while (i < len) {
#         int mem = arr[i];
#         int j = i - 1;
#         while (j >= 0 && mem < arr[j]) {
#             arr[j+1] = arr[j];
#             j--;
#         }
#         arr[j+1] = mem;
#         i++;
#     }
# }

.text
start:
    li $t1, 0                   # i = 0
    li $s0, 64                  # len = 16

outer:
    beq $t1, $s0, outer_end     # if (i == len) goto outer_end
    lw $t0, ($t1)               # mem = arr[i]
    addi $t2, $t1, -4           # j = i - 1


inner:
    sle $t6, $zero, $t2         #                                 --  t6 = (0 <= j) ? 1 : 0
    lw $t7, ($t2)               #                                 --  tmp = arr[j]
    slt $t5, $t0, $t7           # while (j >= 0 && mem < arr[j])  --  t5 = (mem < tmp) ? 1 : 0
    and $t5, $t5, $t6           #                                 --  t5 = t5 & t6
    beq $t5, $zero, inner_end   #                                 --  if (t5 == 0) goto inner_end
    lw $t7, ($t2)               # tmp = arr[j]
    sw $t7, 4($t2)              # arr[j+i] = tmp
    addi $t2, $t2, -4           # j = j - 1
    beqz $zero, inner           # goto inner
inner_end:

    sw $t0, 4($t2)              # arr[j+1] = mem
    add $t1, $t1, 4             # i = i + 1
    beqz $zero, outer           # goto outer
outer_end:

end:
    beqz $zero, end             # while (1)
