CFLAGS  = -W -Wall -I.. -pthread -g -pipe $(COPT)

ifeq ($(OS),Windows_NT)
else
  UNAME_S := $(shell uname -s)
  DLL_FLAGS += -shared

  ifeq ($(UNAME_S),Linux)
    CFLAGS += -ldl
  endif

endif

all:
	$(CC) mongoose-with-server-closing-uri.c mongoose.c  -o mongoose $(CFLAGS)

MSVC    = ../../vc6
CL      = $(MSVC)/bin/cl
CLFLAGS = /MD /TC /nologo $(DBG) /W3 /DNO_SSL \
        /I$(MSVC)/include /I.. /Dsnprintf=_snprintf
LFLAGS  = /link /incremental:no /libpath:$(MSVC)/lib /machine:IX86

windows:
	$(CL) mongoose-with-server-closing-uri.c mongoose.c $(CLFLAGS) $(LFLAGS)

clean:
	rm -rf mongoose *.exe *.dSYM *.obj .*o
