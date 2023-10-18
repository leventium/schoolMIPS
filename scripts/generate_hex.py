from random import choice

with open("ram.hex", "w") as file:
    for _ in range(16):
        file.write('000000')
        file.write(choice("0123456789ABCDEF") + choice("0123456789ABCDEF"))
        file.write("\n")
