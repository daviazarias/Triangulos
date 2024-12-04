NOME=triang

FONTE=$(wildcard *.s)

OBJ=$(FONTE:.s=.o)

CC=as
LINKER=ld

all: $(NOME)

$(NOME): $(OBJ)
	$(LINKER) $^ -o $@

%.o: %.s
	$(CC) $< -o $@

clean:
	rm *.o $(NOME)