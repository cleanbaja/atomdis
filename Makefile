CFLAGS = -O0 -g3 -Wall
SRC    = main.c datastructs.c indices.c
CC     = gcc


all: atomdis

atomdis: $(SRC:.c=.o)
	$(CC) -o atomdis $^


# Autogenerated files

datastructs_gen.c: atombios.h atombios_rev.h datastructs_factory.pl
	cat atombios.h atombios_rev.h | cpp | perl ./datastructs_factory.pl > datastructs_gen.c


# Clean

clean: _always_
	-rm -f *.o *.d
	-rm -f datastructs_gen.c

distclean: clean
	-rm -f *~
	-rm -f atomdis


# Depend

depend: _always_
	-rm -f *.d
	make dependfiles

dependfiles: $(SRC:.c=.d)

$(SRC:.c=.d): datastructs_gen.c
	gcc -MM -MF $@ $(@:.d=.c)

-include $(SRC:.c=.d)


# Special Flags + Dependencies

datastructs.o: CFLAGS += -Wno-unused

_always_:
	@true

#EOF
