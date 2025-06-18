ENTRY(_start)
MEMORY {
	ROM(rx) : ORIGIN = 0, LENGTH = 1M
	RAM(wx) : org = 0x00100000, len = 40M
}