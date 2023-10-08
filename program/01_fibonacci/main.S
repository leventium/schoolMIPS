

            .text

start:      move    $t0, $0
            lw      $t1, 0x1001beb4
            move    $v0, $t1

fibonacci:  addu    $t0, $t0, $t1
            move    $v0, $t0
            sw      $v0, 0x1001beb0
            addu    $t1, $t0, $t1
            move    $v0, $t1
            sw      $v0, 0x1001beb0
            beqz    $0,  fibonacci
