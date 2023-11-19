TARGET:= m1p1

all:
	arm-linux-gnueabi-gcc $(TARGET).s main.c -o $(TARGET)
