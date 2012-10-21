# INSTALL INSTRUCTIONS: save as ~/.gdbinit
#
# DESCRIPTION: A user-friendly gdb configuration file, for x86/x86_64 and ARM platforms.
#
# REVISION : 8.0.2 (31/07/2012)
#
# CONTRIBUTORS: mammon_, elaine, pusillus, mong, zhang le, l0kit,
#               truthix the cyberpunk, fG!, gln
#
# FEEDBACK: http://reverse.put.as - reverser@put.as
#
# NOTES: 'help user' in gdb will list the commands/descriptions in this file
#        'context on' now enables auto-display of context screen
#
# MAC OS X NOTES: If you are using this on Mac OS X, you must either attach gdb to a process
#                 or launch gdb without any options and then load the binary file you want to analyse with "exec-file" option
#                 If you load the binary from the command line, like $gdb binary-name, this will not work as it should
#                 For more information, read it here http://reverse.put.as/2008/11/28/apples-gdb-bug/
#
# UPDATE: This bug can be fixed in gdb source. Refer to http://reverse.put.as/2009/08/10/fix-for-apples-gdb-bug-or-why-apple-forks-are-bad/
#         and http://reverse.put.as/2009/08/26/gdb-patches/ (if you want the fixed binary for i386)
#
#         An updated version of the patch and binary is available at http://reverse.put.as/2011/02/21/update-to-gdb-patches-fix-a-new-bug/
#
# iOS NOTES: iOS gdb from Cydia (and Apple's) suffer from the same OS X bug.
#			 If you are using this on Mac OS X or iOS, you must either attach gdb to a process
#            or launch gdb without any options and then load the binary file you want to analyse with "exec-file" option
#            If you load the binary from the command line, like $gdb binary-name, this will not work as it should
#            For more information, read it here http://reverse.put.as/2008/11/28/apples-gdb-bug/
#
# CHANGELOG: (older changes at the end of the file)
#
#   Version 8.0.2 (31/07/2012)
#     - Merge pull request from mheistermann to support local modifications in a .gdbinit.local file
#     - Add a missing opcode to the stepo command
#
#   Version 8.0.1 (23/04/2012)
#     - Small bug fix to the attsyntax and intelsyntax commands (changing X86 flavor variable was missing)
#
#   Version 8.0 (13/04/2012)
#     - Merged x86/x64 and ARM versions
#     - Added commands intelsyntax and attsyntax to switch between x86 disassembly flavors
#     - Added new configuration variables ARM, ARMOPCODES, and X86FLAVOR
#     - Code cleanups and fixes to the indentation
#     - Bug fixes to some ARM related code
#     - Added the dumpmacho command to memory dump the mach-o header to a file
#
#   TODO:
#

# __________________gdb options_________________

# set to 0 if you have problems with the colorized prompt - reported by Plouj with Ubuntu gdb 7.2
set $COLOUREDPROMPT = 1
# Colour the first line of the disassembly - default is green, if you want to change it search for
# SETCOLOUR1STLINE and modify it :-)
set $SETCOLOUR1STLINE = 0
# set to 0 to remove display of objectivec messages (default is 1)
set $SHOWOBJECTIVEC = 1
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
set $SKIPSTEP = 1
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

# __________________end gdb options_________________
#

