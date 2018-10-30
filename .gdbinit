###
# Options

# set to 0 if you have problems with the colorized prompt - reported by Plouj with Ubuntu gdb 7.2
set $COLOUREDPROMPT = 0
# Colour the first line of the disassembly - default is green, if you want to change it search for
# SETCOLOUR1STLINE and modify it :-)
set $SETCOLOUR1STLINE = 0
# set to 0 to remove display of objectivec messages (default is 1)
set $SHOWOBJECTIVEC = 0
# set to 0 to remove display of cpu registers (default is 1)
set $SHOWCPUREGISTERS = 1
# set to 1 to enable display of stack (default is 0)
set $SHOWSTACK = 0
# set to 1 to enable display of data window (default is 0)
set $SHOWDATAWIN = 0
# set to 0 to disable coloured display of changed registers
set $SHOWREGCHANGES = 1
# set to 1 so skip command to execute the instruction at the new location
# by default it EIP/RIP will be modified and update the new context but not execute the instruction
set $SKIPEXECUTE = 0
# if $SKIPEXECUTE is 1 configure the type of execution
# 1 = use stepo (do not get into calls), 0 = use stepi (step into calls)
set $SKIPSTEP = 0
# show the ARM opcodes - change to 0 if you don't want such thing (in x/i command)
set $ARMOPCODES = 1
# x86 disassembly flavor: 0 for Intel, 1 for AT&T
set $X86FLAVOR = 0

set $displayobjectivec = 0

set confirm off
set verbose off

set output-radix 0x10
set input-radix 0x10

# These make gdb never pause in its output
set height 0
set width 0

set $SHOW_CONTEXT = 1
set $SHOW_NEST_INSN = 0

set $CONTEXTSIZE_STACK = 6
set $CONTEXTSIZE_DATA  = 8
set $CONTEXTSIZE_CODE  = 8

# Override configuration options defined above for the local machine. This file
# should never go into version control.
source ~/.gdbinit.local-pre

# Options
###

# without enclosing non-printing escape sequences with \[ \] will cause
# prompt be overwrited
# check http://stackoverflow.com/questions/19092488/custom-bash-prompt-is-overwriting-itself
if $COLOUREDPROMPT == 1
   	set prompt \001\033[31m\002gdb$ \001\033[0m\002
end

define make_uint8_pointer
    set logging redirect on
    x/1xb $arg1
    set $arg0 = $_
    #p/x $arg0
    set logging redirect off
end

define make_uint32_pointer
    set logging redirect on
    x/1xw $arg1
    set $arg0 = $_
    #p/x $arg0
    set logging redirect off
end

define derefer_uint8
    set logging redirect on
    x/1xb $arg1
    set $arg0 = *$_
    set logging redirect off
end

define derefer_uint16
    set logging redirect on
    x/1xh $arg1
    set $arg0 = *$_
    set logging redirect off
end

define derefer_uint32
    set logging redirect on
    x/1xw $arg1
    set $arg0 = *$_
    set logging redirect off
end

define write_uint8
    set logging redirect on
    x/1xb $arg0
    p *$_ = $arg1
    set logging redirect off
end
document write_uint8
Usage: write_int8 ADDR byte
end

define write_uint16
    set logging redirect on
    x/1xb $arg0
    p *$_ = $arg1
    set logging redirect off
end
document write_uint16
Usage: write_int16 ADDR byte
end

define write_uint32
    set logging redirect on
    x/1xb $arg0
    p *$_ = $arg1
    set logging redirect off
end
document write_uint32
Usage: write_int32 ADDR byte
end


###
# Command files

source ~/.gdb/setup.gdb
source ~/.gdb/cpu.gdb
source ~/.gdb/data.gdb

source ~/.gdb/window.gdb
source ~/.gdb/process.gdb
source ~/.gdb/datawin.gdb
source ~/.gdb/dumpjump.gdb
source ~/.gdb/patch.gdb
source ~/.gdb/tracing.gdb
source ~/.gdb/misc.gdb
source ~/.gdb/info.gdb
source ~/.gdb/tips.gdb
#source ~/.gdb/macsbug.gdb
source ~/.gdb/carbon.gdb
source ~/.gdb/profile.gdb

# The following is commented out because it caused errors last time for me (egall)
#source ~/.gdb/kgmacros.gdb

# Configuration options specific to local machine. This file should never go
# into version control.
source ~/.gdbinit.local

# Command files
###


###
# Hooks

define hook-run
  # Attempt to detect the target in case gdb was started with the executable
  # as an argument.
  setup-detect-target

  set logging overwrite on
  set logging on
end


define hook-file
  # Attempt to detect the target again since a new binary has been loaded.
  setup-detect-target

  set logging overwrite on
  set logging on
end


define hook-core-file
  # Attempt to detect the target again since a new core has been loaded.
  setup-detect-target

  set logging overwrite on
  set logging on
end


define hook-stop
  # Display instructions formats
  hookstopcpu

  # this makes 'context' be called at every BP/step
  if ($SHOW_CONTEXT > 0)
    context
  end
  if ($SHOW_NEST_INSN > 0)
    set $x = $_nest
    while ($x > 0)
      printf "\t"
      set $x = $x - 1
    end
  end
end

# Hooks
###
