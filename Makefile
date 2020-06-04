.PHONY: all clean debug

ASFLAGS = 
LDFLAGS = --static

all: clean exit show_env

debug: ASFLAGS += --gdwarf-2
debug: clean show_env exit

exit:
	as $(ASFLAGS) -o exit.o -c exit.s
	ld $(LDFLAGS) -o exit exit.o

show_env:
	as $(ASFLAGS) -o show_env.o -c show_env.s
	ld $(LDFLAGS) -o show_env show_env.o

clean:
	rm -f exit exit.o
	rm -f show_env show_env.o