if $COLOUREDPROMPT == 1
   	set prompt \033[31mgdb$ \033[0m
end

source ~/.gdb/setup
source ~/.gdb/window
source ~/.gdb/cpu
source ~/.gdb/data
source ~/.gdb/process
source ~/.gdb/datawin
source ~/.gdb/dumpjump
source ~/.gdb/patch
source ~/.gdb/tracing
source ~/.gdb/misc
source ~/.gdb/info
source ~/.gdb/tips

# Configuration options specific to local machine. This file is not in the
# repository.
source ~/.gdbinit.local

#EOF

# Older change logs:
#
#   Version 7.4.4 (02/01/2012)
#     - Added the "skip" command. This will jump to the next instruction after EIP/RIP without executing the current one.
#       Thanks to @bSr43 for the tip to retrieve the current instruction size.
#
#	Version 7.4.3 (04/11/2011)
#	  - Modified "hexdump" command to support a variable number of lines (optional parameter)
#	  - Removed restrictions on type of addresses in the "dd" command - Thanks to Plouj for the warning :-)
#	   I don't know what was the original thinking behind those :-)
#	  - Modified the assemble command to support 64bits - You will need to recompile nasm since the version shipped with OS X doesn't supports 64bits (www.nasm.us).
#	   Assumes that the new binary is installed at /usr/local/bin - modify the variable at the top if you need so.
#	   It will assemble based on the target arch being debugged. If you want to use gdb for a quick asm just use the 32bits or 64bits commands to set your target.
#      Thanks to snare for the warning and original patch :-)
#	  - Added "asm" command - it's a shortcut to the "assemble" command.
#	  - Added configuration variable for colorized prompt. Plouj reported some issues with Ubuntu's gdb 7.2 if prompt is colorized.
#
#   Version 7.4.2 (11/08/2011)
#    Small fix to a weird bug happening on FreeBSD 8.2. It doesn't like a "if(" instruction, needs to be "if (". Weird!
#     Many thanks to Evan for reporting and sending the patch :-)
#    Added the ptraceme/rptraceme commands to bypass PTRACE_TRACME anti-debugging technique.
#     Grabbed this from http://falken.tuxfamily.org/?p=171
#	  It's commented out due to a gdb problem in OS X (refer to http://reverse.put.as/2011/08/20/another-patch-for-apples-gdb-the-definecommands-problem/ )
#	  Just uncomment it if you want to use in ptrace enabled systems.
#
#   Version 7.4.1 (21/06/2011) - fG!
#    Added patch sent by sbz, more than 1 year ago, which I forgot to add :-/
#     This will allow to search for a given pattern between start and end address.
#     On sbz words: "It's usefull to find call, ret or everything like that." :-)
#    New command is "search"
#
#   Version 7.4 (20/06/2011) - fG!
#    When registers change between instructions the colour will change to red (like it happens in OllyDBG)
#     This is the default behavior, if you don't like it, modify the variable SHOWREGCHANGES
#    Added patch sent by Philippe Langlois
#     Colour the first disassembly line - change the setting below on SETCOLOUR1STLINE - by default it's disabled
#
#	Version 7.3.2 (21/02/2011) - fG!
#	  Added the command rint3 and modified the int3 command. The new command will restore the byte in previous int3 patch.
#
# 	Version 7.3.1 (29/06/2010) - fG!
#	  Added enablelib/disablelib command to quickly set the stop-on-solib-events trick
#	  Implemented the stepoh command equivalent to the stepo but using hardware breakpoints
#	  More fixes to stepo
#
#	Version 7.3 (16/04/2010) - fG!
#	  Support for 64bits targets. Default is 32bits, you should modify the variable or use the 32bits or 64bits to choose the mode.
#     	  I couldn't find another way to recognize the type of binary… Testing the register doesn't work that well.
#	  TODO: fix objectivec messages and stepo for 64bits
#   Version 7.2.1 (24/11/2009) - fG!
#	  Another fix to stepo (0xFF92 missing)
#
#   Version 7.2 (11/10/2009) - fG!
#	  Added the smallregisters function to create 16 and 8 bit versions from the registers EAX, EBX, ECX, EDX
#	  Revised and fixed all the dumpjump stuff, following Intel manuals. There were some errors (thx to rev who pointed the jle problem).
#	  Small fix to stepo command (missed a few call types)
#
#   Version 7.1.7 - fG!
#     Added the possibility to modify what's displayed with the context window. You can change default options at the gdb options part. For example, kernel debugging is much slower if the stack display is enabled...
#     New commands enableobjectivec, enablecpuregisters, enablestack, enabledatawin and their disable equivalents (to support realtime change of default options)
#     Fixed problem with the assemble command. I was calling /bin/echo which doesn't support the -e option ! DUH ! Should have used bash internal version.
#     Small fixes to colours...
#     New commands enablesolib and disablesolib . Just shortcuts for the stop-on-solib-events fantastic trick ! Hey... I'm lazy ;)
#     Fixed this: Possible removal of "u" command, info udot is missing in gdb 6.8-debian . Doesn't exist on OS X so bye bye !!!
#     Displays affected flags in jump decisions
#
#   Version 7.1.6 - fG!
#     Added modified assemble command from Tavis Ormandy (further modified to work with Mac OS X) (shell commands used use full path name, working for Leopard, modify for others if necessary)
#     Renamed thread command to threads because thread is an internal gdb command that allows to move between program threads
#
#   Version 7.1.5 (04/01/2009) - fG!
#     Fixed crash on Leopard ! There was a If Else condition where the else had no code and that made gdb crash on Leopard (CRAZY!!!!)
#     Better code indention
#
#   Version 7.1.4 (02/01/2009) - fG!
#     Bug in show objective c messages with Leopard ???
#     Nop routine support for single address or range (contribution from gln [ghalen at hack.se])
#     Used the same code from nop to null routine
#
#   Version 7.1.3 (31/12/2008) - fG!
#     Added a new command 'stepo'. This command will step a temporary breakpoint on next instruction after the call, so you can skip over
#     the call. Did this because normal commands not always skip over (mainly with objc_msgSend)
#
#   Version 7.1.2 (31/12/2008) - fG!
#     Support for the jump decision (will display if a conditional jump will be taken or not)
#
#   Version 7.1.1 (29/12/2008) - fG!
#     Moved gdb options to the beginning (makes more sense)
#     Added support to dump message being sent to msgSend (easier to understand what's going on)
#
#   Version 7.1
#     Fixed serious (and old) bug in dd and datawin, causing dereference of
#     obviously invalid address. See below:
#     gdb$ dd 0xffffffff
#     FFFFFFFF : Cannot access memory at address 0xffffffff
#
#   Version 7.0
#     Added cls command.
#     Improved documentation of many commands.
#     Removed bp_alloc, was neither portable nor usefull.
#     Checking of passed argument(s) in these commands:
#       contextsize-stack, contextsize-data, contextsize-code
#       bp, bpc, bpe, bpd, bpt, bpm, bhb,...
#     Fixed bp and bhb inconsistencies, look at * signs in Version 6.2
#     Bugfix in bhb command, changed "break" to "hb" command body
#     Removed $SHOW_CONTEXT=1 from several commands, this variable
#     should only be controlled globally with context-on and context-off
#     Improved stack, func, var and sig, dis, n, go,...
#     they take optional argument(s) now
#     Fixed wrong $SHOW_CONTEXT assignment in context-off
#     Fixed serious bug in cft command, forgotten ~ sign
#     Fixed these bugs in step_to_call:
#       1) the correct logging sequence is:
#          set logging file > set logging redirect > set logging on
#       2) $SHOW_CONTEXT is now correctly restored from $_saved_ctx
#     Fixed these bugs in trace_calls:
#       1) the correct logging sequence is:
#          set logging file > set logging overwrite >
#          set logging redirect > set logging on
#       2) removed the "clean up trace file" part, which is not needed now,
#          stepi output is properly redirected to /dev/null
#       3) $SHOW_CONTEXT is now correctly restored from $_saved_ctx
#     Fixed bug in trace_run:
#       1) $SHOW_CONTEXT is now correctly restored from $_saved_ctx
#     Fixed print_insn_type -- removed invalid semicolons!, wrong value checking,
#     Added TODO entry regarding the "u" command
#     Changed name from gas_assemble to assemble_gas due to consistency
#     Output from assemble and assemble_gas is now similar, because i made
#     both of them to use objdump, with respect to output format (AT&T|Intel).
#     Whole code was checked and made more consistent, readable/maintainable.
#
#   Version 6.2
#     Add global variables to allow user to control stack, data and code window sizes
#     Increase readability for registers
#     Some corrections (hexdump, ddump, context, cfp, assemble, gas_asm, tips, prompt)
#
#   Version 6.1-color-user
#     Took the Gentoo route and ran sed s/user/user/g
#
#   Version 6.1-color
#     Added color fixes from
#       http://gnurbs.blogsome.com/2006/12/22/colorizing-mamons-gdbinit/
#
#   Version 6.1
#     Fixed filename in step_to_call so it points to /dev/null
#     Changed location of logfiles from /tmp  to ~
#
#   Version 6
#     Added print_insn_type, get_insn_type, context-on, context-off commands
#     Added trace_calls, trace_run, step_to_call commands
#     Changed hook-stop so it checks $SHOW_CONTEXT variable
#
#   Version 5
#     Added bpm, dump_bin, dump_hex, bp_alloc commands
#     Added 'assemble' by elaine, 'gas_asm' by mong
#     Added Tip Topics for aspiring users ;)
#
#   Version 4
#     Added eflags-changing insns by pusillus
#     Added bp, nop, null, and int3 patch commands, also hook-stop
#
#   Version 3
#     Incorporated elaine's if/else goodness into the hex/ascii dump
#
#   Version 2
#     Radix bugfix by elaine
