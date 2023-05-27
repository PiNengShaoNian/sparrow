CC = gcc
# CFLAGS = -g -DDEBUG -lm -Wall -I object -I vm -I compiler -I parser -I include -I cli -I gc -W -Wstrict-prototypes -Wmissing-prototypes -Wsystem-headers -fgnu89-inline
CFLAGS = -g -lm -Wall -I object -I vm -I compiler -I parser -I include -I cli -I gc -W -Wstrict-prototypes -Wmissing-prototypes -Wsystem-headers -fgnu89-inline
TARGET = spr
DIRS = object include cli compiler parser vm gc
TEST_SRCS=$(wildcard tests/*.sp)
CFILES = $(foreach dir, $(DIRS),$(wildcard $(dir)/*.c))
OBJS = $(patsubst %.c,%.o,$(CFILES))
$(TARGET):$(OBJS)
	$(CC) -o $(TARGET) $(OBJS) $(CFLAGS)

test: $(TARGET)
	for i in $(TEST_SRCS); do echo $$i; ./$(TARGET) $$i; echo; done

clean:
	-$(RM) $(TARGET) $(OBJS)
r: clean $(TARGET)