arm-none-eabi-as -mfloat-abi=softfp -march=armv7-a -mcpu=cortex-a9 -mfpu=neon-fp16 --gdwarf2 -o %cd%\build\main.o %cd%\main.s
arm-none-eabi-ld --script %cd%\build_arm.ld -e _start -u _start -o %cd%\build\main.elf %cd%\build\main.o
REM arm-none-eabi-ld -e _start -u _start -o %cd%\build\main.elf %cd%\build\main.o