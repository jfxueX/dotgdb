
# Kernel gdb macros
#
#  These gdb macros should be useful during kernel development in
#  determining what's going on in the kernel.
#
#  All the convenience variables used by these macros begin with $kgm_

set print asm-demangle on
set cp-abi gnu-v2

# This option tells gdb to relax its stack tracing heuristics
# Useful for debugging across stack switches
# (to the interrupt stack, for instance). Requires gdb-675 or greater.
set backtrace sanity-checks off

echo Loading Kernel GDB Macros package.  Type "help kgm" for more info.\n

define kgm
printf ""
echo  These are the gdb macros for kernel debugging.  Type "help kgm" for more info.\n
end

document kgm
| These are the kernel gdb macros.  These gdb macros are intended to be
| used when debugging a remote kernel via the kdp protocol.  Typically, you
| would connect to your remote target like so:
| 		 (gdb) target remote-kdp
| 		 (gdb) attach <name-of-remote-host>
|
| The following macros are available in this package:
|     showversion    Displays a string describing the remote kernel version
|
|     showalltasks   Display a summary listing of all tasks
|     showallthreads Display info about all threads in the system
|     showallstacks  Display the stack for each thread in the system
|     showcurrentthreads   Display info about the thread running on each cpu
|     showcurrentstacks    Display the stack for the thread running on each cpu
|     showallvm      Display a summary listing of all the vm maps
|     showallvme     Display a summary listing of all the vm map entries
|     showallipc     Display a summary listing of all the ipc spaces
|     showipcsummary     Display a summary listing of the ipc spaces of all tasks
|     showallrights  Display a summary listing of all the ipc rights
|     showallkexts   Display a summary listing of all loaded kexts (alias: showallkmods)
|     showallknownkexts   Display a summary listing of all kexts, loaded or not
|     showallbusyports    Display a listing of all ports with unread messages
|     showallprocessors   Display a listing of all psets and processors
|
|     showallclasses    Display info about all OSObject subclasses in the system
|     showobject        Show info about an OSObject - its vtable ptr and retain count, & more info for simple container classes.
|     showregistry      Show info about all registry entries in the current plane
|     showregistryprops Show info about all registry entries in the current plane, and their properties
|     showregistryentry Show info about a registry entry; its properties and descendants in the current plane
|     setregistryplane  Set the plane to be used for the iokit registry macros (pass zero for list)
|
|     setfindregistrystr  Set the encoded string for matching with
|                         findregistryentry or findregistryprop (created from
|                         strcmp_arg_pack64)
|     findregistryentry   Find a registry entry that matches the encoded string
|     findregistryentries Find all the registry entries that match the encoded string
|     findregistryprop    Search the registry entry for a property that matches
|                         the encoded string
|
|     showtask       Display info about the specified task
|     showtaskthreads      Display info about the threads in the task
|     showtaskstacks Display the stack for each thread in the task
|     showtaskvm     Display info about the specified task's vm_map
|     showtaskvme    Display info about the task's vm_map entries
|     showtaskipc    Display info about the specified task's ipc space
|     showtaskrights Display info about the task's ipc space entries
|     showtaskrightsbt Display info about the task's ipc space entries with back traces
|     showtaskbusyports    Display all of the task's ports with unread messages
|
|     showact	     Display info about a thread specified by activation
|     showactstack   Display the stack for a thread specified by activation
|
|     showmap	     Display info about the specified vm_map
|     showmapvme     Display a summary list of the specified vm_map's entries
|
|     showipc        Display info about the specified ipc space
|     showrights     Display a summary list of all the rights in an ipc space
|
|     showpid        Display info about the process identified by pid
|     showproc       Display info about the process identified by proc struct
|     showprocinfo   Display detailed info about the process identified by proc struct
|     showprocfiles  Given a proc_t pointer, display the list of open file descriptors
|     showproclocks  Given a proc_t pointer, display the list of advisory file locks
|     zombproc       Print out all procs in the zombie list
|     showproctree   Show all the processes in a hierarchical tree form
|     allproc        Print out all process in the system not in the zombie list
|     zombstacks     Print out all stacks of tasks that are exiting
|
|     showinitchild  Print out all processes in the system which are children of init process
|
|     showkext	     Display info about a kext (alias: showkmod)
|     showkextaddr   Given an address, display the kext and offset (alias: showkmodaddr)
|
|     dumpcallqueue  Dump out all the entries given a queue head
|
|     showallmtx     Display info about mutexes usage
|     showallrwlck   Display info about reader/writer locks usage
|
|     zprint         Display info about the memory zones
|     showioalloc    Display info about iokit allocations
|     paniclog       Display the panic log info
|
|     switchtoact    Switch to different context specified by activation
|     switchtoctx    Switch to different context
|     showuserstack  Display numeric backtrace of the user stack for an 
|     		     activation
|     showtaskuserstacks	 Display user stacks for a specified task
|     showuserregisters		 Display user registers for the specified thread
|     showtaskuserregisters		 Display user registers for the specified task
|
|     switchtouserthread Switch to the user context of the specified thread
|     resetstacks    Return to the original kernel context
|
|     resetctx       Reset context
|     resume_on      Resume when detaching from gdb
|     resume_off     Don't resume when detaching from gdb 
|
|     sendcore	     Configure kernel to send a coredump to the specified IP
|     sendsyslog     Configure kernel to send a system log to the specified IP
|     sendpaniclog   Configure kernel to send a panic log to the specified IP
|     disablecore    Configure the kernel to disable coredump transmission
|     getdumpinfo    Retrieve the current remote dump parameters
|     setdumpinfo    Configure the remote dump parameters
|
|     switchtocorethread Corefile version of "switchtoact"
|     resetcorectx   Corefile version of "resetctx"
|
|     readphys8      Reads the specified untranslated address (8-bit read)
|     readphys16     Reads the specified untranslated address (16-bit read)
|     readphys32     Reads the specified untranslated address (32-bit read)
|     readphys64     Reads the specified untranslated address (64-bit read)
|     writephys8     Writes to the specified untranslated address (8-bit write)
|     writephys16    Writes to the specified untranslated address (16-bit write)
|     writephys32    Writes to the specified untranslated address (32-bit write)
|     writephys64    Writes to the specified untranslated address (64-bit write)
|
|     readioport8    Read 8-bits from the specified I/O Port
|     readioport16   Read 16-bits from the specified I/O Port
|     readioport32   Read 32-bits from the specified I/O Port
|     writeioport8   Write 8-bits into the specified I/O Port
|     writeioport16  Write 16-bits into the specified I/O Port
|     writeioport32  Write 32-bits into the specified I/O Port
|
|     readmsr64      Read 64-bits from the specified MSR
|     writemsr64     Write 64-bits into the specified MSR
|
|     rtentry_showdbg Print the debug information of a route entry
|     rtentry_trash  Walk the list of trash route entries
|
|     inifa_showdbg  Print the debug information of an IPv4 interface address
|     in6ifa_showdbg Print the debug information of an IPv6 interface address
|     inm_showdbg    Print the debug information of an IPv4 multicast address
|     ifma_showdbg   Print the debug information of a link multicast address
|     ifpref_showdbg Print the debug information of an interface ref count
|
|     ndpr_showdbg   Print the debug information of a nd_prefix structure
|     nddr_showdbg   Print the debug information of a nd_defrouter structure
|
|     imo_showdbg    Print the debug information of a ip_moptions structure
|     im6o_showdbg   Print the debug information of a ip6_moptions structure
|
|     inifa_trash    Walk the list of trash in_ifaddr entries
|     in6ifa_trash   Walk the list of trash in6_ifaddr entries
|     inm_trash      Walk the list of trash in_multi entries
|     in6m_trash     Walk the list of trash in6_multi entries
|     ifma_trash     Walk the list of trash ifmultiaddr entries
|
|     mbuf_walkpkt   Walk the mbuf packet chain (m_nextpkt)
|     mbuf_walk      Walk the mbuf chain (m_next)
|     mbuf_buf2slab  Find the slab structure of the corresponding buffer
|     mbuf_buf2mca   Find the mcache audit structure of the corresponding mbuf
|     mbuf_showmca   Print the contents of an mbuf mcache audit structure
|     mbuf_showactive   Print all active/in-use mbuf objects
|     mbuf_showinactive Print all freed/in-cache mbuf objects 
|     mbuf_showall   Print all mbuf objects
|     mbuf_slabs     Print all slabs in the group
|     mbuf_slabstbl  Print slabs table
|     mbuf_stat      Print extended mbuf allocator statistics
|     mbuf_countchain   Count the length of an mbuf chain
|     mbuf_topleak   Print the top suspected mbuf leakers
|     mbuf_traceleak Print the leak information for a given leak address
|
|     mcache_walkobj     Walk the mcache object chain (obj_next)
|     mcache_stat        Print all mcaches in the system
|     mcache_showcache   Display the number of objects in the cache
|
|     showbootargs       Display boot arguments passed to the target kernel
|     showbootermemorymap Dump phys memory map from EFI
|
|     systemlog          Display the kernel's printf ring buffer
|
|     hexdump            Show the contents of memory as a hex/ASCII dump
|
|     showvnodepath      Print the path for a vnode
|     showvnodelocks     Display list of advisory locks held/blocked on a vnode
|     showvnodedev       Display information about a device vnode
|     showtty            Display information about a struct tty
|     showallvols        Display a summary of mounted volumes
|     showvnode          Display info about one vnode
|     showvolvnodes      Display info about all vnodes of a given volume
|     showvolbusyvnodes  Display info about busy (iocount!=0) vnodes of a given volume
|     showallbusyvnodes  Display info about all busy (iocount!=0) vnodes
|     showallvnodes      Display info about all vnodes
|     print_vnode        Print out the fields of a vnode struct
|     showprocvnodes     Print out all the open fds which are vnodes in a process
|     showallprocvnodes  Print out all the open fds which are vnodes in any process
|     showmountvnodes    Print the vnode list
|     showmountallvnodes Print the vnode inactive list
|     showworkqvnodes    Print the vnode worker list
|     shownewvnodes      Print the new vnode list
|
|     ifconfig           display ifconfig-like output
|     showifnets         show the list of attached and detached interfaces
|     showifaddrs        show the list of addresses for the given ifp
|     showifmultiaddrs   show the list of multicast addresses for the given ifp
|     showinmultiaddrs   show the list of IPv4 multicast addresses records 
|     showin6multiaddrs  show the list of IPv6 multicast addresses records
|
|     showsocket         Display information about a socket
|     showprocsockets    Given a proc_t pointer, display information about its sockets
|     showallprocsockets Display information about the sockets of all the processes
|
|     show_tcp_pcbinfo   Display the list of the TCP protocol control blocks
|     show_tcp_timewaitslots Display the list of the TCP protocol control blocks in TIMEWAIT
|     show_udp_pcbinfo   Display the list of UDP protocol control blocks
|
|     show_rt_inet       Display the IPv4 routing table
|     show_rt_inet6      Display the IPv6 routing table
|
|     showpmworkqueue       Display the IOPMWorkQueue object
|     showregistrypmstate   Display power management state for all IOPower registry entries
|     showioservicepm       Display the IOServicePM object
|     showstacksaftertask   showallstacks starting after a given task
|     showstacksafterthread showallstacks starting after a given thread
|
|     showMCAstate	Print machine-check register state after MC exception.
|
|     showallgdbstacks	Cause GDB to trace all thread stacks
|     showallgdbcorestacks Corefile equivalent of "showallgdbstacks"
|     kdp-reenter	Schedule reentry into the debugger and continue.
|     kdp-reboot	Restart remote target
|     kdp-version       Get KDP version number
|
|     zstack		Print zalloc caller stack (zone leak debugging)
|     findoldest	Find oldest zone leak debugging record
|     countpcs		Print how often a pc occurs in the zone leak log
|
|     showtopztrace     Print the ztrace with the most outstanding allocated memory
|     showztrace		Print a backtrace record given its index
|     showzalloc	    Print an allocation record + stacktrace at index
|     showztraceaddr    Print a backtrace record given its address
|     showztracesabove  Print all the backtrace records with a size bigger than X
|     showzstacktrace   Symbolicate and print a stored OSBacktrace
|     
|     showztraces       Finds all in-use traces in the ztraces table
|     showzallocs       Finds all in-use allocations in the zallocs table
|     showzstats        Shows the statistics gathered about the hash tables
|
|     showzallocsfortrace   Print all the allocations that refer to a trace
|     showztracehistogram   Prints a histogram of the ztraces table
|     showzallochistogram   Prints a histogram of the zallocs table	
|
|     pmap_walk     Perform a page-table walk
|     pmap_vtop     Translate a virtual address to physical address
|
|     showuserdyldinfo       Show dyld information and error messages
|                            in the target task
|     showuserlibraries      Show binary images known by dyld in the
|                            target task
|     showallvmstats	Prints a summary of vm statistics in a table format
|     memstats			Displays memory statistics in a table format
|
|     showthreadfortid	Displays the address of the thread structure
|                       for a given thread_id value. 
|     
|     strcmp_nomalloc   A version of strcmp that avoids the use of malloc
|                       through the use of encoded strings created via
|                       strcmp_arg_pack64.
|     strcmp_arg_pack64 Pack a string into a 64-bit quantity for use by
|                       strcmp_nomalloc
|
|     pci_cfg_read8     Read 8-bits from a PCI config space register
|     pci_cfg_read16    Read 16-bits from a PCI config space register
|     pci_cfg_read32    Read 32-bits from a PCI config space register
|     pci_cfg_write8    Write 8-bits into a PCI config space register
|     pci_cfg_write16   Write 16-bits into a PCI config space register
|     pci_cfg_write32   Write 32-bits into a PCI config space register
|     pci_cfg_dump      Dump entire config space for a PCI device
|     pci_cfg_scan      Perform a scan for PCI devices
|     pci_cfg_dump_all  Dump config spaces for all detected PCI devices
|
|     lapic_read32      Read APIC entry
|     lapic_write32     Write APIC entry
|     lapic_dump        Dump APIC entries
|
|     ioapic_read32     Read IOAPIC entry
|     ioapic_write32    Write IOAPIC entry
|     ioapic_dump       Dump IOAPIC entries
|
|     showallproviders  Display summary listing of all dtrace_providers
|     showallmodctls    Display summary listing of all dtrace modctls
|     showmodctl        Display info about a dtrace modctl
|     showfbtprobe      Display info about an fbt probe given an id (traverses fbt_probetab)
|     processortimers   Display all processor timers, noting any inconsistencies
|	  
|     maplocalcache     Enable local caching in GDB for improved debug speeds
|     flushlocalcahe    Disable local caching in GDB (deletes all memory regions)
|
| Type "help <macro>" for more specific help on a particular macro.
| Type "show user <macro>" to see what the macro is really doing.
end

# This macro should appear before any symbol references, to facilitate
# a gdb "source" without a loaded symbol file.
define showversion
    kdp-kernelversion
end

document showversion
Syntax: showversion
| Read the kernel version string from a fixed address in low
| memory. Useful if you don't know which kernel is on the other end,
| and need to find the appropriate symbols. Beware that if you've
| loaded a symbol file, but aren't connected to a remote target,
| the version string from the symbol file will be displayed instead.
| This macro expects to be connected to the remote kernel to function
| correctly.
end

set $kgm_mtype_ppc      = 0x00000012
set $kgm_mtype_arm      = 0x0000000C

set $kgm_mtype_i386     = 0x00000007
set $kgm_mtype_x86_64   = 0x01000007
set $kgm_mtype_x86_any  = $kgm_mtype_i386
set $kgm_mtype_x86_mask = 0xFEFFFFFF

set $kgm_mtype = ((unsigned int *)&_mh_execute_header)[1]
set $kgm_lp64 = $kgm_mtype & 0x01000000

set $kgm_manual_pkt_ppc    = 0x549C
set $kgm_manual_pkt_i386   = 0x249C
set $kgm_manual_pkt_x86_64 = 0xFFFFFF8000002930
set $kgm_manual_pkt_arm    = 0xFFFF04A0

set $kgm_kdp_pkt_data_len   = 128

# part of data packet
set $kgm_kdp_pkt_hdr_req_off = 0
set $kgm_kdp_pkt_hdr_seq_off = 1
set $kgm_kdp_pkt_hdr_len_off = 2
set $kgm_kdp_pkt_hdr_key_off = 4

# after data packet
set $kgm_kdp_pkt_len_off     = $kgm_kdp_pkt_data_len
set $kgm_kdp_pkt_input_off   = $kgm_kdp_pkt_data_len + 4

set $kgm_kdp_pkt_hostreboot = 0x13
set $kgm_kdp_pkt_hdr_size   = 8


set $kgm_readphys_force_kdp     = 0
set $kgm_readphys_force_physmap = 0

set $kgm_lcpu_self      = 0xFFFE

set $kgm_reg_depth = 0
set $kgm_reg_depth_max = 0xFFFF
set $kgm_reg_plane = (IORegistryPlane *) gIOServicePlane
set $kgm_namekey = (OSSymbol *) 0
set $kgm_childkey = (OSSymbol *) 0

set $kgm_show_object_addrs = 0
set $kgm_show_object_retain = 0
set $kgm_show_props = 0
set $kgm_show_data_alwaysbytes = 0

set $kgm_show_kmod_syms = 0

# send a manual packet header that doesn't require knowing the location
# of everything.
define manualhdrint
       set $req = $arg0

       set $hdrp = (uint32_t *) $kgm_manual_pkt_i386
       if ($kgm_mtype == $kgm_mtype_ppc)
          set $hdrp = (uint32_t *) $kgm_manual_pkt_ppc
          set $req = $req << 1 # shift to deal with endiannness
       end
       if ($kgm_mtype == $kgm_mtype_x86_64)
          set $hdrp = (uint64_t *) $kgm_manual_pkt_x86_64
       end
       if ($kgm_mtype == $kgm_mtype_arm)
          set $hdrp = (uint32_t *) $kgm_manual_pkt_arm
       end

       set $pkt_hdr = *$hdrp
       set *((uint8_t *) ($pkt_hdr + $kgm_kdp_pkt_input_off))    = 0
       set *((uint32_t *) ($pkt_hdr + $kgm_kdp_pkt_len_off))     = $kgm_kdp_pkt_hdr_size

       set *((uint8_t *) ($pkt_hdr + $kgm_kdp_pkt_hdr_req_off))  = $req
       set *((uint8_t *) ($pkt_hdr + $kgm_kdp_pkt_hdr_seq_off))  = 0
       set *((uint16_t *) ($pkt_hdr + $kgm_kdp_pkt_hdr_len_off)) = $kgm_kdp_pkt_hdr_size
       set *((uint32_t *) ($pkt_hdr + $kgm_kdp_pkt_hdr_key_off)) = 0
       set *((uint8_t *) ($pkt_hdr + $kgm_kdp_pkt_input_off))    = 1

       # dummy to make sure manual packet is executed
       set $kgm_dummy = &_mh_execute_header
end

# Print a pointer
define showptr
    if $kgm_lp64
        printf "0x%016llx", $arg0
    else
        printf "0x%08x", $arg0
    end
end

# for headers, leave 8 chars for LP64 pointers
define showptrhdrpad
    if $kgm_lp64
        printf "        "
    end
end

# Print a userspace pointer, using $kgm_tasp
define showuserptr
    set $kgm_userptr_task_64 = ( $kgm_taskp->taskFeatures[0] & 0x80000000)
    if $kgm_userptr_task_64
        printf "0x%016llx", $arg0
    else
        printf "0x%08x", $arg0
    end
end

define showkmodheader
    printf   "kmod_info "
    showptrhdrpad
    printf "  address   "
    showptrhdrpad
    printf "  size      "
    showptrhdrpad
    printf "  id    refs     version  name\n"
end

define showkmodint
    set $kgm_kmodp = (struct kmod_info *)$arg0
    showptr $kgm_kmodp
    printf "  "
    showptr $kgm_kmodp->address
    printf "  "
    showptr $kgm_kmodp->size
    printf "  "
    printf "%3d  ", $kgm_kmodp->id
    printf "%5d  ", $kgm_kmodp->reference_count
    printf "%10s  ", $kgm_kmodp->version
    printf "%s\n", $kgm_kmodp->name
end

# cached info of the last kext found, to speed up subsequent lookups
set $kgm_pkmod = 0
set $kgm_pkmodst = 0
set $kgm_pkmoden = 0

define showkmodaddrint
    showptr $arg0
    if ((unsigned long)$arg0 >= (unsigned long)$kgm_pkmodst) && ((unsigned long)$arg0 < (unsigned long)$kgm_pkmoden)
	set $kgm_off = ((unsigned long)$arg0 - (unsigned long)$kgm_pkmodst)
	printf " <%s + 0x%x>", $kgm_pkmod->name, $kgm_off
    else
    	set $kgm_kmodp = (struct kmod_info *)kmod
	if ($kgm_mtype == $kgm_mtype_x86_64) && ($arg0 >= (unsigned long)&_mh_execute_header)
	    # kexts are loaded below the kernel for x86_64
	    set $kgm_kmodp = 0
	end
	while $kgm_kmodp
	    set $kgm_off = ((unsigned long)$arg0 - (unsigned long)$kgm_kmodp->address)
	    if ($kgm_kmodp->address <= $arg0) && ($kgm_off < $kgm_kmodp->size)
		printf " <%s + 0x%x>", $kgm_kmodp->name, $kgm_off
		set $kgm_pkmod = $kgm_kmodp
		set $kgm_pkmodst = $kgm_kmodp->address
		set $kgm_pkmoden = $kgm_pkmodst + $kgm_kmodp->size
	    	set $kgm_kmodp = 0
	    else
		set $kgm_kmodp = $kgm_kmodp->next
	    end
	end
    end
end

define showkmodaddr
    showkmodaddrint $arg0
end
document showkmodaddr
Syntax: (gdb) showkmodaddr <addr>
| Given an address, print the offset and name for the kmod containing it
end

define showkmod
    showkmodheader
    showkmodint $arg0
end
document showkmod
Syntax: (gdb) showkmod <kmod>
| Routine to print info about a kext
end

define showkext
    showkmod $arg0
end
document showkext
Syntax: (gdb) showkext <kmod_info_address>
| Routine to print info about a kext
end

define showallkmods
    showkmodheader
    set $kgm_kmodp = (struct kmod_info *)kmod
    while $kgm_kmodp
	showkmodint $kgm_kmodp
    	set $kgm_kmodp = $kgm_kmodp->next
    end
end
document showallkmods
Syntax: (gdb) showallkmods
| Routine to print a summary listing of all loaded kexts
end

define showallkexts
    showallkmods
end
document showallkexts
Syntax: (gdb) showallkexts
| Routine to print a summary listing of all loaded kexts
end

# See OSKextVersion.c for the C code this is based on
#
set $KGM_OSKEXT_VERS_MAJ_MULT   = 100000000
set $KGM_OSKEXT_VERS_MIN_MULT   = 1000000
set $KGM_OSKEXT_VERS_REV_MULT   = 10000
set $KGM_OSKEXT_VERS_STAGE_MULT = 1000

define printoskextversion
    set $vers_scratch = $arg0

    if ($vers_scratch == -1)
        printf "(invalid)"
    else
     
        set $vers_major =  $vers_scratch / $KGM_OSKEXT_VERS_MAJ_MULT

        set $vers_scratch = $vers_scratch - ($vers_major * $KGM_OSKEXT_VERS_MAJ_MULT)
        set $vers_minor = $vers_scratch / $KGM_OSKEXT_VERS_MIN_MULT

        set $vers_scratch = $vers_scratch - ( $vers_minor * $KGM_OSKEXT_VERS_MIN_MULT)
        set $vers_revision =  $vers_scratch / $KGM_OSKEXT_VERS_REV_MULT

        set $vers_scratch = $vers_scratch - ( $vers_revision * $KGM_OSKEXT_VERS_REV_MULT)
        set $vers_stage =  $vers_scratch / $KGM_OSKEXT_VERS_STAGE_MULT

        set $vers_scratch = $vers_scratch - ( $vers_stage * $KGM_OSKEXT_VERS_STAGE_MULT)
        set $vers_stagelevel =  $vers_scratch

        printf "%d.%d", $vers_major, $vers_minor
        if ($vers_revision > 0)
            printf ".%d", $vers_revision
        end
        
        if ($vers_stage == 1)
            printf "d"
        end
        if ($vers_stage == 3)
            printf "a"
        end
        if ($vers_stage == 5)
            printf "b"
        end
        if ($vers_stage == 7)
            printf "fc"
        end
        if ($vers_stage == 1 || $vers_stage == 3 || $vers_stage == 5 || $vers_stage == 7)
            printf "%d", $vers_stagelevel
        end
    end
end

define showallknownkexts
   set $kext_count = sKextsByID->count
   set $kext_index = 0
   printf "%d kexts in sKextsByID:\n", $kext_count

   printf "OSKext *    "
   showptrhdrpad
   printf "load_addr   "
   showptrhdrpad
   
   printf " id  name (version)\n"

   while $kext_index < $kext_count
       set $kext_id = sKextsByID->dictionary[$kext_index].key->string
       set $oskext = (OSKext *)sKextsByID->dictionary[$kext_index].value

       showptr $oskext
       printf "  "

       if ($oskext->flags.loaded)
           showptr $oskext->kmod_info
           printf "  "
           printf "%3d", $oskext->loadTag
       else
           showptrhdrpad
           printf " -------- "
           printf "  "
           printf " --"
        end
        printf "  "

       printf "%.64s (", $kext_id
       printoskextversion (uint64_t)$oskext->version
       printf ")\n"
       set $kext_index = $kext_index + 1
   end
end
document showallknownkexts
Syntax: (gdb) showallknownkexts
| Routine to print a summary listing of all kexts, loaded or not
end

define showactheader
    printf "          "
    showptrhdrpad
    printf "  thread    "
    showptrhdrpad
    printf "    thread_id "
    showptrhdrpad
    printf "  processor "
    showptrhdrpad
    printf "   pri io_policy   state    wait_queue"
    showptrhdrpad
    printf "  wait_event\n"
end


define showactint
	printf "            "
	showptrhdrpad
	set $kgm_thread = *(struct thread *)$arg0
        showptr $arg0
	if ($kgm_thread.static_param)
	   printf "[WQ]"
	else
	   printf "    "
	end
	printf "  0x%llx   ", $kgm_thread.thread_id
	showptr $kgm_thread.last_processor
	printf "   %3d ", $kgm_thread.sched_pri
	if ($kgm_thread.uthread != 0)
	   set $kgm_printed = 0
	   set $kgm_uthread = (struct uthread *)$kgm_thread.uthread
	   if ($kgm_uthread->uu_flag & 0x400)
	      printf "RAGE "
	   else
	      printf "     "
	   end
	   set $diskpolicy = 0
	   if ($kgm_thread->ext_appliedstate.hw_disk != 0)
		set $diskpolicy = $kgm_thread->ext_appliedstate.hw_disk
	   else 
		if ($kgm_thread->appliedstate.hw_disk != 0)
			set $diskpolicy = $kgm_thread->appliedstate.hw_disk
		end
	   end
	   if ($kgm_thread->ext_appliedstate.hw_bg != 0)
		set $diskpolicy = 5
	   end
	   if ($kgm_thread->appliedstate.hw_bg != 0)
		set $diskpolicy = 4
	   end
	   if ($diskpolicy == 2)
	      printf "PASS    "
	      set $kgm_printed = 1
           end
	   if ($diskpolicy == 3)
	      printf "THROT   "
	      set $kgm_printed = 1
	   end
	   if ($diskpolicy == 4)
	      printf "BG_THRT "
	      set $kgm_printed = 1
           end
	   if ($diskpolicy == 5)
	      printf "EBG_THRT"
	      set $kgm_printed = 1
           end
	   if ($kgm_printed == 0)
	      printf "        "
	   end
	end
	set $kgm_state = $kgm_thread.state
	if $kgm_state & 0x80
	    printf "I" 
	end
	if $kgm_state & 0x40
	    printf "P" 
	end
	if $kgm_state & 0x20
	    printf "A" 
	end
	if $kgm_state & 0x10
	    printf "H" 
	end
	if $kgm_state & 0x08
	    printf "U" 
	end
	if $kgm_state & 0x04
	    printf "R" 
	end
	if $kgm_state & 0x02
	    printf "S" 
	end
   	if $kgm_state & 0x01
	    printf "W"
	    printf "\t    " 
	    showptr $kgm_thread.wait_queue
            printf "  "
	    	if (((unsigned long)$kgm_thread.wait_event > (unsigned long)&last_kernel_symbol) \
		    && ($arg1 != 2) && ($kgm_show_kmod_syms == 0))
			showkmodaddr $kgm_thread.wait_event
	        else
			output /a $kgm_thread.wait_event
		end
		if ($kgm_thread.uthread != 0)
		    set $kgm_uthread = (struct uthread *)$kgm_thread.uthread
		    if ($kgm_uthread->uu_wmesg != 0)
			printf "\t \"%s\"", $kgm_uthread->uu_wmesg
		    end
		end
	end
	if ($kgm_thread.uthread != 0)
	   set $kgm_uthread = (struct uthread *)$kgm_thread.uthread
	   if ($kgm_uthread->pth_name && $kgm_uthread->pth_name[0])
	   	   printf "\n\t\tThread Name: %s", $kgm_uthread->pth_name
	   end
	end
	if $arg1 != 0
	    if ($kgm_thread.kernel_stack != 0)
		if ($kgm_thread.uthread != 0)
			printf "\n          "
			set $kgm_uthread = (struct uthread *)$kgm_thread.uthread
			if ($kgm_uthread->uu_kwe.kwe_kwqqueue != 0)
				set $kwq = (ksyn_wait_queue_t)$kgm_uthread->uu_kwe.kwe_kwqqueue
				printf "              kwq_lockcount:0x%x; kwq_retval:0x%x", $kgm_uthread->uu_kwe.kwe_lockseq, $kgm_uthread->uu_kwe.kwe_psynchretval
				printf "\n                "
				show_kwq $kwq
				printf "          "
			end
		end
		if ($kgm_thread.reserved_stack != 0)
			printf "\n          "
			showptrhdrpad
			printf "      reserved_stack="
                   	showptr $kgm_thread.reserved_stack
		end
		printf "\n          "
		showptrhdrpad
		printf "      kernel_stack="
		showptr $kgm_thread.kernel_stack
		if ($kgm_mtype == $kgm_mtype_ppc)
			set $mysp = $kgm_thread.machine.pcb->save_r1
		end
		if (($kgm_mtype & $kgm_mtype_x86_mask) == $kgm_mtype_x86_any)
			set $kgm_statep = (struct x86_kernel_state *) \
				($kgm_thread->kernel_stack + kernel_stack_size \
				 - sizeof(struct x86_kernel_state))
			if ($kgm_mtype == $kgm_mtype_i386)
				set $mysp = $kgm_statep->k_ebp
			else
				set $mysp = $kgm_statep->k_rbp
			end
		end
		if ($kgm_mtype == $kgm_mtype_arm)
			if (((unsigned long)$r7 < ((unsigned long) ($kgm_thread->kernel_stack+kernel_stack_size))) \
                      && ((unsigned long)$r7 > (unsigned long) ($kgm_thread->kernel_stack)))
				set $mysp = $r7
			else
				set $kgm_statep = (struct arm_saved_state *)$kgm_thread.machine.kstackptr
				set $mysp = $kgm_statep->r[7]
			end
		end
		set $prevsp = $mysp - 16
		printf "\n          "
		showptrhdrpad
		printf "      stacktop="
 		showptr $mysp
		if ($kgm_mtype == $kgm_mtype_ppc)
			set $stkmask = 0xf
		else
			set $stkmask = 0x3
		end
		set $kgm_return = 0
		set $kgm_actint_framecount = 0
	    	while ($mysp != 0) && (($mysp & $stkmask) == 0) \
		      && ($mysp != $prevsp) \
		      && ((((unsigned long) $mysp ^ (unsigned long) $prevsp) < 0x2000) \
		      || (((unsigned long)$mysp < ((unsigned long) ($kgm_thread->kernel_stack+kernel_stack_size))) \
		      && ((unsigned long)$mysp > (unsigned long) ($kgm_thread->kernel_stack)))) \
		      && ($kgm_actint_framecount < 128)
			printf "\n          "
			set $kgm_actint_framecount = $kgm_actint_framecount + 1
			showptrhdrpad
			printf "      "
 			showptr $mysp
			printf "  "
			if ($kgm_mtype == $kgm_mtype_ppc)
				set $kgm_return = *($mysp + 8)
			end
			if ($kgm_mtype == $kgm_mtype_i386)
				set $kgm_return = *($mysp + 4)
			end
			if ($kgm_mtype == $kgm_mtype_x86_64)
				set $kgm_return = *(unsigned long *)($mysp + 8)
			end
			if ($kgm_mtype == $kgm_mtype_arm)
				set $kgm_return = *($mysp + 4)
			end
			if (((unsigned long) $kgm_return < (unsigned long) &_mh_execute_header || \
			     (unsigned long) $kgm_return >= (unsigned long) &last_kernel_symbol ) \
			    && ($kgm_show_kmod_syms == 0))
				showkmodaddr $kgm_return
			else
				output /a $kgm_return
			end
			set $prevsp = $mysp
			set $mysp = *(unsigned long *)$mysp
		end
		set $kgm_return = 0
		printf "\n          "
		showptrhdrpad
		printf "      stackbottom="
		showptr $prevsp
	    else
		printf "\n          "
		showptrhdrpad
		printf "      continuation="
		output /a $kgm_thread.continuation
	    end
	    printf "\n"
	else
	    printf "\n"
	end
end	    

define showact
    showactheader
    showactint $arg0 0
end
document showact
Syntax: (gdb) showact <activation> 
| Routine to print out the state of a specific thread.
end


define showactstack
    showactheader
    showactint $arg0 1
end
document showactstack
Syntax: (gdb) showactstack <activation> 
| Routine to print out the stack of a specific thread.
end


define showallthreads
    set $kgm_head_taskp = &tasks
    set $kgm_taskp = (struct task *)($kgm_head_taskp->next)
    while $kgm_taskp != $kgm_head_taskp
        showtaskheader
	showtaskint $kgm_taskp
	showactheader
	set $kgm_head_actp = &($kgm_taskp->threads)
        set $kgm_actp = (struct thread *)($kgm_taskp->threads.next)
	while $kgm_actp != $kgm_head_actp
	    showactint $kgm_actp 0
  	    set $kgm_actp = (struct thread *)($kgm_actp->task_threads.next)
        end
	printf "\n"
    	set $kgm_taskp = (struct task *)($kgm_taskp->tasks.next)
    end
end
document showallthreads
Syntax: (gdb) showallthreads
| Routine to print out info about all threads in the system.
end

define showprocessorint
    set $kgm_processor_int = (struct processor *)$arg0
    printf "Processor "
    showptr $kgm_processor_int
    printf " State %d (cpu_id 0x%x)\n", ($kgm_processor_int)->state, ($kgm_processor_int)->cpu_id
end

define showcurrentthreads
    set $kgm_prp = (struct processor *)processor_list
    while $kgm_prp != 0
        showprocessorint $kgm_prp
	if ($kgm_prp)->active_thread != 0
	    set $kgm_actp = ($kgm_prp)->active_thread
	    showtaskheader
	    showtaskint ($kgm_actp)->task
	    showactheader
	    showactint $kgm_actp 0
	    printf "\n"
	end
	set $kgm_prp = ($kgm_prp)->processor_list
    end
end
document showcurrentthreads
Syntax: (gdb) showcurrentthreads
| Routine to print out info about the thread running on each cpu.
end


define _showrunqint
	set $kgm_runq = (struct run_queue *)$arg0
	
	printf "    Priority Run Queue Info: Count %d\n", $kgm_runq->count
	set $kgm_runq_queue_i = 0
	set $kgm_runq_queue_count = sizeof($kgm_runq->queues)/sizeof($kgm_runq->queues[0])
	while $kgm_runq->count && $kgm_runq_queue_i < $kgm_runq_queue_count
		set $kgm_runq_queue_head = &$kgm_runq->queues[$kgm_runq_queue_i]
		set $kgm_runq_queue_p = $kgm_runq_queue_head->next
		if $kgm_runq_queue_p != $kgm_runq_queue_head
			set $kgm_runq_queue_this_count = 0
			while $kgm_runq_queue_p != $kgm_runq_queue_head
				set $kgm_runq_queue_this_count = $kgm_runq_queue_this_count + 1
				showtask ((thread_t)$kgm_runq_queue_p)->task
				showactstack $kgm_runq_queue_p
				set $kgm_runq_queue_p = $kgm_runq_queue_p->next
			end
			printf "      Queue Priority %3d [", $kgm_runq_queue_i
			showptr $kgm_runq_queue_head
			printf "] Count %d\n", $kgm_runq_queue_this_count
		end
		set $kgm_runq_queue_i = $kgm_runq_queue_i + 1
	end

end

define _showgrrrint
	set $kgm_grrr_runq = $arg0
	
	printf "    GRRR Info: Count %d Weight %d Current Group ", $kgm_grrr_runq->count, $kgm_grrr_runq->weight
	showptr $kgm_grrr_runq->current_group
	printf "\n"
	set $kgm_grrr_group_i = 0
	set $kgm_grrr_group_count = sizeof($kgm_grrr_runq->groups)/sizeof($kgm_grrr_runq->groups[0])
	while $kgm_grrr_runq->count && $kgm_grrr_group_i < $kgm_grrr_group_count
		set $kgm_grrr_group = &$kgm_grrr_runq->groups[$kgm_grrr_group_i]
		if $kgm_grrr_group->count > 0
			printf "      Group %3d [", $kgm_grrr_group->index
			showptr $kgm_grrr_group
			printf "] Count %d Weight %d\n", $kgm_grrr_group->count, $kgm_grrr_group->weight
			set $kgm_grrr_group_client_head = &$kgm_grrr_group->clients
			set $kgm_grrr_group_client = $kgm_grrr_group_client_head->next
			while $kgm_grrr_group_client != $kgm_grrr_group_client_head
				# showtask ((thread_t)$kgm_grrr_group_client)->task
				# showactstack $kgm_grrr_group_client
				set $kgm_grrr_group_client = $kgm_grrr_group_client->next
			end
		end
		set $kgm_grrr_group_i = $kgm_grrr_group_i + 1
	end
end

define showallprocessors
	set $kgm_pset = &pset0

	set $kgm_show_grrr = 0
	set $kgm_show_priority_runq = 0
	set $kgm_show_priority_pset_runq = 0
	set $kgm_show_fairshare_grrr = 0
	set $kgm_show_fairshare_list = 0

	if _sched_enum == 1
		set $kgm_show_priority_runq = 1
		set $kgm_show_fairshare_list = 1
	end
	if _sched_enum == 2
		set $kgm_show_priority_pset_runq = 1
		set $kgm_show_fairshare_list = 1
	end
	if _sched_enum == 4
		set $kgm_show_grrr = 1
		set $kgm_show_fairshare_grrr = 1
	end
	if _sched_enum == 5
		set $kgm_show_priority_runq = 1
		set $kgm_show_fairshare_list = 1
	end
	if _sched_enum == 6
		set $kgm_show_priority_pset_runq = 1
		set $kgm_show_fairshare_list = 1
	end

	while $kgm_pset != 0
		printf "Processor Set "
		showptr $kgm_pset
		printf " Count %d (cpu_id 0x%x-0x%x)\n", ($kgm_pset)->cpu_set_count, ($kgm_pset)->cpu_set_low, ($kgm_pset)->cpu_set_hi
		printf "  Active Processors:\n"
		set $kgm_active_queue_head = &($kgm_pset)->active_queue
		set $kgm_active_elt = $kgm_active_queue_head->next
		while $kgm_active_elt != $kgm_active_queue_head
			set $kgm_processor = (processor_t)$kgm_active_elt
			printf "    "
			showprocessorint $kgm_processor

			if $kgm_show_priority_runq
				set $kgm_runq = &$kgm_processor->runq
				_showrunqint $kgm_runq
			end
			if $kgm_show_grrr
				set $kgm_grrr_runq = &$kgm_processor->grrr_runq
				_showgrrrint $kgm_grrr_runq
			end
			
			if $kgm_processor->processor_meta != 0 && $kgm_processor->processor_meta->primary == $kgm_processor
				set $kgm_processor_meta_idle_head = &$kgm_processor->processor_meta->idle_queue
				set $kgm_processor_meta_idle = $kgm_processor_meta_idle_head->next
				while $kgm_processor_meta_idle != $kgm_processor_meta_idle_head
					printf "      Idle Meta Processor: "
					showprocessorint $kgm_processor_meta_idle
					set $kgm_processor_meta_idle = $kgm_processor_meta_idle->next
				end
			end
			
			set $kgm_active_elt = $kgm_active_elt->next
		end
		printf "  Idle Processors:\n"
		set $kgm_idle_queue_head = &($kgm_pset)->idle_queue
		set $kgm_idle_elt = $kgm_idle_queue_head->next
		while $kgm_idle_elt != $kgm_idle_queue_head
			set $kgm_processor = (processor_t)$kgm_idle_elt
			printf "    "
			showprocessorint $kgm_processor
			
			if $kgm_processor->processor_meta != 0 && $kgm_processor->processor_meta->primary == $kgm_processor
				set $kgm_processor_meta_idle_head = &$kgm_processor->processor_meta->idle_queue
				set $kgm_processor_meta_idle = $kgm_processor_meta_idle_head->next
				while $kgm_processor_meta_idle != $kgm_processor_meta_idle_head
					printf "      Idle Meta Processor: "
					showprocessorint $kgm_processor_meta_idle
					set $kgm_processor_meta_idle = $kgm_processor_meta_idle->next
				end
			end

			set $kgm_idle_elt = $kgm_idle_elt->next
		end

		if $kgm_show_priority_pset_runq
			set $kgm_runq = &$kgm_pset->pset_runq
			printf "\n"
			_showrunqint $kgm_runq
		end
		set $kgm_pset = ($kgm_pset)->pset_list
	end
	
	printf "\n"
	printf "Realtime Queue Count %d\n", rt_runq.count
	set $kgm_rt_runq_head = &rt_runq.queue
	set $kgm_rt_runq = $kgm_rt_runq_head->next
	while $kgm_rt_runq != $kgm_rt_runq_head
		showtask ((thread_t)$kgm_rt_runq)->task
		showact $kgm_rt_runq
		set $kgm_rt_runq = $kgm_rt_runq->next
	end
	
	printf "\n"
	if $kgm_show_fairshare_list
		printf "Fair Share Queue Count %d\n", fs_runq.count
		set $kgm_fs_runq_head = &fs_runq.queue
		set $kgm_fs_runq = $kgm_fs_runq_head->next
		while $kgm_fs_runq != $kgm_fs_runq_head
			showtask ((thread_t)$kgm_fs_runq)->task
			showact $kgm_fs_runq
			set $kgm_fs_runq = $kgm_fs_runq->next
		end
	end
	if $kgm_show_fairshare_grrr
		printf "Fair Share Queue Count %d\n", fs_grrr_runq.count
		set $kgm_fs_grrr = &fs_grrr_runq
		_showgrrrint $kgm_fs_grrr
	end
end
document showallprocessors
Syntax: (gdb) showallprocessors
| Routine to print out info about all psets and processors
end

set $decode_wait_events = 0
define showallstacks
    set $kgm_head_taskp = &tasks
    set $kgm_taskp = (struct task *)($kgm_head_taskp->next)
    while $kgm_taskp != $kgm_head_taskp
	showtaskheader
	showtaskint $kgm_taskp
	set $kgm_head_actp = &($kgm_taskp->threads)
	set $kgm_actp = (struct thread *)($kgm_taskp->threads.next)
	while $kgm_actp != $kgm_head_actp
	    showactheader
	    if ($decode_wait_events > 0)
	       showactint $kgm_actp 1
	    else
	       showactint $kgm_actp 2
	    end
	    set $kgm_actp = (struct thread *)($kgm_actp->task_threads.next)
	end
	printf "\n"
	set $kgm_taskp = (struct task *)($kgm_taskp->tasks.next)
    end

    printf "\nZombie Processes:\n" 
    zombstacks
end

document showallstacks
Syntax: (gdb) showallstacks
| Routine to print out the stack for each thread in the system.
| If the variable $decode_wait_events is non-zero, the routine attempts to
| interpret thread wait_events as kernel module offsets, which can add to
| processing time.
end

define showcurrentstacks
    set $kgm_prp = processor_list
    while $kgm_prp != 0
    	showprocessorint $kgm_prp
	if ($kgm_prp)->active_thread != 0
	    set $kgm_actp = ($kgm_prp)->active_thread
	    showtaskheader
	    showtaskint ($kgm_actp)->task
	    showactheader
	    showactint $kgm_actp 1
	    printf "\n"
	end
	set $kgm_prp = ($kgm_prp)->processor_list
    end
end

document showcurrentstacks
Syntax: (gdb) showcurrentstacks
| Routine to print out the thread running on each cpu (incl. its stack)
end

define showwaiterheader
    printf "waiters     thread      "
    printf "processor   pri  state  wait_queue  wait_event\n"
end

define showwaitqwaiters
    set $kgm_w_waitqp = (WaitQueue*)$arg0
    set $kgm_w_linksp = &($kgm_w_waitqp->wq_queue)
    set $kgm_w_wqe = (WaitQueueElement *)$kgm_w_linksp->next
    set $kgm_w_found = 0
    while ( (queue_entry_t)$kgm_w_wqe != (queue_entry_t)$kgm_w_linksp)
	if ($kgm_w_wqe->wqe_type != &_wait_queue_link)
		if !$kgm_w_found
			set $kgm_w_found = 1
			showwaiterheader
		end
		set $kgm_w_shuttle = (struct thread *)$kgm_w_wqe
		showactint $kgm_w_shuttle 0
	end	
	set $kgm_w_wqe = (WaitQueueElement *)$kgm_w_wqe->wqe_links.next
    end
end

define showwaitqwaitercount
    set $kgm_wc_waitqp = (WaitQueue*)$arg0
    set $kgm_wc_linksp = &($kgm_wc_waitqp->wq_queue)
    set $kgm_wc_wqe = (WaitQueueElement *)$kgm_wc_linksp->next
    set $kgm_wc_count = 0
    while ( (queue_entry_t)$kgm_wc_wqe != (queue_entry_t)$kgm_wc_linksp)
	if ($kgm_wc_wqe->wqe_type != &_wait_queue_link)
        	set $kgm_wc_count = $kgm_wc_count + 1
	end
        set $kgm_wc_wqe = (WaitQueueElement *)$kgm_wc_wqe->wqe_links.next
    end
    printf "0x%08x  ", $kgm_wc_count
end

define showwaitqmembercount
    set $kgm_mc_waitqsetp = (WaitQueueSet*)$arg0
    set $kgm_mc_setlinksp = &($kgm_mc_waitqsetp->wqs_setlinks)
    set $kgm_mc_wql = (WaitQueueLink *)$kgm_mc_setlinksp->next
    set $kgm_mc_count = 0
    while ( (queue_entry_t)$kgm_mc_wql != (queue_entry_t)$kgm_mc_setlinksp)
        set $kgm_mc_count = $kgm_mc_count + 1
        set $kgm_mc_wql = (WaitQueueLink *)$kgm_mc_wql->wql_setlinks.next
    end
    printf "0x%08x  ", $kgm_mc_count
end

    
define showwaitqmemberheader
    printf "set-members wait_queue  interlock   "
    printf "pol  type   member_cnt  waiter_cnt\n"
end

define showwaitqmemberint
    set $kgm_m_waitqp = (WaitQueue*)$arg0
    printf "            0x%08x  ", $kgm_m_waitqp
    printf "0x%08x  ", $kgm_m_waitqp->wq_interlock.lock_data
    if ($kgm_m_waitqp->wq_fifo)
        printf "Fifo "
    else
	printf "Prio "
    end
    if ($kgm_m_waitqp->wq_type == 0xf1d1)
	printf "Set    "
	showwaitqmembercount $kgm_m_waitqp
    else
	printf "Que    0x00000000  "
    end
    showwaitqwaitercount $kgm_m_waitqp
    printf "\n"
end


define showwaitqmemberofheader
    printf "member-of   wait_queue  interlock   "
    printf "pol  type   member_cnt  waiter_cnt\n"
end

define showwaitqmemberof
    set $kgm_mo_waitqp = (WaitQueue*)$arg0
    set $kgm_mo_linksp = &($kgm_mo_waitqp->wq_queue)
    set $kgm_mo_wqe = (WaitQueueElement *)$kgm_mo_linksp->next
    set $kgm_mo_found = 0
    while ( (queue_entry_t)$kgm_mo_wqe != (queue_entry_t)$kgm_mo_linksp)
	if ($kgm_mo_wqe->wqe_type == &_wait_queue_link)
		if !$kgm_mo_found
			set $kgm_mo_found = 1
			showwaitqmemberofheader
		end
		set $kgm_mo_wqlp = (WaitQueueLink *)$kgm_mo_wqe
		set $kgm_mo_wqsetp = (WaitQueue*)($kgm_mo_wqlp->wql_setqueue)
		showwaitqmemberint $kgm_mo_wqsetp
	end	
	set $kgm_mo_wqe = (WaitQueueElement *)$kgm_mo_wqe->wqe_links.next
    end
end

define showwaitqmembers
    set $kgm_ms_waitqsetp = (WaitQueueSet*)$arg0
    set $kgm_ms_setlinksp = &($kgm_ms_waitqsetp->wqs_setlinks)
    set $kgm_ms_wql = (WaitQueueLink *)$kgm_ms_setlinksp->next
    set $kgm_ms_found = 0
    while ( (queue_entry_t)$kgm_ms_wql != (queue_entry_t)$kgm_ms_setlinksp)
        set $kgm_ms_waitqp = $kgm_ms_wql->wql_element.wqe_queue
        if !$kgm_ms_found  
	    showwaitqmemberheader
	    set $kgm_ms_found = 1
        end
        showwaitqmemberint $kgm_ms_waitqp
	set $kgm_ms_wql = (WaitQueueLink *)$kgm_ms_wql->wql_setlinks.next
    end
end

define showwaitqheader
    printf "wait_queue  ref_count   interlock   "
    printf "pol  type   member_cnt  waiter_cnt\n"
end

define showwaitqint
    set $kgm_waitqp = (WaitQueue*)$arg0
    printf "0x%08x  ", $kgm_waitqp
    if ($kgm_waitqp->wq_type == 0xf1d1)
	printf "0x%08x  ", ((WaitQueueSet*)$kgm_waitqp)->wqs_refcount
    else
	printf "0x00000000  "
    end
    printf "0x%08x  ", $kgm_waitqp->wq_interlock.lock_data
    if ($kgm_waitqp->wq_fifo)
        printf "Fifo "
    else
	printf "Prio "
    end
    if ($kgm_waitqp->wq_type == 0xf1d1)
	printf "Set    "
	showwaitqmembercount $kgm_waitqp
    else
	printf "Que    0x00000000  "
    end
    showwaitqwaitercount $kgm_waitqp
    printf "\n"
end

define showwaitq
    set $kgm_waitq1p = (WaitQueue*)$arg0
    showwaitqheader
    showwaitqint $kgm_waitq1p	
    if ($kgm_waitq1p->wq_type == 0xf1d1)
	showwaitqmembers $kgm_waitq1p
    else
    	showwaitqmemberof $kgm_waitq1p
    end
    showwaitqwaiters $kgm_waitq1p
end

define showmapheader
    printf "vm_map    "
    showptrhdrpad
    printf "  pmap      "
    showptrhdrpad
    printf "  vm_size   "
    showptrhdrpad
    printf " #ents rpage  hint      "
    showptrhdrpad
    printf "  first_free\n"
end

define showvmeheader
    printf "    entry     "
    showptrhdrpad
    printf "  start               prot  #page  object    "
    showptrhdrpad
    printf "  offset\n"
end

define showvmint
    set $kgm_mapp = (vm_map_t)$arg0
    set $kgm_map = *$kgm_mapp
    showptr $arg0
    printf "  "
    showptr $kgm_map.pmap
    printf "  "
    showptr $kgm_map.size
    printf "   %3d ", $kgm_map.hdr.nentries
    if $kgm_map.pmap
	printf "%5d  ", $kgm_map.pmap->stats.resident_count
    else
	printf "<n/a>  "
    end
    showptr $kgm_map.hint
    printf "  "
    showptr $kgm_map.first_free
    printf "\n"
    if $arg1 != 0
        showvmeheader	
        set $kgm_head_vmep = &($kgm_mapp->hdr.links)
        set $kgm_vmep = $kgm_map.hdr.links.next
        while (($kgm_vmep != 0) && ($kgm_vmep != $kgm_head_vmep))
            set $kgm_vme = *$kgm_vmep
            printf "    "
	    showptr $kgm_vmep
            printf "  0x%016llx  ", $kgm_vme.links.start
            printf "%1x", $kgm_vme.protection
            printf "%1x", $kgm_vme.max_protection
            if $kgm_vme.inheritance == 0x0
                printf "S"
            end
            if $kgm_vme.inheritance == 0x1
                printf "C"
            end
            if $kgm_vme.inheritance == 0x2
                printf "-"
            end
            if $kgm_vme.inheritance == 0x3
                printf "D"
            end
            if $kgm_vme.is_sub_map
                printf "s "
            else
                if $kgm_vme.needs_copy
                    printf "n "
                else
                    printf "  "
                end
            end
            printf "%6d  ",($kgm_vme.links.end - $kgm_vme.links.start) >> 12
            showptr $kgm_vme.object.vm_object
            printf "  0x%016llx\n", $kgm_vme.offset
            set $kgm_vmep = $kgm_vme.links.next
        end
    end
    printf "\n"
end


define showmapwiredp
    set $kgm_mapp = (vm_map_t)$arg0
    set $kgm_map = *$kgm_mapp
    set $kgm_head_vmep = &($kgm_mapp->hdr.links)
    set $kgm_vmep = $kgm_map.hdr.links.next
    set $kgm_objp_prev = (struct vm_object *)0
    if $arg1 == 0
        set $kgm_saw_kernel_obj = 0
	set $kgm_wired_count = 0
	set $kgm_objp_print_space = 1
    else
	set $kgm_objp_print_space = 0
    end
    while (($kgm_vmep != 0) && ($kgm_vmep != $kgm_head_vmep))
        set $kgm_vme = *$kgm_vmep
	set $kgm_objp = $kgm_vme.object.vm_object
	if $kgm_vme.is_sub_map
	    if $arg1 == 0
	        set $kgm_mapp_orig = $kgm_mapp
		set $kgm_vmep_orig = $kgm_vmep
		set $kgm_vme_orig = $kgm_vme
		set $kgm_head_vmep_orig = $kgm_head_vmep
		printf "\n****"
		showptr $kgm_objp
		showmapwiredp $kgm_objp 1
		set $kgm_vme = $kgm_vme_orig
		set $kgm_vmep = $kgm_vmep_orig
		set $kgm_mapp = $kgm_mapp_orig
		set $kgm_head_vmep = $kgm_head_vmep_orig
		set $kgm_objp = (struct vm_object *)0
	    else
	        printf "\n????"	    
		showptr $kgm_mapp
	        printf "    "
	        showptr $kgm_vmep
		set $kgm_objp = (struct vm_object *)0
		printf "\n"
	    end
	end
	if ($kgm_objp == $kgm_objp_prev)
	    set $kgm_objp = (struct vm_object *)0
	end
	if $kgm_objp == kernel_object
	   if $kgm_saw_kernel_obj
	       set $kgm_objp = (struct vm_object *)0
	   end
	   set $kgm_saw_kernel_obj = 1
	end
	if $kgm_objp && $kgm_objp->wired_page_count
	    if $kgm_objp_print_space == 1
	        printf "    "
		showptr $kgm_mapp
	    end
	    set $kgm_objp_print_space = 1
	    printf "    "
	    showptr $kgm_vmep
	    printf "  0x%016llx  ", $kgm_vme.links.start
	    printf "%5d", $kgm_vme.alias
            printf "%6d  ",($kgm_vme.links.end - $kgm_vme.links.start) >> 12
	    showptr $kgm_objp
	    printf "[%3d]", $kgm_objp->ref_count
	    printf "%7d\n", $kgm_objp->wired_page_count
	    set $kgm_wired_count = $kgm_wired_count + $kgm_objp->wired_page_count
	    set $kgm_objp_prev = $kgm_objp
	end
        set $kgm_vmep = $kgm_vme.links.next
    end
    if $arg1 == 0
        printf "total wired count = %d\n", $kgm_wired_count
    end
end

define showmapwired
    printf "    map       "
    showptrhdrpad
    printf "    entry     "
    showptrhdrpad
    printf "  start               alias  #page  object    "
    showptrhdrpad
    printf "       wired\n"
    showmapwiredp $arg0 0
end
document showmapwired
Syntax: (gdb) showmapwired <vm_map>
| Routine to print out a summary listing of all the entries with wired pages in a vm_map
end

define showmapvme
	showmapheader
	showvmint $arg0 1
end
document showmapvme
Syntax: (gdb) showmapvme <vm_map>
| Routine to print out a summary listing of all the entries in a vm_map
end


define showmap
	showmapheader
	showvmint $arg0 0
end
document showmap
Syntax: (gdb) showmap <vm_map>
| Routine to print out info about the specified vm_map
end

define showallvm
    set $kgm_head_taskp = &tasks
    set $kgm_taskp = (struct task *)($kgm_head_taskp->next)
    while $kgm_taskp != $kgm_head_taskp
        showtaskheader
	showmapheader
	showtaskint $kgm_taskp
	showvmint $kgm_taskp->map 0
    	set $kgm_taskp = (struct task *)($kgm_taskp->tasks.next)
    end
end
document showallvm
Syntax: (gdb) showallvm
| Routine to print a summary listing of all the vm maps
end


define showallvme
    set $kgm_head_taskp = &tasks
    set $kgm_taskp = (struct task *)($kgm_head_taskp->next)
    while $kgm_taskp != $kgm_head_taskp
        showtaskheader
	showmapheader
	showtaskint $kgm_taskp
	showvmint $kgm_taskp->map 1
    	set $kgm_taskp = (struct task *)($kgm_taskp->tasks.next)
    end
end
document showallvme
Syntax: (gdb) showallvme
| Routine to print a summary listing of all the vm map entries
end


define showipcheader
    printf "ipc_space "
    showptrhdrpad
    printf "  is_task   "
    showptrhdrpad
    printf "  is_table  "
    showptrhdrpad
    printf " flags ports  table_next  "
    showptrhdrpad
    printf "   low_mod   high_mod\n"
end

define showipceheader
    printf "            "
    showptrhdrpad
    printf "object      "
    showptrhdrpad
    showptrhdrpad
    printf "name        rite urefs  destname    "
    showptrhdrpad
    printf "destination\n"
end

define showipceint
    set $kgm_ie = *(ipc_entry_t)$arg0
    printf "            "
    showptrhdrpad
    showptr $kgm_ie.ie_object
    showptrhdrpad
    printf "  0x%08x  ", $arg1
    if $kgm_ie.ie_bits & 0x00100000
        printf "Dead "
        printf "%5d\n", $kgm_ie.ie_bits & 0xffff
    else
        if $kgm_ie.ie_bits & 0x00080000
            printf "SET  "
            printf "%5d\n", $kgm_ie.ie_bits & 0xffff
        else
            if $kgm_ie.ie_bits & 0x00010000
                if $kgm_ie.ie_bits & 0x00020000
                    printf " SR"
                else
                    printf "  S"
                end
            else
                if $kgm_ie.ie_bits & 0x00020000
                   printf "  R"
                end
            end
            if $kgm_ie.ie_bits & 0x00040000
                printf "  O"
            end
            if $kgm_ie.index.request
                set $kgm_port = (ipc_port_t)$kgm_ie.ie_object
		set $kgm_requests = $kgm_port->ip_requests
		set $kgm_req_soright = $kgm_requests[$kgm_ie.index.request].notify.port
		if $kgm_req_soright
#                   Armed send-possible notification?
		    if (uintptr_t)$kgm_req_soright & 0x1
		        printf "s"
                    else
#                       Delayed send-possible notification?
		        if (uintptr_t)$kgm_req_soright & 0x2
			    printf "d"
			else
#                           Dead-name notification
			    printf "n"
			end
		    end     
		else
		    printf " "
         	end
            else
                printf " "
            end
#           Collision (with tree)?
            if $kgm_ie.ie_bits & 0x00800000
                printf "c"
    	    else
                printf " "
    	    end
            printf "%5d  ", $kgm_ie.ie_bits & 0xffff
            showportdest $kgm_ie.ie_object
        end
    end
end

define showipcint
    set $kgm_isp = (ipc_space_t)$arg0
    set $kgm_is = *$kgm_isp
    showptr $arg0
    printf "  "
    showptr $kgm_is.is_task
    printf "  "
    showptr $kgm_is.is_table
    printf "  "
    if ($kgm_is.is_bits & 0x40000000) == 0
        printf "A"
    else
        printf " "
    end
    if ($kgm_is.is_bits & 0x20000000) != 0
        printf "G   "
    else
        printf "    "
    end
    printf "%5d  ", $kgm_is.is_table_size 
    showptr $kgm_is.is_table_next
    printf "  "
    printf "%10d ", $kgm_is.is_low_mod
    printf "%10d", $kgm_is.is_high_mod
    printf "\n"
    if $arg1 != 0
        showipceheader
        set $kgm_iindex = 0
        set $kgm_iep = $kgm_is.is_table
        set $kgm_destspacep = (ipc_space_t)0
        while ( $kgm_iindex < $kgm_is.is_table_size )
            set $kgm_ie = *$kgm_iep
            if $kgm_ie.ie_bits & 0x001f0000
                set $kgm_name = (($kgm_iindex << 8)|($kgm_ie.ie_bits >> 24))
                showipceint $kgm_iep $kgm_name
                if $arg2 != 0
		   if $kgm_ie.ie_object != 0 && ($kgm_ie.ie_bits & 0x00070000) && ((ipc_port_t) $kgm_ie.ie_object)->ip_callstack[0] != 0
                   	printf "              user bt: "
                   	showportbt $kgm_ie.ie_object $kgm_is.is_task
                   end
		end
            end
            set $kgm_iindex = $kgm_iindex + 1
            set $kgm_iep = &($kgm_is.is_table[$kgm_iindex])
        end
    end
    printf "\n"
end


define showipc
    set $kgm_isp = (ipc_space_t)$arg0
    showipcheader
    showipcint $kgm_isp 0 0
end
document showipc
Syntax: (gdb) showipc <ipc_space>
| Routine to print the status of the specified ipc space
end

define showrights
	set $kgm_isp = (ipc_space_t)$arg0
    showipcheader
	showipcint $kgm_isp 1 0
end
document showrights
Syntax: (gdb) showrights <ipc_space>
| Routine to print a summary list of all the rights in a specified ipc space
end


define showtaskipc
	set $kgm_taskp = (task_t)$arg0
	showtaskheader
	showtaskint $kgm_taskp
        showipcheader
	showipcint $kgm_taskp->itk_space 0 0
end
document showtaskipc
Syntax: (gdb) showtaskipc <task>
| Routine to print info about the ipc space for a task
end


define showtaskrights
	set $kgm_taskp = (task_t)$arg0
	showtaskheader
	showtaskint $kgm_taskp
	showipcheader
	showipcint $kgm_taskp->itk_space 1 0
end
document showtaskrights
Syntax: (gdb) showtaskrights <task>
| Routine to print info about the ipc rights for a task
end

define showtaskrightsbt
	set $kgm_taskp = (task_t)$arg0
	showtaskheader
	showtaskint $kgm_taskp
  	showipcheader
	showipcint $kgm_taskp->itk_space 1 1
end
document showtaskrightsbt
Syntax: (gdb) showtaskrightsbt <task>
| Routine to print info about the ipc rights for a task with backtraces
end

define showallipc
    set $kgm_head_taskp = &tasks
    set $kgm_cur_taskp = (struct task *)($kgm_head_taskp->next)
    while $kgm_cur_taskp != $kgm_head_taskp
        showtaskheader
        showtaskint $kgm_cur_taskp
        showipcheader
        showipcint $kgm_cur_taskp->itk_space 0 0
    	set $kgm_cur_taskp = (struct task *)($kgm_cur_taskp->tasks.next)
    end
end
document showallipc
Syntax: (gdb) showallipc
| Routine to print a summary listing of all the ipc spaces
end

define showipcsumheader
    printf "task         "
    showptrhdrpad
    printf " pid         "
    printf " #acts         "
    printf " tsize "
    printf "command\n"
end

define showipcsummaryint
    set $kgm_taskp = (struct task *)$arg0
    showptr $arg0
    printf "%7d", ((struct proc *)$kgm_taskp->bsd_info)->p_pid
    printf "%15d", $kgm_taskp->thread_count
    printf "%15d", $kgm_cur_taskp->itk_space.is_table_size	
	printf " %s\n", ((struct proc *)$kgm_taskp->bsd_info)->p_comm
end

define showipcsummary
    showipcsumheader
    set $kgm_head_taskp = &tasks
    set $kgm_cur_taskp = (struct task *)($kgm_head_taskp->next)
    while $kgm_cur_taskp != $kgm_head_taskp
        showipcsummaryint $kgm_cur_taskp
    	set $kgm_cur_taskp = (struct task *)($kgm_cur_taskp->tasks.next)
    end
end

document showipcsummary
Syntax: (gdb) showipcsummary 
| Summarizes the IPC state of all tasks. This is a convenient way to dump
| some basic clues about IPC messaging. You can use the output to determine
| tasks that are candidates for further investigation.
end


define showallrights
    set $kgm_head_taskp = &tasks
    set $kgm_cur_taskp = (struct task *)($kgm_head_taskp->next)
    while $kgm_cur_taskp != $kgm_head_taskp
        showtaskheader
        showtaskint $kgm_cur_taskp
        showipcheader
        showipcint $kgm_cur_taskp->itk_space 1 0
    	set $kgm_cur_taskp = (struct task *)($kgm_cur_taskp->tasks.next)
    end
end
document showallrights
Syntax: (gdb) showallrights
| Routine to print a summary listing of all the ipc rights
end


define showtaskvm
	set $kgm_taskp = (task_t)$arg0
	showtaskheader
	showmapheader
	showtaskint $kgm_taskp
	showvmint $kgm_taskp->map 0
end
document showtaskvm
Syntax: (gdb) showtaskvm <task>
| Routine to print out info about a task's vm_map
end

define showtaskvme
	set $kgm_taskp = (task_t)$arg0
	showtaskheader
	showtaskint $kgm_taskp
	showmapheader
	showvmint $kgm_taskp->map 1
end
document showtaskvme
Syntax: (gdb) showtaskvme <task>
| Routine to print out info about a task's vm_map_entries
end


define showtaskheader
    printf "task      "
    showptrhdrpad
    printf "  vm_map    "
    showptrhdrpad
    printf "  ipc_space "
    showptrhdrpad
    printf " #acts "
    showprocheader
end


define showtaskint
    set $kgm_taskp = (struct task *)$arg0
    showptr $arg0
    printf "  "
    showptr $kgm_taskp->map
    printf "  "
    showptr $kgm_taskp->itk_space
    printf " %5d ", $kgm_taskp->thread_count
    showprocint $kgm_taskp->bsd_info
end

define showtask
    showtaskheader
    showtaskint $arg0
end
document showtask
Syntax (gdb) showtask <task>
| Routine to print out info about a task.
end


define showtaskthreads
    showtaskheader
    set $kgm_taskp = (struct task *)$arg0
    showtaskint $kgm_taskp
    showactheader
    set $kgm_head_actp = &($kgm_taskp->threads)
    set $kgm_actp = (struct thread *)($kgm_taskp->threads.next)
    while $kgm_actp != $kgm_head_actp
	showactint $kgm_actp 0
    	set $kgm_actp = (struct thread *)($kgm_actp->task_threads.next)
    end
end
document showtaskthreads
Syntax: (gdb) showtaskthreads <task>
| Routine to print info about the threads in a task.
end


define showtaskstacks
    showtaskheader
    set $kgm_taskp = (struct task *)$arg0
    showtaskint $kgm_taskp
    set $kgm_head_actp = &($kgm_taskp->threads)
    set $kgm_actp = (struct thread *)($kgm_taskp->threads.next)
    while $kgm_actp != $kgm_head_actp
        showactheader
	showactint $kgm_actp 1
    	set $kgm_actp = (struct thread *)($kgm_actp->task_threads.next)
    end
end
document showtaskstacks
Syntax: (gdb) showtaskstacks <task>
| Routine to print out the stack for each thread in a task.
end

define showqueue_elems
	set $queue_head = (struct queue_entry *)($arg0)
	set $queue = (struct queue_entry *)($queue_head->next)
    while $queue != $queue_head
		showptr $queue
		printf " "
		set $thread = (struct thread *)$queue
		set $task = (struct task *)$thread->task
		set $bsd = (struct proc *)$task->bsd_info
		set $guy = (char *)$bsd->p_comm
		showptr $thread
		printf " "
		showptr $task
		printf " "
		showptr $bsd
		printf " "
		showptr $guy
		#printf "  %s\n", $kgm_procp->p_comm
		printf "\n"
    	set $queue = (struct queue_entry *)($queue->next)
    end
end

define showalltasks
    showtaskheader
    set $kgm_head_taskp = &tasks
    set $kgm_taskp = (struct task *)($kgm_head_taskp->next)
    while $kgm_taskp != $kgm_head_taskp
	showtaskint $kgm_taskp
    	set $kgm_taskp = (struct task *)($kgm_taskp->tasks.next)
    end
end
document showalltasks
Syntax: (gdb) showalltasks
| Routine to print a summary listing of all the tasks
| wq_state -> reports "number of workq threads", "number of scheduled workq threads", "number of pending work items"
|   if "number of pending work items" seems stuck at non-zero, it may indicate that the workqueue mechanism is hung
| io_policy -> RAGE  - rapid aging of vnodes requested
|              NORM  - normal I/O explicitly requested (this is the default)
|              PASS  - passive I/O requested (i.e. I/Os do not affect throttling decisions)
|	       THROT - throttled I/O requested (i.e. thread/task may be throttled after each I/O completes)
end

define showprocheader
    printf "  pid  process     "
    showptrhdrpad
    printf "io_policy    wq_state   command\n"
end

define showprocint
    set $kgm_procp = (struct proc *)$arg0
    if $kgm_procp != 0
    	set $kgm_printed = 0
        printf "%5d  ", $kgm_procp->p_pid
	showptr $kgm_procp
	if ($kgm_procp->p_lflag & 0x400000)
	   printf "  RAGE "
	else
	   printf "       "
	end
	set $ptask = (struct task *)$kgm_procp->task
	set $diskpolicy = 0
	if ($ptask->ext_appliedstate.hw_disk != 0)
		set $diskpolicy = $ptask->ext_appliedstate.hw_disk
	else 
		if ($ptask->appliedstate.hw_disk != 0)
			set $diskpolicy = $ptask->appliedstate.hw_disk
		end
	end
	if ($ptask->ext_appliedstate.hw_bg != 0)
		set $diskpolicy = 5
	end
	if ($ptask->appliedstate.hw_bg != 0)
		set $diskpolicy = 4
	end
	if ($ptask->ext_appliedstate.apptype == 2)
		set $diskpolicy = 6
	end
	if ($diskpolicy == 2)
		printf "PASS    "
		set $kgm_printed = 1
	end
	if ($diskpolicy == 3)
		printf "THROT   "
		set $kgm_printed = 1
	end
	if ($diskpolicy == 4)
		printf "BG_THRT "
		set $kgm_printed = 1
	end
	if ($diskpolicy == 5)
		printf "EBG_THRT"
		set $kgm_printed = 1
	end
	if ($diskpolicy == 6)
		printf "APD_THRT"
		set $kgm_printed = 1
	end
	if ($kgm_printed == 0)
	   printf "      "
	end
	set $kgm_wqp = (struct workqueue *)$kgm_procp->p_wqptr
	if $kgm_wqp != 0
	   printf "  %2d %2d %2d ", $kgm_wqp->wq_nthreads, $kgm_wqp->wq_thidlecount, $kgm_wqp->wq_reqcount
	else
	   printf "           "
	end
	printf "  %s\n", $kgm_procp->p_comm
    else
	printf "  *0*  "
        showptr 0
        printf "  --\n"
    end
end

define showpid
    showtaskheader
    set $kgm_head_taskp = &tasks
    set $kgm_taskp = (struct task *)($kgm_head_taskp->next)
    while $kgm_taskp != $kgm_head_taskp
	set $kgm_procp = (struct proc *)$kgm_taskp->bsd_info
	if (($kgm_procp != 0) && ($kgm_procp->p_pid == $arg0))
	    showtaskint $kgm_taskp
	    set $kgm_taskp = $kgm_head_taskp
	else
    	    set $kgm_taskp = (struct task *)($kgm_taskp->tasks.next)
	end
    end
end
document showpid
Syntax: (gdb) showpid <pid>
| Routine to print a single process by pid
end

define showproc
    showtaskheader
    set $kgm_procp = (struct proc *)$arg0
    showtaskint $kgm_procp->task
end


define kdb
    set switch_debugger=1
    continue
end
document kdb
| kdb - Switch to the inline kernel debugger
|
| usage: kdb
|
| The kdb macro allows you to invoke the inline kernel debugger.
end

define showpsetheader
    printf "portset     "
    showptrhdrpad
    printf "waitqueue   "
    showptrhdrpad
    showptrhdrpad
    printf "recvname    flags refs  recvname    "
    showptrhdrpad
    printf "process\n"
end

define showportheader
    printf "port        "
    showptrhdrpad
    printf "mqueue      "
    showptrhdrpad
    showptrhdrpad
    printf "recvname    flags refs  recvname    "
    showptrhdrpad
    printf "dest\n"
end

define showportmemberheader
    printf "members     "
    showptrhdrpad
    printf "port        "
    showptrhdrpad
    showptrhdrpad
    printf "recvname    "
    printf "flags refs  mqueue      "
    showptrhdrpad
    printf "msgcount\n"
end

define showkmsgheader
    printf "dest-port   "
    showptrhdrpad
    printf "kmsg        "
    showptrhdrpad
    showptrhdrpad
    printf "msgid       "
    printf "disp  size  "
    printf "reply-port  "
    showptrhdrpad
    printf "source\n"
end

define showkmsgsrcint
    set $kgm_kmsgsrchp = ((ipc_kmsg_t)$arg0)->ikm_header
#    set $kgm_kmsgsrctp = (mach_msg_audit_trailer_t *)((uintptr_t)$kgm_kmsgsrchp + $kgm_kmsgsrchp->msgh_size)
#    set $kgm_kmsgpid = $kgm_kmsgsrctp->msgh_audit.val[5]
    set $kgm_kmsgpid = (pid_t)((uint *)((uintptr_t)$kgm_kmsgsrchp + $kgm_kmsgsrchp->msgh_size))[10]
# compare against a well-known or cached value as this may be slow
    if ($kgm_kmsgpid == 0)
       set $kgm_kmsgsrcpid = (pid_t)0
       set $kgm_kmsgsrcprocp = (struct proc *)kernel_task->bsd_info
    else 
       if ($kgm_kmsgpid != $kgm_kmsgsrcpid)
	  set $kgm_kmsgsrchead_taskp = &tasks
          set $kgm_kmsgsrctaskp = (struct task *)($kgm_kmsgsrchead_taskp->next)
          while $kgm_kmsgsrctaskp != $kgm_kmsgsrchead_taskp
	      set $kgm_kmsgsrcprocp = (struct proc *)$kgm_kmsgsrctaskp->bsd_info
	      set $kgm_kmsgsrcpid = $kgm_kmsgsrcprocp->p_pid
	      if (($kgm_kmsgsrcprocp != 0) && ($kgm_kmsgsrcprocp->p_pid == $kgm_kmsgpid))
	          set $kgm_kmsgsrctaskp = $kgm_kmsgsrchead_taskp
	      else
    	          set $kgm_kmsgsrctaskp = (struct task *)($kgm_kmsgsrctaskp->tasks.next)
	      end
          end
       end
    end
    if ($kgm_kmsgsrcprocp->p_pid == $kgm_kmsgpid)
    	printf "%s(%d)\n", $kgm_kmsgsrcprocp->p_comm, $kgm_kmsgpid
    else
        printf "unknown(%d)\n", $kgm_kmsgpid
    end
end

define showkmsgint
    set $kgm_kmsghp = ((ipc_kmsg_t)$arg0)->ikm_header
    set $kgm_kmsgh = *$kgm_kmsghp
    if ($arg1 != 0)
        printf "            "
        showptrhdrpad
    else
        showptr $kgm_kmsgh.msgh_remote_port
    end
    showptr $arg0
    showptrhdrpad
    printf "  0x%08x  ", $kgm_kmsgh.msgh_id
    if (($kgm_kmsgh.msgh_bits & 0xff) == 19)
	printf "rC"
    else
	printf "rM"
    end
    if (($kgm_kmsgh.msgh_bits & 0xff00) == (19 << 8))
	printf "lC"
    else
	printf "lM"
    end
    if ($kgm_kmsgh.msgh_bits & 0xf0000000)
	printf "c"
    else
	printf "s"
    end
    printf "%5d  ", $kgm_kmsgh.msgh_size
    showptr $kgm_kmsgh.msgh_local_port
    printf "  "
    set $kgm_kmsgsrcpid = (pid_t)0
    showkmsgsrcint $arg0
end

define showkmsg
    showkmsgint $arg0 0
end

define showkobject
    set $kgm_portp = (struct ipc_port *)$arg0
    showptr $kgm_portp->ip_kobject
    printf "  kobject("
    set $kgm_kotype = ($kgm_portp->ip_object.io_bits & 0x00000fff)
    if ($kgm_kotype == 1)
	printf "THREAD"
    end
    if ($kgm_kotype == 2)
	printf "TASK"
    end
    if ($kgm_kotype == 3)
	printf "HOST"
    end
    if ($kgm_kotype == 4)
	printf "HOST_PRIV"
    end
    if ($kgm_kotype == 5)
	printf "PROCESSOR"
    end
    if ($kgm_kotype == 6)
	printf "PSET"
    end
    if ($kgm_kotype == 7)
	printf "PSET_NAME"
    end
    if ($kgm_kotype == 8)
	printf "TIMER"
    end
    if ($kgm_kotype == 9)
	printf "PAGER_REQ"
    end
    if ($kgm_kotype == 10)
	printf "DEVICE"
    end
    if ($kgm_kotype == 11)
	printf "XMM_OBJECT"
    end
    if ($kgm_kotype == 12)
	printf "XMM_PAGER"
    end
    if ($kgm_kotype == 13)
	printf "XMM_KERNEL"
    end
    if ($kgm_kotype == 14)
	printf "XMM_REPLY"
    end
    if ($kgm_kotype == 15)
	printf "NOTDEF 15"
    end
    if ($kgm_kotype == 16)
	printf "NOTDEF 16"
    end
    if ($kgm_kotype == 17)
	printf "HOST_SEC"
    end
    if ($kgm_kotype == 18)
	printf "LEDGER"
    end
    if ($kgm_kotype == 19)
	printf "MASTER_DEV"
    end
    if ($kgm_kotype == 20)
	printf "ACTIVATION"
    end
    if ($kgm_kotype == 21)
	printf "SUBSYSTEM"
    end
    if ($kgm_kotype == 22)
	printf "IO_DONE_QUE"
    end
    if ($kgm_kotype == 23)
	printf "SEMAPHORE"
    end
    if ($kgm_kotype == 24)
	printf "LOCK_SET"
    end
    if ($kgm_kotype == 25)
	printf "CLOCK"
    end
    if ($kgm_kotype == 26)
	printf "CLOCK_CTRL"
    end
    if ($kgm_kotype == 27)
	printf "IOKIT_SPARE"
    end
    if ($kgm_kotype == 28)
	printf "NAMED_MEM"
    end
    if ($kgm_kotype == 29)
	printf "IOKIT_CON"
    end
    if ($kgm_kotype == 30)
	printf "IOKIT_OBJ"
    end
    if ($kgm_kotype == 31)
	printf "UPL"
    end
    if ($kgm_kotype == 34)
	printf "FD"
    end
    printf ")\n"
end

define showportdestproc
    set $kgm_portp = (struct ipc_port *)$arg0
    set $kgm_spacep = $kgm_portp->data.receiver
#   check against the previous cached value - this is slow
    if ($kgm_spacep != $kgm_destspacep)
	set $kgm_destprocp = (struct proc *)0
        set $kgm_head_taskp = &tasks
        set $kgm_desttaskp = (struct task *)($kgm_head_taskp->next)
        while (($kgm_destprocp == 0) && ($kgm_desttaskp != $kgm_head_taskp))
	    set $kgm_destspacep = $kgm_desttaskp->itk_space
	    if ($kgm_destspacep == $kgm_spacep)
	       set $kgm_destprocp = (struct proc *)$kgm_desttaskp->bsd_info
	    else
    	       set $kgm_desttaskp = (struct task *)($kgm_desttaskp->tasks.next)
            end
        end
    end
    if $kgm_destprocp != 0
       printf "%s(%d)\n", $kgm_destprocp->p_comm, $kgm_destprocp->p_pid
    else
       printf "task "
       showptr $kgm_desttaskp
       printf "\n"
    end
end

define showportdest
    set $kgm_portp = (struct ipc_port *)$arg0
    set $kgm_spacep = $kgm_portp->data.receiver
    if ((uintptr_t)$kgm_spacep == (uintptr_t)ipc_space_kernel)
	showkobject $kgm_portp
    else
	if ($kgm_portp->ip_object.io_bits & 0x80000000)
	    showptr $kgm_portp->ip_messages.data.port.receiver_name
        printf "  "
	    showportdestproc $kgm_portp
	else
        showptr $kgm_portp
	    printf "  inactive-port\n"
	end
    end
end

define showportmember
    printf "            "
    showptrhdrpad
    showptr $arg0
    showptrhdrpad
    set $kgm_portp = (struct ipc_port *)$arg0
    printf "  0x%08x  ", $kgm_portp->ip_messages.data.port.receiver_name
    if ($kgm_portp->ip_object.io_bits & 0x80000000)
	printf "A"
    else
	printf " "
    end
    printf "Port"
    printf "%5d  ", $kgm_portp->ip_object.io_references
    showptr &($kgm_portp->ip_messages)
    printf "  0x%08x\n", $kgm_portp->ip_messages.data.port.msgcount
end

define showportbt
    set $kgm_iebt = ((ipc_port_t) $arg0)->ip_callstack
    set $kgm_iepid = ((ipc_port_t) $arg0)->ip_spares[0]
    set $kgm_procpid = ((proc_t) (((task_t) $arg1)->bsd_info))->p_pid
    if $kgm_iebt[0] != 0
        showptr $kgm_iebt[0]
        set $kgm_iebt_loop_ctr = 1
        while ($kgm_iebt_loop_ctr < 16 && $kgm_iebt[$kgm_iebt_loop_ctr])
            printf " "
            showptr $kgm_iebt[$kgm_iebt_loop_ctr]
            set $kgm_iebt_loop_ctr = $kgm_iebt_loop_ctr + 1
        end
        if $kgm_iepid != $kgm_procpid
            printf " (%d)", $kgm_iepid
        end
        printf "\n"
    end
end

define showportint
    showptr $arg0
    printf "  "
    set $kgm_portp = (struct ipc_port *)$arg0
    showptr &($kgm_portp->ip_messages)
    showptrhdrpad
    printf "  0x%08x  ", $kgm_portp->ip_messages.data.port.receiver_name
    if ($kgm_portp->ip_object.io_bits & 0x80000000)
	printf "A"
    else
	printf "D"
    end
    printf "Port"
    printf "%5d  ", $kgm_portp->ip_object.io_references
    set $kgm_destspacep = (struct ipc_space *)0
    showportdest $kgm_portp
    set $kgm_kmsgp = (ipc_kmsg_t)$kgm_portp->ip_messages.data.port.messages.ikmq_base
    if $arg1 && $kgm_kmsgp
	showkmsgheader
	showkmsgint $kgm_kmsgp 1
	set $kgm_kmsgheadp = $kgm_kmsgp
	set $kgm_kmsgp = $kgm_kmsgp->ikm_next
	while $kgm_kmsgp != $kgm_kmsgheadp
	    showkmsgint $kgm_kmsgp 1
	    set $kgm_kmsgp = $kgm_kmsgp->ikm_next
        end
    end
end

define showpsetint
    showptr $arg0
    printf "  "
    set $kgm_psetp = (struct ipc_pset *)$arg0
    showptr &($kgm_psetp->ips_messages)
    showptrhdrpad
    printf "  0x%08x  ", $kgm_psetp->ips_messages.data.pset.local_name
    if ($kgm_psetp->ips_object.io_bits & 0x80000000)
	printf "A"
    else
	printf "D"
    end
    printf "Set "
    printf "%5d  ", $kgm_psetp->ips_object.io_references
    showptr $kgm_psetp->ips_messages.data.pset.local_name
    printf "  "
    set $kgm_setlinksp = &($kgm_psetp->ips_messages.data.pset.set_queue.wqs_setlinks)
    set $kgm_wql = (WaitQueueLink *)$kgm_setlinksp->next
    set $kgm_found = 0
    while ( (queue_entry_t)$kgm_wql != (queue_entry_t)$kgm_setlinksp)
        set $kgm_portp = (struct ipc_port *)((uintptr_t)($kgm_wql->wql_element->wqe_queue) - (uintptr_t)$kgm_portoff)
	if !$kgm_found  
	    set $kgm_destspacep = (struct ipc_space *)0
	    showportdestproc $kgm_portp
	    showportmemberheader
	    set $kgm_found = 1
	end
	showportmember $kgm_portp 0
	set $kgm_wql = (WaitQueueLink *)$kgm_wql->wql_setlinks.next
    end
    if !$kgm_found
	printf "--n/e--\n"
    end
end

define showpset
    set $kgm_portoff = &(((struct ipc_port *)0)->ip_messages)
    showpsetheader
    showpsetint $arg0 1
end

define showport
    showportheader
    showportint $arg0 1
end

define showipcobject
    set $kgm_objectp = (ipc_object_t)$arg0
    if ($kgm_objectp->io_bits & 0x7fff0000)
        set $kgm_portoff = &(((struct ipc_port *)0)->ip_messages)
	showpset $kgm_objectp
    else
	showport $kgm_objectp
    end
end

define showmqueue
    set $kgm_mqueue = *(struct ipc_mqueue *)$arg0
    if ($kgm_mqueue.data.pset.set_queue.wqs_wait_queue.wq_type == 0xf1d1)
	set $kgm_psetoff = &(((struct ipc_pset *)0)->ips_messages)
	set $kgm_pset = (((long)$arg0) - ((long)$kgm_psetoff))
        showpsetheader
	showpsetint $kgm_pset 1
    end
    if ($kgm_mqueue.data.pset.set_queue.wqs_wait_queue.wq_type == 0xf1d0)
        set $kgm_portoff = &(((struct ipc_port *)0)->ip_messages)
	set $kgm_port = (((long)$arg0) - ((long)$kgm_portoff))
	showportheader
	showportint $kgm_port 1
    end
end

define zprint_one
    set $kgm_zone = (struct zone *)$arg0

    showptr $kgm_zone
    printf "  %8d ",$kgm_zone->count
    printf "%8x ",$kgm_zone->cur_size
    printf "%8x ",$kgm_zone->max_size
    printf "%8d ",$kgm_zone->elem_size
    printf "%8x ",$kgm_zone->alloc_size
    if ($kgm_mtype != $kgm_mtype_arm) 
        printf " %16ld ",$kgm_zone->num_allocs 
        printf "%16ld ",$kgm_zone->num_frees
    end
    printf "%s ",$kgm_zone->zone_name

    if ($kgm_zone->exhaustible)
        printf "H"
    end
    if ($kgm_zone->collectable)
        printf "C"
    end
    if ($kgm_zone->expandable)
        printf "X"
    end
    if ($kgm_zone->noencrypt)
        printf "$"
    end
    printf "\n"
end


define zprint
    printf "ZONE      "
    showptrhdrpad
    printf "     COUNT   TOT_SZ   MAX_SZ   ELT_SZ ALLOC_SZ         TOT_ALLOC         TOT_FREE NAME\n"
    set $kgm_zone_ptr = (struct zone *)first_zone
    while ($kgm_zone_ptr != 0)
        zprint_one $kgm_zone_ptr
        set $kgm_zone_ptr = $kgm_zone_ptr->next_zone
    end
    printf "\n"
end
document zprint
Syntax: (gdb) zprint
| Routine to print a summary listing of all the kernel zones
end

define showmtxgrp
    set $kgm_mtxgrp = (struct _lck_grp_ *)$arg0

    if ($kgm_mtxgrp->lck_grp_mtxcnt)
        showptr $kgm_mtxgrp
        printf " %8d ",$kgm_mtxgrp->lck_grp_mtxcnt
        printf "%12u ",$kgm_mtxgrp->lck_grp_stat.lck_grp_mtx_stat.lck_grp_mtx_util_cnt
        printf "%8u ",$kgm_mtxgrp->lck_grp_stat.lck_grp_mtx_stat.lck_grp_mtx_miss_cnt
        printf "%8u ",$kgm_mtxgrp->lck_grp_stat.lck_grp_mtx_stat.lck_grp_mtx_wait_cnt
        printf "%s ",&$kgm_mtxgrp->lck_grp_name
        printf "\n"
    end
end


define showallmtx
    printf "LCK GROUP "
    showptrhdrpad
    printf "      CNT         UTIL     MISS     WAIT NAME\n"
    set $kgm_mtxgrp_ptr = (struct _lck_grp_ *)&lck_grp_queue
    set $kgm_mtxgrp_ptr = (struct _lck_grp_ *)$kgm_mtxgrp_ptr->lck_grp_link.next
    while ($kgm_mtxgrp_ptr != (struct _lck_grp_ *)&lck_grp_queue)
        showmtxgrp $kgm_mtxgrp_ptr
        set $kgm_mtxgrp_ptr = (struct _lck_grp_ *)$kgm_mtxgrp_ptr->lck_grp_link.next
    end
    printf "\n"
end
document showallmtx
Syntax: (gdb) showallmtx
| Routine to print a summary listing of all mutexes
end

define showrwlckgrp
    set $kgm_rwlckgrp = (struct _lck_grp_ *)$arg0

    if ($kgm_rwlckgrp->lck_grp_rwcnt)
        showptr $kgm_rwlckgrp
        printf " %8d ",$kgm_rwlckgrp->lck_grp_rwcnt
        printf "%12u ",$kgm_rwlckgrp->lck_grp_stat.lck_grp_rw_stat.lck_grp_rw_util_cnt
        printf "%8u ",$kgm_rwlckgrp->lck_grp_stat.lck_grp_rw_stat.lck_grp_rw_miss_cnt
        printf "%8u ",$kgm_rwlckgrp->lck_grp_stat.lck_grp_rw_stat.lck_grp_rw_wait_cnt
        printf "%s ",&$kgm_rwlckgrp->lck_grp_name
        printf "\n"
    end
end


define showallrwlck
    printf "LCK GROUP "
    showptrhdrpad
    printf "      CNT         UTIL     MISS     WAIT NAME\n"
    set $kgm_rwlckgrp_ptr = (struct _lck_grp_ *)&lck_grp_queue
    set $kgm_rwlckgrp_ptr = (struct _lck_grp_ *)$kgm_rwlckgrp_ptr->lck_grp_link.next
    while ($kgm_rwlckgrp_ptr != (struct _lck_grp_ *)&lck_grp_queue)
        showrwlckgrp $kgm_rwlckgrp_ptr
        set $kgm_rwlckgrp_ptr = (struct _lck_grp_ *)$kgm_rwlckgrp_ptr->lck_grp_link.next
    end
    printf "\n"
end
document showallrwlck
Syntax: (gdb) showallrwlck
| Routine to print a summary listing of all read/writer locks
end

set $kdp_act_counter = 0
set $kdp_arm_act_counter = 0

set $r0_save	= 0
set $r1_save	= 0
set $r2_save	= 0
set $r3_save	= 0
set $r4_save	= 0
set $r5_save	= 0
set $r6_save	= 0
set $r7_save	= 0
set $r8_save	= 0
set $r9_save	= 0
set $r10_save	= 0
set $r11_save	= 0
set $r12_save	= 0
set $sp_save	= 0
set $lr_save	= 0
set $pc_save	= 0

define showcontext_int
	echo Context switched, current instruction pointer: 
	output/a $pc
	echo \n
end

define switchtoact
	set $newact = (struct thread *) $arg0
	select 0
	if ($newact->kernel_stack == 0)
		echo This activation does not have a stack.\n
		echo continuation:
		output/a (unsigned) $newact.continuation
		echo \n
	else
		if ($kgm_mtype == $kgm_mtype_ppc)
			if ($kdp_act_counter == 0)
				set $kdpstate = (struct savearea *) kdp.saved_state
			end
			set $kdp_act_counter = $kdp_act_counter + 1
			set (struct savearea *) kdp.saved_state=$newact->machine->pcb
			flushregs
			flushstack
			set $pc=$newact->machine->pcb.save_srr0
			update
		end
		if ($kgm_mtype == $kgm_mtype_i386)
			set $kdpstatep = (struct x86_saved_state32 *) kdp.saved_state
			if ($kdp_act_counter == 0)
			   set $kdpstate = *($kdpstatep)
			end	
			set $kdp_act_counter = $kdp_act_counter + 1
	
			set $kgm_statep = (struct x86_kernel_state *) \
						($newact->kernel_stack + kernel_stack_size \
						 - sizeof(struct x86_kernel_state))
			set $kdpstatep->ebx = $kgm_statep->k_ebx 
			set $kdpstatep->ebp = $kgm_statep->k_ebp 
			set $kdpstatep->edi = $kgm_statep->k_edi 
			set $kdpstatep->esi = $kgm_statep->k_esi 
			set $kdpstatep->eip = $kgm_statep->k_eip 
			flushregs
			flushstack
			set $pc = $kgm_statep->k_eip
			update
		end
		if ($kgm_mtype == $kgm_mtype_x86_64)
			set $kdpstatep = (struct x86_saved_state64 *) kdp.saved_state
			if ($kdp_act_counter == 0)
			   set $kdpstate = *($kdpstatep)
			end	
			set $kdp_act_counter = $kdp_act_counter + 1
	
			set $kgm_statep = (struct x86_kernel_state *) \
						($newact->kernel_stack + kernel_stack_size \
						 - sizeof(struct x86_kernel_state))
			set $kdpstatep->rbx = $kgm_statep->k_rbx 
			set $kdpstatep->rbp = $kgm_statep->k_rbp 
			set $kdpstatep->r12 = $kgm_statep->k_r12 
			set $kdpstatep->r13 = $kgm_statep->k_r13 
			set $kdpstatep->r14 = $kgm_statep->k_r14 
			set $kdpstatep->r15 = $kgm_statep->k_r15 
			set $kdpstatep->isf.rsp = $kgm_statep->k_rsp 
			flushregs
			flushstack
			set $pc = $kgm_statep->k_rip
			update
		end
		if ($kgm_mtype == $kgm_mtype_arm)
			set $kdp_arm_act_counter = $kdp_arm_act_counter + 1
			if ($kdp_arm_act_counter == 1)
				set $r0_save   = $r0
				set $r1_save   = $r1
				set $r2_save   = $r2
				set $r3_save   = $r3
				set $r4_save   = $r4
				set $r5_save   = $r5
				set $r6_save   = $r6
				set $r7_save   = $r7
				set $r8_save   = $r8
				set $r9_save   = $r9
				set $r10_save  = $r10
				set $r11_save  = $r11
				set $r12_save  = $r12
				set $sp_save   = $sp
				set $lr_save   = $lr
				set $pc_save   = $pc
			end
			set $pc_ctx = load_reg+8
			set $kgm_statep = (struct arm_saved_state *)((struct thread*)$arg0)->machine.kstackptr
			set $r0 =  $kgm_statep->r[0]
			set $r1 =  $kgm_statep->r[1]
			set $r2 =  $kgm_statep->r[2]
			set $r3 =  $kgm_statep->r[3]
			set $r4 =  $kgm_statep->r[4]
			set $r5 =  $kgm_statep->r[5]
			set $r6 =  $kgm_statep->r[6]
			set $r8 =  $kgm_statep->r[8]
			set $r9 =  $kgm_statep->r[9]
			set $r10 = $kgm_statep->r[10]
			set $r11 = $kgm_statep->r[11]
			set $r12 = $kgm_statep->r[12]
			set $sp = $kgm_statep->sp
			set $lr = $kgm_statep->lr
			set $pc = $pc_ctx
			set $r7 =  $kgm_statep->r[7]
			flushregs
			flushstack
		end
	end
	showcontext_int
end

document switchtoact  
Syntax: switchtoact <address of activation>
| This command allows gdb to examine the execution context and call
| stack for the specified activation. For example, to view the backtrace
| for an activation issue "switchtoact <address>", followed by "bt".
| Before resuming execution, issue a "resetctx" command, to
| return to the original execution context.
end     

define switchtoctx
	select 0
	if ($kgm_mtype == $kgm_mtype_ppc)
		if ($kdp_act_counter == 0)
		   set $kdpstate = (struct savearea *) kdp.saved_state
		end
		set $kdp_act_counter = $kdp_act_counter + 1
		set (struct savearea *) kdp.saved_state=(struct savearea *) $arg0
		flushregs
		flushstack
		set $pc=((struct savearea *) $arg0)->save_srr0
		update
	else
		if ($kgm_mtype == $kgm_mtype_arm)
			select 0
			set $kdp_arm_act_counter = $kdp_arm_act_counter + 1
			if ($kdp_arm_act_counter == 1)
				set $r0_save   = $r0
				set $r1_save   = $r1
				set $r2_save   = $r2
				set $r3_save   = $r3
				set $r4_save   = $r4
				set $r5_save   = $r5
				set $r6_save   = $r6
				set $r7_save   = $r7
				set $r8_save   = $r8
				set $r9_save   = $r9
				set $r10_save  = $r10
				set $r11_save  = $r11
				set $r12_save  = $r12
				set $sp_save   = $sp
				set $lr_save   = $lr
				set $pc_save   = $pc
			end
			set $kgm_statep = (struct arm_saved_state *)$arg0
			set $r0 =  $kgm_statep->r[0]
			set $r1 =  $kgm_statep->r[1]
			set $r2 =  $kgm_statep->r[2]
			set $r3 =  $kgm_statep->r[3]
			set $r4 =  $kgm_statep->r[4]
			set $r5 =  $kgm_statep->r[5]
			set $r6 =  $kgm_statep->r[6]
			set $r8 =  $kgm_statep->r[8]
			set $r9 =  $kgm_statep->r[9]
			set $r10 = $kgm_statep->r[10]
			set $r11 = $kgm_statep->r[11]
			set $r12 = $kgm_statep->r[12]
			set $sp = $kgm_statep->sp
			set $lr = $kgm_statep->lr
			set $r7 =  $kgm_statep->r[7]
			set $pc = $kgm_statep->pc
			flushregs
			flushstack
			update
		else
			echo switchtoctx not implemented for this architecture.\n
		end
	end
end


document switchtoctx  
Syntax: switchtoctx <address of pcb>
| This command allows gdb to examine an execution context and dump the
| backtrace for this execution context.
| Before resuming execution, issue a "resetctx" command, to
| return to the original execution context.
end     

define resetctx
	select 0
	if ($kdp_act_counter != 0)
		if ($kgm_mtype == $kgm_mtype_ppc)
			set (struct savearea *)kdp.saved_state=$kdpstate
			flushregs
			flushstack
			set $pc=((struct savearea *) kdp.saved_state)->save_srr0
			update
			set $kdp_act_counter = 0
		end
		if ($kgm_mtype == $kgm_mtype_i386)
			set $kdpstatep = (struct x86_saved_state32 *) kdp.saved_state
			set *($kdpstatep)=$kdpstate
			flushregs
			flushstack
			set $pc=$kdpstatep->eip
			update
			set $kdp_act_counter = 0
		end
		if ($kgm_mtype == $kgm_mtype_x86_64)
			set $kdpstatep = (struct x86_saved_state64 *) kdp.saved_state
			set *($kdpstatep)=$kdpstate
			flushregs
			flushstack
			set $pc=$kdpstatep->isf.rip
			update
			set $kdp_act_counter = 0
		end
		showcontext_int
	end
	if ($kgm_mtype == $kgm_mtype_arm && $kdp_arm_act_counter != 0)
		echo Restoring context\n
		set $r0  = $r0_save
		flushregs
		set $r1  = $r1_save
		flushregs
		set $r2  = $r2_save
		flushregs
		set $r3  = $r3_save
		flushregs
		set $r4  = $r4_save
		flushregs
		set $r5  = $r5_save
		flushregs
		set $r6  = $r6_save
		flushregs
		set $r8  = $r8_save
		flushregs
		set $r9  = $r9_save
		flushregs
		set $r10 = $r10_save
		flushregs
		set $r11 = $r11_save
		flushregs
		set $r12 = $r12_save
		flushregs
		set $sp  = $sp_save
		flushregs
		set $lr  = $lr_save
		flushregs
		set $pc  = $pc_save
		flushregs
		set $r7  = $r7_save
		flushregs
		flushstack
		update
		set $kdp_arm_act_counter = 0
	end
end     
        
document resetctx
| Syntax: resetctx
| Returns to the original execution context. This command should be
| issued if you wish to resume execution after using the "switchtoact"
| or "switchtoctx" commands.
end     

# This is a pre-hook for the continue command, to prevent inadvertent attempts 
# to resume from the context switched to for examination.
define hook-continue
       resetctx
end

# This is a pre-hook for the detach command, to prevent inadvertent attempts 
# to resume from the context switched to for examination.
define hook-detach
       resetctx
end

define resume_on
        set $resume = KDP_DUMPINFO_SETINFO | KDP_DUMPINFO_RESUME
        dumpinfoint $resume
end

document resume_on
| Syntax: resume_on
| The target system will resume when detaching  or exiting from gdb. 
| This is the default behavior.
end

define resume_off
        set $noresume = KDP_DUMPINFO_SETINFO | KDP_DUMPINFO_NORESUME
        dumpinfoint $noresume
end

document resume_off
| Syntax: resume_off
| The target system  won't resume after detaching from gdb and
| can be attached with a new gdb session
end

define paniclog
	set $kgm_panic_bufptr = debug_buf
	set $kgm_panic_bufptr_max = debug_buf_ptr
	while $kgm_panic_bufptr < $kgm_panic_bufptr_max
		if *(char *)$kgm_panic_bufptr == 10
			printf "\n"
		else
			printf "%c", *(char *)$kgm_panic_bufptr
		end
		set $kgm_panic_bufptr= (char *)$kgm_panic_bufptr + 1
	end
end

document paniclog
| Syntax: paniclog
| Display the panic log information
|
end

define dumpcallqueue
	set $kgm_callhead = $arg0
	set $kgm_callentry = $kgm_callhead->next
	set $kgm_i = 0
	while $kgm_callentry != $kgm_callhead
		set $kgm_call = (struct call_entry *)$kgm_callentry
		showptr $kgm_call
		printf "0x%lx 0x%lx ", $kgm_call->param0, $kgm_call->param1
		output $kgm_call->deadline
		printf "\t"
		output $kgm_call->func
		printf "\n"
		set $kgm_i = $kgm_i + 1
		set $kgm_callentry = $kgm_callentry->next
	end
	printf "%d entries\n", $kgm_i
end

document dumpcallqueue
| Syntax: dumpcallqueue <queue head>
| Displays the contents of the specified call_entry queue.
end

define showtaskacts
showtaskthreads $arg0
end
document showtaskacts
| See help showtaskthreads.
end

define showallacts
showallthreads
end
document showallacts
| See help showallthreads.
end


define resetstacks
       _kgm_flush_loop
       set kdp_pmap = 0
       _kgm_flush_loop
       resetctx
       _kgm_flush_loop
       _kgm_update_loop
       resetctx
       _kgm_update_loop
end

document resetstacks
| Syntax: resetstacks
| Internal kgmacro routine used by the "showuserstack" macro 
| to reset the target pmap to the kernel pmap.
end

#Barely effective hacks to work around bugs in the "flush" and "update" 
#gdb commands in Tiger (up to 219); these aren't necessary with Panther
#gdb, but do no harm.
define _kgm_flush_loop
       set $kgm_flush_loop_ctr = 0
       while ($kgm_flush_loop_ctr < 30)
       	     flushregs
	     flushstack
	     set $kgm_flush_loop_ctr = $kgm_flush_loop_ctr + 1
       end
end

define _kgm_update_loop
       set $kgm_update_loop_ctr = 0
       while ($kgm_update_loop_ctr < 30)
       	     update
       	     set $kgm_update_loop_ctr = $kgm_update_loop_ctr + 1
       end
end
# Internal routine used by "_loadfrom" to read from 64-bit addresses
# on 32-bit kernels
define _loadk32m64
       # set up the manual KDP packet
       set manual_pkt.input = 0
       set manual_pkt.len = sizeof(kdp_readmem64_req_t)
       set $kgm_pkt = (kdp_readmem64_req_t *)&manual_pkt.data
       set $kgm_pkt->hdr.request = KDP_READMEM64
       set $kgm_pkt->hdr.len = sizeof(kdp_readmem64_req_t)
       set $kgm_pkt->hdr.is_reply = 0
       set $kgm_pkt->hdr.seq = 0
       set $kgm_pkt->hdr.key = 0
       set $kgm_pkt->address = (uint64_t)$arg0
       set $kgm_pkt->nbytes = sizeof(uint64_t)
       set manual_pkt.input = 1
       # dummy to make sure manual packet is executed
       set $kgm_dummy = &_mh_execute_header
       set $kgm_pkt = (kdp_readmem64_reply_t *)&manual_pkt.data
       if ($kgm_pkt->error == 0)
       	  	set $kgm_k32read64 = *(uint64_t *)$kgm_pkt->data
       else
		set $kgm_k32read64 = 0
       end
end

# Internal routine used by "showx86backtrace" to abstract possible loads from
# user space
define _loadfrom
	if (kdp_pmap == 0)
		set $kgm_loadval = *(uintptr_t *)$arg0
	else
	if ($kgm_x86_abi == 0xe)
	      set $kgm_loadval = *(uint32_t *)$arg0
	else
	if ($kgm_x86_abi == 0xf)
	    if ($kgm_mtype == $kgm_mtype_i386)
	    	    _loadk32m64 $arg0
	    	    set $kgm_loadval = $kgm_k32read64
	    else
	    	    set $kgm_loadval = *(uint64_t *)$arg0
	    end
	end
	end
end
end


#This is necessary since gdb often doesn't do backtraces on x86 correctly
#in the absence of symbols.The code below in showuserstack and 
#showx86backtrace also contains several workarouds for the gdb bug where 
#gdb stops macro evaluation because of spurious "Cannot read memory"
#errors on x86. These errors appear on ppc as well, but they don't
#always stop macro evaluation.

set $kgm_cur_frame = 0
set $kgm_cur_pc = 0
set $kgm_x86_abi = 0
define showx86backtrace
	if ($kgm_mtype == $kgm_mtype_i386)
		set $kgm_frame_reg = $ebp
		set $kgm_pc = $eip
		set $kgm_ret_off = 4
	end
	if ($kgm_mtype == $kgm_mtype_x86_64)
		set $kgm_frame_reg = $rbp
		set $kgm_pc = $rip
		set $kgm_ret_off = 8
	end

	if ($kgm_x86_abi == 0xe)
		set $kgm_ret_off = 4
	end
	if ($kgm_x86_abi == 0xf)
		set $kgm_ret_off = 8
	end

	if ($kgm_cur_frame == 0)
		set $kgm_cur_frame = $kgm_frame_reg
	end
	if ($kgm_cur_pc == 0)
		set $kgm_cur_pc = $kgm_pc
	end
	printf "0: Frame: 0x%016llx PC: 0x%016llx\n", $kgm_cur_frame, $kgm_cur_pc
	if (!(($kgm_x86_abi == 0xf) && ($kgm_mtype == $kgm_mtype_i386)))
		x/i $kgm_cur_pc
	end
	set $kgm_tmp_frame = $kgm_cur_frame
	set $kgm_cur_frame = 0
	set $kgm_cur_pc = 0
	_loadfrom ($kgm_tmp_frame)
	set $kgm_prev_frame = $kgm_loadval
	_loadfrom ($kgm_tmp_frame+$kgm_ret_off)
	set $kgm_prev_pc = $kgm_loadval
	set $kgm_frameno = 1
	while ($kgm_prev_frame != 0) && ($kgm_prev_frame != 0x0000000800000008)
		printf "%d: Saved frame: 0x%016llx Saved PC: 0x%016llx\n", $kgm_frameno, $kgm_prev_frame, $kgm_prev_pc
		if (!(($kgm_x86_abi == 0xf) && ($kgm_mtype == $kgm_mtype_i386)))
		   x/i $kgm_prev_pc
		end
		_loadfrom ($kgm_prev_frame+$kgm_ret_off)
		set $kgm_prev_pc = $kgm_loadval
		_loadfrom ($kgm_prev_frame)
		set $kgm_prev_frame = $kgm_loadval
		set $kgm_frameno = $kgm_frameno + 1
	end
	set kdp_pmap = 0
	set $kgm_x86_abi = 0
end

define showx86backtrace2
	set $kgm_cur_frame = $arg0
	set $kgm_cur_pc = $arg1
	showx86backtrace
end

define showuserstack
		select 0
  		if ($kgm_mtype == $kgm_mtype_ppc)	
		   if ($kdp_act_counter == 0)
		      set $kdpstate = (struct savearea *) kdp.saved_state
		   end
		   set $kdp_act_counter = $kdp_act_counter + 1
		   set $newact = (struct thread *) $arg0
		   _kgm_flush_loop
		   set $checkpc = $newact->machine->upcb.save_srr0
		   if ($checkpc == 0)
		      echo This activation does not appear to have
		      echo \20 a valid user context.\n
		   else	      
		     set (struct savearea *) kdp.saved_state=$newact->machine->upcb
		     set $pc = $checkpc
#flush and update seem to be executed lazily by gdb on Tiger, hence the
#repeated invocations - see 3743135
	   	    _kgm_flush_loop
# This works because the new pmap is used only for reads
		     set kdp_pmap = $newact->task->map->pmap
		     _kgm_flush_loop
		     _kgm_update_loop
		     bt
		     resetstacks
		     _kgm_flush_loop
		     _kgm_update_loop
		     resetstacks
		     _kgm_flush_loop
		     _kgm_update_loop
		   end
		else
		if (($kgm_mtype & $kgm_mtype_x86_mask) == $kgm_mtype_x86_any)
			set $newact = (struct thread *) $arg0
			set $newiss = (x86_saved_state_t *) ($newact->machine->iss)
			set $kgm_x86_abi = $newiss.flavor
			if ($newiss.flavor == 0xf) 
	   			set $checkpc = $newiss.uss.ss_64.isf.rip
				set $checkframe = $newiss.uss.ss_64.rbp

			else
				set $checkpc = $newiss.uss.ss_32.eip
				set $checkframe = $newiss.uss.ss_32.ebp
			end

			if ($checkpc == 0)
			    echo This activation does not appear to have
			    echo \20 a valid user context.\n
			else
			set $kgm_cur_frame = $checkframe
			set $kgm_cur_pc = $checkpc
# When have more than one argument is present, don't print usage
			if ( $argc == 1 )
				printf "You may now issue the showx86backtrace command to see the user space backtrace for this thread ("
				showptr $arg0
				printf "); you can also examine memory locations in this address space (pmap "
				showptr $newact->task->map->pmap
				printf ") before issuing the backtrace. This two-step process is necessary to work around various bugs in x86 gdb, which cause it to stop memory evaluation on spurious memory read errors. Additionally, you may need to issue a set kdp_pmap = 0 command after the showx86backtrace completes, to resume reading from the kernel address space.\n"
			end
			set kdp_pmap = $newact->task->map->pmap
			_kgm_flush_loop
			_kgm_update_loop
			end			
		else
		if ($kgm_mtype == $kgm_mtype_arm)
			if (kdp->is_conn > 0)
				set $kgm_threadp = (struct thread *)$arg0
				set $kgm_saved_pmap = kdp_pmap
				showactheader
				showactint $kgm_threadp 0
				set $kgm_thread_pmap = $kgm_threadp->task->map->pmap
				set $kgm_thread_sp = $kgm_threadp.machine->PcbData.r[7]
				showptrhdrpad
				printf "                  "
				showptr 0
				printf "  "
				showptr $kgm_threadp.machine->PcbData.pc
				printf "\n"
				set kdp_pmap = $kgm_thread_pmap
				while ($kgm_thread_sp != 0)
    				set $link_register = *($kgm_thread_sp + 4)
    				showptrhdrpad
					printf "                  "
					showptr $kgm_thread_sp
					printf "  "
    				showptr $link_register
    				printf "\n"
    				set $kgm_thread_sp = *$kgm_thread_sp
  				end
				set kdp_pmap = $kgm_saved_pmap
			else
				set $kgm_threadp = (struct thread *)$arg0
				showactheader
				showactint $kgm_threadp 0
				set $kgm_thread_sp = $kgm_threadp.machine->PcbData.r[7]
				while ($kgm_thread_sp != 0)
				_map_user_data_from_task $kgm_threadp->task $kgm_thread_sp 8
				set $kgm_thread_sp_window = (int *)$kgm_map_user_window
    				set $link_register = *($kgm_thread_sp_window + 1)
    				showptrhdrpad
					printf "                  "
					showptr $kgm_thread_sp
					printf "  "
    				showptr $link_register
    				printf "\n"
    				set $kgm_thread_sp = *$kgm_thread_sp_window
				_unmap_user_data_from_task
  				end
			end
		else
			echo showuserstack not supported on this architecture\n
		end
		end
		end
end
document showuserstack
Syntax: showuserstack <address of thread activation>
|This command displays a numeric backtrace for the user space stack of
|the given thread activation. It may, of course, fail to display a
|complete backtrace if portions of the user stack are not mapped in.
|Symbolic backtraces can be obtained either by running gdb on the
|user space binary, or a tool such as "symbolicate".
|Note that while this command works on Panther's gdb, an issue
|with Tiger gdb (3743135) appears to hamper the evaluation of this
|macro in some cases.
end

define showtaskuserstacks
    set $kgm_taskp = (struct task *)$arg0
    set $kgm_head_actp = &($kgm_taskp->threads)
    set $kgm_actp = (struct thread *)($kgm_taskp->threads.next)
    while $kgm_actp != $kgm_head_actp
    	printf "For thread "
	showptr $kgm_actp
	printf "\n"
	showuserstack $kgm_actp quiet
	if (($kgm_mtype & $kgm_mtype_x86_mask) == $kgm_mtype_x86_any)
		showx86backtrace
	end
	set kdp_pmap=0
    	set $kgm_actp = (struct thread *)($kgm_actp->task_threads.next)
    	printf "\n"
    end
    showuserlibraries $kgm_taskp
end
document showtaskuserstacks
Syntax: (gdb) showtaskuserstacks <task>
| Print out the user stack for each thread in a task, followed by the user libraries.
end


define showuserregisters
	set $kgm_threadp = (struct thread *)$arg0
	set $kgm_taskp = $kgm_threadp->task
	if (($kgm_mtype & $kgm_mtype_x86_mask) == $kgm_mtype_x86_any)
		set $newiss = (x86_saved_state_t *) ($kgm_threadp->machine.iss)
		set $kgm_x86_abi = $newiss.flavor
		if ($newiss.flavor == 0xf)
			printf "X86 Thread State (64-bit):\n"
	   		set $kgm_ss64 = $newiss.uss.ss_64

			printf "  rax: "
			showuserptr $kgm_ss64.rax
			printf "  rbx: "
			showuserptr $kgm_ss64.rbx
			printf "  rcx: "
			showuserptr $kgm_ss64.rcx
			printf "  rdx: "
			showuserptr $kgm_ss64.rdx
			printf "\n"

			printf "  rdi: "
			showuserptr $kgm_ss64.rdi
			printf "  rsi: "
			showuserptr $kgm_ss64.rsi
			printf "  rbp: "
			showuserptr $kgm_ss64.rbp
			printf "  rsp: "
			showuserptr $kgm_ss64.isf.rsp
			printf "\n"

			printf "   r8: "
			showuserptr $kgm_ss64.r8
			printf "   r9: "
			showuserptr $kgm_ss64.r9
			printf "  r10: "
			showuserptr $kgm_ss64.r10
			printf "  r11: "
			showuserptr $kgm_ss64.r11
			printf "\n"

			printf "  r12: "
			showuserptr $kgm_ss64.r12
			printf "  r13: "
			showuserptr $kgm_ss64.r13
			printf "  r14: "
			showuserptr $kgm_ss64.r14
			printf "  r15: "
			showuserptr $kgm_ss64.r15
			printf "\n"

			printf "  rip: "
			showuserptr $kgm_ss64.isf.rip
			printf "  rfl: "
			showuserptr $kgm_ss64.isf.rflags
			printf "  cr2: "
			showuserptr $kgm_ss64.cr2
			printf "\n"
		else
			printf "X86 Thread State (32-bit):\n"
	   		set $kgm_ss32 = $newiss.uss.ss_32

			printf "  eax: "
			showuserptr $kgm_ss32.eax
			printf "  ebx: "
			showuserptr $kgm_ss32.ebx
			printf "  ecx: "
			showuserptr $kgm_ss32.ecx
			printf "  edx: "
			showuserptr $kgm_ss32.edx
			printf "\n"

			printf "  edi: "
			showuserptr $kgm_ss32.edi
			printf "  esi: "
			showuserptr $kgm_ss32.esi
			printf "  ebp: "
			showuserptr $kgm_ss32.ebp
			printf "  esp: "
			showuserptr $kgm_ss32.uesp
			printf "\n"

			printf "   ss: "
			showuserptr $kgm_ss32.ss
			printf "  efl: "
			showuserptr $kgm_ss32.efl
			printf "  eip: "
			showuserptr $kgm_ss32.eip
			printf "   cs: "
			showuserptr $kgm_ss32.cs
			printf "\n"

			printf "   ds: "
			showuserptr $kgm_ss32.ds
			printf "   es: "
			showuserptr $kgm_ss32.es
			printf "   fs: "
			showuserptr $kgm_ss32.fs
			printf "   gs: "
			showuserptr $kgm_ss32.gs
			printf "\n"

			printf "  cr2: "
			showuserptr $kgm_ss32.cr2
			printf "\n"
		end
	else
	if ($kgm_mtype == $kgm_mtype_arm)
		printf "ARM Thread State:\n"
		set $kgm_pcb = (arm_saved_state_t *) (&$kgm_threadp->machine.PcbData)

		printf "    r0: "
		showuserptr $kgm_pcb.r[0]
		printf "    r1: "
		showuserptr $kgm_pcb.r[1]
		printf "    r2: "
		showuserptr $kgm_pcb.r[2]
		printf "    r3: "
		showuserptr $kgm_pcb.r[3]
		printf "\n"

		printf "    r4: "
		showuserptr $kgm_pcb.r[4]
		printf "    r5: "
		showuserptr $kgm_pcb.r[5]
		printf "    r6: "
		showuserptr $kgm_pcb.r[6]
		printf "    r7: "
		showuserptr $kgm_pcb.r[7]
		printf "\n"

		printf "    r8: "
		showuserptr $kgm_pcb.r[8]
		printf "    r9: "
		showuserptr $kgm_pcb.r[9]
		printf "   r10: "
		showuserptr $kgm_pcb.r[10]
		printf "   r11: "
		showuserptr $kgm_pcb.r[11]
		printf "\n"

		printf "    ip: "
		showuserptr $kgm_pcb.r[12]
		printf "    sp: "
		showuserptr $kgm_pcb.sp
		printf "    lr: "
		showuserptr $kgm_pcb.lr
		printf "    pc: "
		showuserptr $kgm_pcb.pc
		printf "\n"

		printf "  cpsr: "
		showuserptr $kgm_pcb.cpsr
		printf "\n"
	else
		echo showuserregisters not supported on this architecture\n
	end
	end
end
document showuserregisters
Syntax: showuserstack <address of thread>
|This command displays the last known user register state
|for the thread. This map not be correct for cases where
|the thread is currently executing in userspace. However
|for threads that have entered the kernel (either explicitly
|with a system call or implicitly with a fault), it should
|be accurate
end

define showtaskuserregisters
    set $kgm_taskp = (struct task *)$arg0
    set $kgm_head_actp = &($kgm_taskp->threads)
    set $kgm_actp = (struct thread *)($kgm_taskp->threads.next)
    while $kgm_actp != $kgm_head_actp
    	printf "For thread "
	showptr $kgm_actp
	printf "\n"
	showuserregisters $kgm_actp
    	set $kgm_actp = (struct thread *)($kgm_actp->task_threads.next)
    	printf "\n"
    end
end
document showtaskuserregisters
Syntax: (gdb) showtaskuserregisters <task>
| Print out the user registers for each thread in a task
end

define kdp-reboot
# Alternatively, set *(*(unsigned **) 0x2498) = 1 
# (or 0x5498 on PPC, 0xffffff8000002928 on x86_64, 0xffff049c on arm)
       manualhdrint $kgm_kdp_pkt_hostreboot
       detach
end

document kdp-reboot
Syntax: kdp-reboot
|Reboot the remote target machine; not guaranteed to succeed. 
end

define kdpversionint
       # set up the manual KDP packet
       set manual_pkt.input = 0
       set manual_pkt.len = sizeof(kdp_version_req_t)
       set $kgm_pkt = (kdp_version_req_t *)&manual_pkt.data
       set $kgm_pkt->hdr.request  = KDP_VERSION
       set $kgm_pkt->hdr.len      = sizeof(kdp_version_req_t)
       set $kgm_pkt->hdr.is_reply = 0
       set $kgm_pkt->hdr.seq      = 0
       set $kgm_pkt->hdr.key      = 0
       set manual_pkt.input       = 1
       # dummy to make sure manual packet is executed
       set $kgm_dummy = &_mh_execute_header
       set $kgm_pkt = (kdp_version_reply_t *)&manual_pkt.data
       set $kgm_kdp_version = $kgm_pkt->version
       set $kgm_kdp_feature = $kgm_pkt->feature
end

define kdp-version
       kdpversionint
       printf "KDP VERSION = %d, FEATURE = 0x%x\n", $kgm_kdp_version, $kgm_kdp_feature
end

document kdp-version
Syntax: kdp-version
|Get the KDP protocol version being used by the kernel.
end

define dumpinfoint
       # set up the manual KDP packet
       set manual_pkt.input        = 0

       set manual_pkt.len          = sizeof(kdp_dumpinfo_req_t)
       set $kgm_pkt                = (kdp_dumpinfo_req_t *)&manual_pkt.data
       set $kgm_pkt->hdr.request  = KDP_DUMPINFO
       set $kgm_pkt->hdr.len      = sizeof(kdp_dumpinfo_req_t)
       set $kgm_pkt->hdr.is_reply = 0
       set $kgm_pkt->hdr.seq      = 0
       set $kgm_pkt->hdr.key      = 0
       set $kgm_pkt->type         = $arg0 
       set $kgm_pkt->name         = ""
       set $kgm_pkt->destip       = ""
       set $kgm_pkt->routerip     = ""
       set $kgm_pkt->port         = 0

       if $argc > 1
       	  set $kgm_pkt->name      = "$arg1"
       end
       if $argc > 2
          set $kgm_pkt->destip    = "$arg2"
       end
       if $argc > 3
       	  set $kgm_pkt->routerip  = "$arg3"
       end
       if $argc > 4
       	  set $kgm_pkt->port      = $arg4
       end

       set manual_pkt.input       = 1
       # dummy to make sure manual packet is executed
       set $kgm_dummy = &_mh_execute_header
end

define sendcore
       if $argc > 1
       	  dumpinfoint KDP_DUMPINFO_CORE $arg1 $arg0
       else
       	  dumpinfoint KDP_DUMPINFO_CORE \0 $arg0
       end
end

document sendcore
Syntax: sendcore <IP address> [filename]
|Configure the kernel to transmit a kernel coredump to a server (kdumpd) 
|at the specified IP address. This is useful when the remote target has
|not been previously configured to transmit coredumps, and you wish to
|preserve kernel state for later examination. NOTE: You must issue a "continue"
|command after using this macro to trigger the kernel coredump. The kernel
|will resume waiting in the debugger after completion of the coredump. You
|may disable coredumps by executing the "disablecore" macro. You can 
|optionally specify the filename to be used for the generated core file.
end

define sendsyslog
       if $argc > 1
       	  dumpinfoint KDP_DUMPINFO_SYSTEMLOG $arg1 $arg0
       else
       	  dumpinfoint KDP_DUMPINFO_SYSTEMLOG \0 $arg0
       end
end

document sendsyslog
Syntax: sendsyslog <IP address> [filename]
|Configure the kernel to transmit a kernel system log to a server (kdumpd) 
|at the specified IP address. NOTE: You must issue a "continue"
|command after using this macro to trigger the kernel system log. The kernel
|will resume waiting in the debugger after completion. You can optionally
|specify the name to be used for the generated system log.
end

define sendpaniclog
       if panicstr 
	  if $argc > 1
	     dumpinfoint KDP_DUMPINFO_PANICLOG $arg1 $arg0
	  else
	     dumpinfoint KDP_DUMPINFO_PANICLOG \0 $arg0
	  end
       else
	  printf "No panic log available.\n"
       end
end

document sendpaniclog
Syntax: sendpaniclog <IP address> [filename]
|Configure the kernel to transmit a kernel paniclog to a server (kdumpd) 
|at the specified IP address. NOTE: You must issue a "continue"
|command after using this macro to trigger the kernel panic log. The kernel
|will resume waiting in the debugger after completion. You can optionally
|specify the name to be used for the generated panic log.
end

define getdumpinfo
       dumpinfoint KDP_DUMPINFO_GETINFO
       set $kgm_dumpinfo = (kdp_dumpinfo_reply_t *) manual_pkt.data
       if $kgm_dumpinfo->type & KDP_DUMPINFO_REBOOT
       	  printf "System will reboot after kernel info gets dumped.\n"
       else
       	  printf "System will not reboot after kernel info gets dumped.\n"
       end
       if $kgm_dumpinfo->type & KDP_DUMPINFO_NORESUME
       	  printf "System will allow a re-attach after a KDP disconnect.\n"
       else
       	  printf "System will resume after a KDP disconnect.\n"
       end
       set $kgm_dumpinfo_type = $kgm_dumpinfo->type & KDP_DUMPINFO_MASK
       if $kgm_dumpinfo_type == KDP_DUMPINFO_DISABLE
       	  printf "Kernel not setup for remote dumps.\n"
       else
          printf "Remote dump type: "
          if $kgm_dumpinfo_type == KDP_DUMPINFO_CORE
	     printf "Core file\n"
	  end
          if $kgm_dumpinfo_type == KDP_DUMPINFO_PANICLOG
	     printf "Panic log\n"
	  end
          if $kgm_dumpinfo_type == KDP_DUMPINFO_SYSTEMLOG
	     printf "System log\n"
	  end

	  printf "Name: "
	  if $kgm_dumpinfo->name[0] == '\0'
	     printf "(autogenerated)\n"
          else
	     printf "%s\n", $kgm_dumpinfo->name
          end		  

	  printf "Network Info: %s[%d] ", $kgm_dumpinfo->destip, $kgm_dumpinfo->port
	  if $kgm_dumpinfo->routerip[0] == '\0'
	     printf "\n"
	  else
	     printf "Router: %s\n", $kgm_dumpinfo->routerip
	  end
       end
end

document getdumpinfo
Syntax: getdumpinfo
|Retrieve the current remote dump settings. 
end

define setdumpinfo
       dumpinfoint KDP_DUMPINFO_SETINFO $arg0 $arg1 $arg2 $arg3
end

document setdumpinfo
Syntax: setdumpinfo <filename> <ip> <router> <port>
|Configure the current remote dump settings. Specify \0 if you
|want to use the defaults (filename) or previously configured
|settings (ip/router). Specify 0 for the port if you wish to 
|use the previously configured/default setting for that.
end

define disablecore
       dumpinfoint KDP_DUMPINFO_DISABLE
end

document disablecore
Syntax: disablecore
|Reconfigures the kernel so that it no longer transmits kernel coredumps. This
|complements the "sendcore" macro, but it may be used if the kernel has been
|configured to transmit coredumps through boot-args as well.
end

define switchtocorethread
	set $newact = (struct thread *) $arg0
	select 0
	if ($newact->kernel_stack == 0)
	   echo This thread does not have a stack.\n
	   echo continuation:
	   output/a (unsigned) $newact.continuation
	   echo \n
	else
	if ($kgm_mtype == $kgm_mtype_ppc)
	   loadcontext $newact->machine->pcb
	   flushstack
	   set $pc = $newact->machine->pcb.save_srr0
	else
	if (($kgm_mtype & $kgm_mtype_x86_mask) == $kgm_mtype_x86_any)
		set $kgm_cstatep = (struct x86_kernel_state *) \
					($newact->kernel_stack + kernel_stack_size \
					 - sizeof(struct x86_kernel_state))
		loadcontext $kgm_cstatep
		flushstack
	else
		echo switchtocorethread not supported on this architecture\n
	end
 	end
	showcontext_int
	end
end

document switchtocorethread
Syntax: switchtocorethread <address of activation>
| The corefile equivalent of "switchtoact". When debugging a kernel coredump
| file, this command can be used to examine the execution context and stack
| trace for a given thread activation. For example, to view the backtrace
| for a thread issue "switchtocorethread <address>", followed by "bt".
| Before resuming execution, issue a "resetcorectx" command, to
| return to the original execution context. Note that this command
| requires gdb support, as documented in Radar 3401283.
end

define loadcontext
	select 0
	if ($kgm_mtype == $kgm_mtype_ppc)
	set $kgm_contextp = (struct savearea *) $arg0
	set $pc = $kgm_contextp.save_srr0
	set $r1 = $kgm_contextp.save_r1
	set $lr = $kgm_contextp.save_lr

	set $r2 = $kgm_contextp.save_r2
	set $r3 = $kgm_contextp.save_r3
	set $r4 = $kgm_contextp.save_r4
	set $r5 = $kgm_contextp.save_r5
	set $r6 = $kgm_contextp.save_r6
	set $r7 = $kgm_contextp.save_r7
	set $r8 = $kgm_contextp.save_r8
	set $r9 = $kgm_contextp.save_r9
	set $r10 = $kgm_contextp.save_r10
	set $r11 = $kgm_contextp.save_r11
	set $r12 = $kgm_contextp.save_r12
	set $r13 = $kgm_contextp.save_r13
	set $r14 = $kgm_contextp.save_r14
	set $r15 = $kgm_contextp.save_r15
	set $r16 = $kgm_contextp.save_r16
	set $r17 = $kgm_contextp.save_r17
	set $r18 = $kgm_contextp.save_r18
	set $r19 = $kgm_contextp.save_r19
	set $r20 = $kgm_contextp.save_r20
	set $r21 = $kgm_contextp.save_r21
	set $r22 = $kgm_contextp.save_r22
	set $r23 = $kgm_contextp.save_r23
	set $r24 = $kgm_contextp.save_r24
	set $r25 = $kgm_contextp.save_r25
	set $r26 = $kgm_contextp.save_r26
	set $r27 = $kgm_contextp.save_r27
	set $r28 = $kgm_contextp.save_r28
	set $r29 = $kgm_contextp.save_r29
	set $r30 = $kgm_contextp.save_r30
	set $r31 = $kgm_contextp.save_r31

	set $cr = $kgm_contextp.save_cr
	set $ctr = $kgm_contextp.save_ctr
       else
	if ($kgm_mtype == $kgm_mtype_i386)
		set $kgm_contextp = (struct x86_kernel_state *) $arg0
		set $ebx = $kgm_contextp->k_ebx 
		set $ebp = $kgm_contextp->k_ebp 
		set $edi = $kgm_contextp->k_edi 
		set $esi = $kgm_contextp->k_esi 
		set $eip = $kgm_contextp->k_eip 
		set $pc =  $kgm_contextp->k_eip
	else
	if ($kgm_mtype == $kgm_mtype_x86_64)
		set $kgm_contextp = (struct x86_kernel_state *) $arg0
		set $rbx = $kgm_contextp->k_rbx 
		set $rbp = $kgm_contextp->k_rbp 
		set $r12 = $kgm_contextp->k_r12 
		set $r13 = $kgm_contextp->k_r13 
		set $r14 = $kgm_contextp->k_r14 
		set $r15 = $kgm_contextp->k_r15 
		set $rip = $kgm_contextp->k_rip
		set $pc = $kgm_contextp->k_rip
	else
		echo loadcontext not supported on this architecture\n
	end
	end
	end
end

define resetcorectx
	select 0
	if ($kgm_mtype == $kgm_mtype_ppc)
		set $kgm_corecontext = (struct savearea *) kdp.saved_state
		loadcontext $kgm_corecontext
	else
	if ($kgm_mtype == $kgm_mtype_i386)
		set $kdpstatep = (struct x86_saved_state32 *) kdp.saved_state
		set $ebx = $kdpstatep->ebx
		set $ebp = $kdpstatep->ebp
		set $edi = $kdpstatep->edi
		set $esi = $kdpstatep->esi
		set $eip = $kdpstatep->eip
		set $eax = $kdpstatep->eax
		set $ecx = $kdpstatep->ecx
		set $edx = $kdpstatep->edx
		flushregs
		flushstack
		set $pc = $kdpstatep->eip
		update
	else
		echo resetcorectx not supported on this architecture\n
	end
	end
	showcontext_int
end

document resetcorectx
Syntax: resetcorectx
| The corefile equivalent of "resetctx". Returns to the original
| execution context (that of the active thread at the time of the NMI or
| panic). This command should be issued if you wish to resume
| execution after using the "switchtocorethread" command.
end

#Helper function for "showallgdbstacks"

define showgdbthread
	printf "            0x%08x  ", $arg0
	set $kgm_thread = *(struct thread *)$arg0
	printf "0x%08x  ", $arg0
	printf "%3d  ", $kgm_thread.sched_pri
	set $kgm_state = $kgm_thread.state
	if $kgm_state & 0x80
	    printf "I" 
	end
	if $kgm_state & 0x40
	    printf "P" 
	end
	if $kgm_state & 0x20
	    printf "A" 
	end
	if $kgm_state & 0x10
	    printf "H" 
	end
	if $kgm_state & 0x08
	    printf "U" 
	end
	if $kgm_state & 0x04
	    printf "R" 
	end
	if $kgm_state & 0x02
	    printf "S" 
	end
   	if $kgm_state & 0x01
	    printf "W\t" 
	    printf "0x%08x  ", $kgm_thread.wait_queue
            output /a (unsigned) $kgm_thread.wait_event
		if ($kgm_thread.uthread != 0)
			set $kgm_uthread = (struct uthread *)$kgm_thread.uthread
			if ($kgm_uthread->uu_wmesg != 0)
				printf " \"%s\"", $kgm_uthread->uu_wmesg
			end
	    end
	end
	if $arg1 != 0
	    if ($kgm_thread.kernel_stack != 0)
		if ($kgm_thread.reserved_stack != 0)
			printf "\n\t\treserved_stack=0x%08x", $kgm_thread.reserved_stack
		end
		printf "\n\t\tkernel_stack=0x%08x", $kgm_thread.kernel_stack
		if ($kgm_mtype == $kgm_mtype_ppc)
			set $mysp = $kgm_thread.machine.pcb->save_r1
		end
		if ($kgm_mtype == $kgm_mtype_i386)
			set $kgm_statep = (struct x86_kernel_state *) \
				($kgm_thread->kernel_stack + kernel_stack_size \
				 - sizeof(struct x86_kernel_state))
			set $mysp = $kgm_statep->k_ebp
		end
		if ($kgm_mtype == $kgm_mtype_arm)
			if (((unsigned long)$r7 < ((unsigned long) ($kgm_thread->kernel_stack+kernel_stack_size))) \
                      && ((unsigned long)$r7 > (unsigned long) ($kgm_thread->kernel_stack)))
				set $mysp = $r7
			else
                        	set $kgm_statep = (struct arm_saved_state *)$kgm_thread.machine.kstackptr
                        	set $mysp = $kgm_statep->r[7]
			end
		end
		set $prevsp = 0
		printf "\n\t\tstacktop=0x%08x", $mysp
		if ($arg2 == 0)
			switchtoact $arg0
		else
			switchtocorethread $arg0
		end
	    	bt
	    else
		printf "\n\t\t\tcontinuation="
		output /a (unsigned) $kgm_thread.continuation
	    end
	    printf "\n"
	else
	    printf "\n"
	end
end	    

#Use of this macro is currently (8/04) blocked by the fact that gdb
#stops evaluating macros when encountering an error, such as a failure
#to read memory from a certain location. Until this issue (described in
#3758949) is addressed, evaluation of this macro may stop upon
#encountering such an error.

define showallgdbstacks
    set $kgm_head_taskp = &tasks
    set $kgm_taskp = (struct task *)($kgm_head_taskp->next)
    while $kgm_taskp != $kgm_head_taskp
        showtaskheader
	showtaskint $kgm_taskp
	set $kgm_head_actp = &($kgm_taskp->threads)
        set $kgm_actp = (struct thread *)($kgm_taskp->threads.next)
	while $kgm_actp != $kgm_head_actp
	    showactheader
	    showgdbthread $kgm_actp 1 0
  	    set $kgm_actp = (struct thread *)($kgm_actp->task_threads.next)
        end
	printf "\n"
    	set $kgm_taskp = (struct task *)($kgm_taskp->tasks.next)
    end
    resetctx
end

document showallgdbstacks
Syntax: showallgdbstacks
| An alternative to "showallstacks". Iterates through the task list and
| displays a gdb generated backtrace for each kernel thread. It is
| advantageous in that it is much faster than "showallstacks", and
| decodes function call arguments and displays source level traces, but
| it has the drawback that it doesn't determine if frames belong to
| functions from kernel extensions, as with "showallstacks".
| This command may terminate prematurely because of a gdb bug
| (Radar 3758949), which stops macro evaluation on memory read
| errors.
end

define showallgdbcorestacks
	select 0
	set $kgm_head_taskp = &tasks
	set $kgm_taskp = (struct task *)($kgm_head_taskp->next)
        while $kgm_taskp != $kgm_head_taskp
		showtaskheader
		showtaskint $kgm_taskp
		set $kgm_head_actp = &($kgm_taskp->threads)
		set $kgm_actp = (struct thread *)($kgm_taskp->threads.next)
		while $kgm_actp != $kgm_head_actp
		showactheader
		showgdbthread $kgm_actp 1 1
		set $kgm_actp = (struct thread *)($kgm_actp->task_threads.next)
		end
		printf "\n"
		set $kgm_taskp = (struct task *)($kgm_taskp->tasks.next)
	end
	resetcorectx
end


document showallgdbcorestacks
Syntax: showallgdbcorestacks
|Corefile version of "showallgdbstacks"
end


define switchtouserthread
		select 0
  		if ($kgm_mtype == $kgm_mtype_ppc)	
		   if ($kdp_act_counter == 0)
		      set $kdpstate = (struct savearea *) kdp.saved_state
		   end
		   set $kdp_act_counter = $kdp_act_counter + 1
		   set $newact = (struct thread *) $arg0
		   _kgm_flush_loop
		   set $checkpc = $newact->machine->upcb.save_srr0
		   if ($checkpc == 0)
		      echo This activation does not appear to have
		      echo \20 a valid user context.\n
		   else	      
		     set (struct savearea *) kdp.saved_state=$newact->machine->upcb
		     set $pc = $checkpc
#flush and update seem to be executed lazily by gdb on Tiger, hence the
#repeated invocations - see 3743135
	   	    _kgm_flush_loop
# This works because the new pmap is used only for reads
		     set kdp_pmap = $newact->task->map->pmap
		     _kgm_flush_loop
		     _kgm_update_loop
		   end
		else
		   echo switchtouserthread not implemented for this architecture.\n
	end
end

document switchtouserthread
Syntax: switchtouserthread <address of thread>
| Analogous to switchtoact, but switches to the user context of a
| specified thread address. Similar to the "showuserstack"
| command, but this command does not return gdb to the kernel context
| immediately. This is to assist with the following (rather risky)
| manoeuvre - upon switching to the user context and virtual address
| space, the user may choose to call remove-symbol-file on the
| mach_kernel symbol file, and then add-symbol-file on the user space
| binary's symfile. gdb can then generate symbolic backtraces 
| for the user space thread. To return to the
| kernel context and virtual address space, the process must be
| reversed, i.e. call remove-symbol-file on the user space symbols, and
| then add-symbol-file on the appropriate mach_kernel, and issue the
| "resetstacks" command. Note that gdb may not react kindly to all these
| symbol file switches. The same restrictions that apply to "showuserstack"
| apply here - pages that have been paged out cannot be read while in the
| debugger context, so backtraces may terminate early.
| If the virtual addresses in the stack trace do not conflict with those
| of symbols in the kernel's address space, it may be sufficient to
| just do an add-symbol-file on the user space binary's symbol file.
| Note that while this command works on Panther's gdb, an issue
| with Tiger gdb (3743135) appears to hamper the evaluation of this
| macro in some cases.
end

define showmetaclass
    set $kgm_metaclassp = (OSMetaClass *)$arg0
    printf "%-5d", $kgm_metaclassp->instanceCount
    printf "x %5d bytes", $kgm_metaclassp->classSize
    printf " %s\n", $kgm_metaclassp->className->string
end

define showstring
    printf "\"%s\"", ((OSString *)$arg0)->string
end

define shownumber
    printf "%lld", ((OSNumber *)$arg0)->value
end

define showboolean
    if ($arg0 == gOSBooleanFalse)
	printf "No"
    else
	printf "Yes"
    end
end

define showdatabytes
    set $kgm_data = (OSData *)$arg0

    printf "<"
    set $kgm_datap = (const unsigned char *) $kgm_data->data
	set $kgm_idx = 0
	while ( $kgm_idx < $kgm_data->length )
		printf "%02X", *$kgm_datap
		set $kgm_datap = $kgm_datap + 1
		set $kgm_idx = $kgm_idx + 1
	end
	printf ">\n"
end

define showdata
    set $kgm_data = (OSData *)$arg0

    printf "<"
    set $kgm_datap = (const unsigned char *) $kgm_data->data

    set $kgm_printstr = 0
    if (0 == (3 & (unsigned int)$kgm_datap) && ($kgm_data->length >= 3))
	set $kgm_bytes = *(unsigned int *) $kgm_datap
	if (0xffff0000 & $kgm_bytes)
	    set $kgm_idx = 0
	    set $kgm_printstr = 1
	    while ($kgm_idx++ < 4)
		set $kgm_bytes = $kgm_bytes >> 8
		set $kgm_char = 0xff & $kgm_bytes
		if ($kgm_char && (($kgm_char < 0x20) || ($kgm_char > 0x7e)))
		    set $kgm_printstr = 0
		end
	    end
	end
    end
    
    set $kgm_idx = 0
    if ($kgm_printstr)
	set $kgm_quoted = 0
	while ($kgm_idx < $kgm_data->length)
	    set $kgm_char = $kgm_datap[$kgm_idx++]
	    if ($kgm_char)
		if (0 == $kgm_quoted)
		    set $kgm_quoted = 1
		    if ($kgm_idx > 1)
			printf ",\""
		    else
			printf "\""
		    end
		end
		printf "%c", $kgm_char
	    else
		if ($kgm_quoted)
		    set $kgm_quoted = 0
		    printf "\""
		end
	    end
	end
	if ($kgm_quoted)
	    printf "\""
	end
    else
	if (0 == (3 & (unsigned int)$kgm_datap))
	    while (($kgm_idx + 3) <= $kgm_data->length)
		printf "%08x", *(unsigned int *) &$kgm_datap[$kgm_idx]
		set $kgm_idx = $kgm_idx + 4
	    end
	end
	while ($kgm_idx < $kgm_data->length)
	    printf "%02x", $kgm_datap[$kgm_idx++]
	end
    end
    printf ">"
end

define showdictionaryint
    set $kgm$arg0_dict = (OSDictionary *)$arg1

    printf "{"
    set $kgm$arg0_idx = 0
    while ($kgm$arg0_idx < $kgm$arg0_dict->count)
	set $kgm_obj = $kgm$arg0_dict->dictionary[$kgm$arg0_idx].key
	showobjectint _$arg0 $kgm_obj
	printf "="
	set $kgm_obj = $kgm$arg0_dict->dictionary[$kgm$arg0_idx++].value
	showobjectint _$arg0 $kgm_obj
	if ($kgm$arg0_idx < $kgm$arg0_dict->count)
	    printf ","
	end
    end
    printf "}"
end

define indent
    set $kgm_idx = 0
    while ($kgm_idx < $arg0)
	if ($arg1 & (1 << $kgm_idx++))
	    printf "| "
	else
	    printf "  "
	end
    end
end

define showregdictionary
    indent $kgm_reg_depth+2 $arg1
    printf "{\n"

    set $kgm_reg_idx = 0
    while ($kgm_reg_idx < $arg0->count)
	indent $kgm_reg_depth+2 $arg1
	printf "  "
	set $kgm_obj = $arg0->dictionary[$kgm_reg_idx].key
	showobjectint _ $kgm_obj
	printf " = "

	set $kgm_obj = $arg0->dictionary[$kgm_reg_idx++].value
	showobjectint _ $kgm_obj
	printf "\n"
    end
    indent $kgm_reg_depth+2 $arg1
    printf "}\n"
end


define showorderedsetarrayint
    set $kgm$arg0_array = (_Element *)$arg1
    set $kgm$arg0_count = $arg2

    set $kgm$arg0_idx = 0
    while ($kgm$arg0_idx < $kgm$arg0_count)
        set $kgm_obj = $kgm$arg0_array[$kgm$arg0_idx++]
        showobjectint _$arg0 $kgm_obj
        if ($kgm$arg0_idx < $kgm$arg0_count)
	    printf ","
        end
    end
end

define showorderedsetint
    set $kgm_array = ((OSOrderedSet *)$arg1)->array
    set $count = ((OSOrderedSet *)$arg1)->count
    printf "["
    showorderedsetarrayint $arg0 $kgm_array $count
    printf "]"
end

define showarraysetint
    set $kgm$arg0_array = (OSArray *)$arg1

    set $kgm$arg0_idx = 0
    while ($kgm$arg0_idx < $kgm$arg0_array->count)
	set $kgm_obj = $kgm$arg0_array->array[$kgm$arg0_idx++]
	showobjectint _$arg0 $kgm_obj
	if ($kgm$arg0_idx < $kgm$arg0_array->count)
	    printf ","
	end
    end
end

define showarrayint
    printf "("
    showarraysetint $arg0 $arg1
    printf ")"
end

define showsetint
    set $kgm_array = ((OSSet *)$arg1)->members
    printf "["
    showarraysetint $arg0 $kgm_array
    printf "]"
end


define showobjectint
    set $kgm_obj = (OSObject *) $arg1
    set $kgm_vt = *((void **) $arg1)

    if ($kgm_lp64 || $kgm_mtype == $kgm_mtype_arm)
        set $kgm_vt = $kgm_vt - 2 * sizeof(void *)
    end

    if ($kgm_show_object_addrs)
        printf "`object "
        showptr $arg1
        printf ", vt "
        output /a (unsigned long) $kgm_vt
        if ($kgm_show_object_retain)
            printf ", retain count %d, container retain %d", (0xffff & $kgm_obj->retainCount), $kgm_obj->retainCount >> 16
        end
        printf "` "
    end

    # No multiple-inheritance
    set $kgm_shown = 0
    if ($kgm_vt == &_ZTV8OSString)
        showstring $arg1
        set $kgm_shown = 1
    end
	if ($kgm_vt == &_ZTV8OSSymbol)
	    showstring $arg1
        set $kgm_shown = 1
    end
    if ($kgm_vt == &_ZTV8OSNumber)
		shownumber $arg1
        set $kgm_shown = 1
    end
    if ($kgm_vt == &_ZTV6OSData)
        if $kgm_show_data_alwaysbytes == 1
            showdatabytes $arg1
        else
            showdata $arg1
        end
        set $kgm_shown = 1
    end
    if ($kgm_vt == &_ZTV9OSBoolean)
        showboolean $arg1
        set $kgm_shown = 1
    end
    if ($kgm_vt == &_ZTV12OSDictionary)
        showdictionaryint _$arg0 $arg1
        set $kgm_shown = 1
    end
    if ($kgm_vt == &_ZTV7OSArray)
        showarrayint _$arg0 $arg1
        set $kgm_shown = 1
    end
    if ($kgm_vt == &_ZTV5OSSet)
        showsetint _$arg0 $arg1
        set $kgm_shown = 1
    end
    if ($kgm_vt == &_ZTV12OSOrderedSet)
        showorderedsetint _$arg0 $arg1
        set $kgm_shown = 1
    end
    
    if ($kgm_shown != 1)
        if ($kgm_show_object_addrs == 0)
            printf "`object "
            showptr $arg1
            printf ", vt "
            output /a (unsigned long) $kgm_vt
            printf "`"
        end
    end
end

define showobject
    set $kgm_save = $kgm_show_object_addrs
    set $kgm_show_object_addrs = 1
    set $kgm_show_object_retain = 1
    showobjectint _ $arg0
    set $kgm_show_object_addrs = $kgm_save
    set $kgm_show_object_retain = 0
    printf "\n"
end
document showobject
Syntax: (gdb) showobject <object address>
| Show info about an OSObject - its vtable ptr and retain count.
| If the object is a simple container class, more info will be shown.
end

define dictget 
    set $kgm_dictp = (OSDictionary *)$arg0
    set $kgm_keyp = (const OSSymbol *)$arg1
    set $kgm_idx = 0
    set $kgm_result = 0
    while (($kgm_idx < $kgm_dictp->count) && ($kgm_result == 0))
	if ($kgm_keyp == $kgm_dictp->dictionary[$kgm_idx].key)
	    set $kgm_result = $kgm_dictp->dictionary[$kgm_idx].value
	end
	set $kgm_idx = $kgm_idx + 1
    end
end


define _registryentryrecurseinit
    set $kgm_re         = (IOService *)$arg1
    set $kgm$arg0_stack = (unsigned long long) $arg2

    if ($arg3)
	set $kgm$arg0_stack = $kgm$arg0_stack | (1ULL << $kgm_reg_depth)
    else
	set $kgm$arg0_stack = $kgm$arg0_stack & ~(1ULL << $kgm_reg_depth)
    end

    dictget $kgm_re->fRegistryTable $kgm_childkey
    set $kgm$arg0_child_array = (OSArray *) $kgm_result

    if ($kgm$arg0_child_array)
	set $kgm$arg0_child_count = $kgm$arg0_child_array->count
    else
	set $kgm$arg0_child_count = 0
    end

    if ($kgm$arg0_child_count)
	set $kgm$arg0_stack = $kgm$arg0_stack | (2ULL << $kgm_reg_depth)
    else
	set $kgm$arg0_stack = $kgm$arg0_stack & ~(2ULL << $kgm_reg_depth)
    end
end

define findregistryentryrecurse
    set $kgm_registry_entry = 0
    _registryentryrecurseinit $arg0 $arg1 $arg2 $arg3

    dictget $kgm_re->fRegistryTable $kgm_namekey
    if ($kgm_result == 0)
	dictget $kgm_re->fRegistryTable gIONameKey
    end
    if ($kgm_result == 0)
	dictget $kgm_re->fPropertyTable gIOClassKey
    end

    if ($kgm_result != 0)
       set $str = ((OSString *) $kgm_result)->string
       strcmp_nomalloc $str $kgm_reg_find_str0 $kgm_reg_find_str1 $kgm_reg_find_str2 $kgm_reg_find_str3 $kgm_reg_find_str4 $kgm_reg_find_str5 $kgm_reg_find_str6 $kgm_reg_find_str7 $kgm_reg_find_str8 
       if $kgm_findregistry_verbose
          echo .
       end

       if $kgm_strcmp_result == 0
	  if $kgm_findregistry_verbose
	     printf "\n%s:\n | ", ((OSString *) $kgm_result)->string
	     showobject $kgm_re
	     printf " | "
	     print $kgm_re
	  end

	  # don't populate $kgm_registry_entry if we want to show everything
	  if !$kgm_findregistry_continue
       	     set $kgm_registry_entry = $kgm_re
	  end
       end
    end

    # recurse
    if (!$kgm_registry_entry && ($kgm$arg0_child_count != 0))
        set $kgm_reg_depth = $kgm_reg_depth + 1
        set $kgm$arg0_child_idx = 0

        while ($kgm$arg0_child_idx < $kgm$arg0_child_count)
            set $kgm_re = $kgm$arg0_child_array->array[$kgm$arg0_child_idx++]
            set $kgm_more_sib = ($kgm$arg0_child_idx < $kgm$arg0_child_count)
	    if $kgm_reg_depth >= $kgm_reg_depth_max + 1
	       loop_break
	    end
            findregistryentryrecurse _$arg0 $kgm_re $kgm$arg0_stack $kgm_more_sib 
	    if $kgm_registry_entry
	       loop_break
	    end
        end
        set $kgm_reg_depth = $kgm_reg_depth - 1
    end
end

define findregdictvalue
    set $kgm_registry_value = 0
    set $kgm_reg_idx = 0
    while ($kgm_reg_idx < $arg0->count)
        set $kgm_obj = $arg0->dictionary + $kgm_reg_idx
	set $str = ((OSString *)$kgm_obj->key)->string
       	strcmp_nomalloc $str $kgm_reg_find_str0 $kgm_reg_find_str1 $kgm_reg_find_str2 $kgm_reg_find_str3 $kgm_reg_find_str4 $kgm_reg_find_str5 $kgm_reg_find_str6 $kgm_reg_find_str7 $kgm_reg_find_str8 

	if $kgm_strcmp_result == 0
	   set $kgm_registry_value = $kgm_obj->value
	   if $kgm_findregistry_verbose
	      showobject $kgm_registry_value
	      print $kgm_registry_value
	   end
	   loop_break
	end
	set $kgm_reg_idx = $kgm_reg_idx + 1
    end
end

define setfindregistrystr
    set $kgm_reg_find_str0 = 0
    set $kgm_reg_find_str1 = 0
    set $kgm_reg_find_str2 = 0
    set $kgm_reg_find_str3 = 0
    set $kgm_reg_find_str4 = 0
    set $kgm_reg_find_str5 = 0
    set $kgm_reg_find_str6 = 0
    set $kgm_reg_find_str7 = 0
    set $kgm_reg_find_str8 = 0

    if $argc > 0
       set $kgm_reg_find_str0 = $arg0
    end
    if $argc > 1
       set $kgm_reg_find_str1 = $arg1
    end
    if $argc > 2
       set $kgm_reg_find_str2 = $arg2
    end
    if $argc > 3
       set $kgm_reg_find_str3 = $arg3
    end
    if $argc > 4
       set $kgm_reg_find_str4 = $arg4
    end
    if $argc > 5
       set $kgm_reg_find_str5 = $arg5
    end
    if $argc > 6
       set $kgm_reg_find_str6 = $arg6
    end
    if $argc > 7
       set $kgm_reg_find_str7 = $arg7
    end
    if $argc > 8
       set $kgm_reg_find_str8 = $arg8
    end
end

document setfindregistrystr
Syntax: (gdb) setfindregistrystr [a] [b] [c] [d] [e] [f] [g] [h] [i]
| Store an encoded string into up to 9 arguments for use by 
| findregistryprop or findregistryentry. The arguments are created
| through calls to strcmp_arg_pack64
end

define _findregistryprop
    set $reg       = (IOService *) $arg0
    set $kgm_props = $reg->fPropertyTable
    set $kgm_findregistry_verbose = 0

    findregdictvalue $kgm_props 
end

define findregistryprop
    set $reg       = (IOService *) $arg0
    set $kgm_props = $reg->fPropertyTable

    set $kgm_findregistry_verbose = 1
    findregdictvalue $kgm_props 
end

document findregistryprop
Syntax: (gdb) findregistryprop <entry>
| Given a registry entry, print out the contents for the property that matches
| the encoded string specified via setfindregistrystr.
|
| For example, the following will print out the "intel-pic" property stored in
| the AppleACPIPlatformExpert registry entry $pe_entry:
|	     strcmp_arg_pack64 'i' 'n' 't' 'e' 'l' '-' 'p' 'i' 
|	     set $intel_pi = $kgm_strcmp_arg
|	     strcmp_arg_pack64 'c' 0 0 0 0 0 0 0
|	     set $c = $kgm_strcmp_arg
|	     setfindregistrystr $intel_pi $c
|	     findregistryprop $pe_entry
end

define findregistryentryint
    if !$kgm_reg_plane
       set $kgm_reg_plane = (IORegistryPlane *) gIOServicePlane
    end

    if !$kgm_reg_plane
       printf "Please load kgmacros after KDP attaching to the target.\n"
    else
       set $kgm_namekey   = (OSSymbol *) $kgm_reg_plane->nameKey
       set $kgm_childkey  = (OSSymbol *) $kgm_reg_plane->keys[1]
       if $kgm_findregistry_verbose
          printf "Searching"
       end
       findregistryentryrecurse _ $arg0 0 0
    end
end

define _findregistryentry
    set $kgm_findregistry_verbose  = 0
    set $kgm_findregistry_continue = 0
    set $kgm_reg_depth             = 0

    findregistryentryint gRegistryRoot
end

define findregistryentry
    set $kgm_findregistry_verbose  = 1
    set $kgm_findregistry_continue = 0
    set $kgm_reg_depth             = 0

    findregistryentryint gRegistryRoot
end

define findregistryentries
    set $kgm_findregistry_verbose  = 1
    set $kgm_findregistry_continue = 1
    set $kgm_reg_depth             = 0

    findregistryentryint gRegistryRoot
end

document findregistryentry
Syntax: (gdb) findregistryentry
| Search for a registry entry that matches the encoded string specified through
| setfindregistrystr. You can alter the search depth through use of 
| $kgm_reg_depth_max.
|
| For example, the following will pull out the AppleACPIPlatformExpert registry
| entry:
|    	  strcmp_arg_pack64 'A' 'p' 'p' 'l' 'e' 'A' 'C' 'P'
|      	  set $AppleACP = $kgm_strcmp_arg
|      	  strcmp_arg_pack64 'I' 'P' 'l' 'a' 't' 'f' 'o' 'r'
|      	  set $IPlatfor = $kgm_strcmp_arg
|      	  strcmp_arg_pack64 'm' 'E' 'x' 'p' 'e' 'r' 't' 0
|      	  set $mExpert = $kgm_strcmp_arg
|	  setfindregistrystr $AppleACP $IPlatfor $mExpert
| 	  findregistryentry
end

document findregistryentries
Syntax: (gdb) findregistryentries
| Search for all registry entries that match the encoded string specified through
| setfindregistrystr. You can alter the search depth through use of 
| $kgm_reg_depth_max. See findregistryentry for an example of how to encode a string.
end


define showregistryentryrecurse
    _registryentryrecurseinit $arg0 $arg1 $arg2 $arg3

    indent $kgm_reg_depth $kgm$arg0_stack
    printf "+-o "

    dictget $kgm_re->fRegistryTable $kgm_namekey
    if ($kgm_result == 0)
	dictget $kgm_re->fRegistryTable gIONameKey
    end
    if ($kgm_result == 0)
	dictget $kgm_re->fPropertyTable gIOClassKey
    end

    if ($kgm_result != 0)
	printf "%s", ((OSString *)$kgm_result)->string
    else
 	if (((IOService*)$kgm_re)->pwrMgt &&  ((IOService*)$kgm_re)->pwrMgt->Name)
 	    printf "%s", ((IOService*)$kgm_re)->pwrMgt->Name
	else
#	    printf ", guessclass "
#	    guessclass $kgm_re
	    printf "??"
	end
    end


    printf "  <object "
    showptr $kgm_re
    printf ", id 0x%llx, ", $kgm_re->IORegistryEntry::reserved->fRegistryEntryID
    printf "vtable "
    set $kgm_vt = (unsigned long) *(void**) $kgm_re
    if ($kgm_lp64 || $kgm_mtype == $kgm_mtype_arm)
        set $kgm_vt = $kgm_vt - 2 * sizeof(void *)
    end
    output /a $kgm_vt

    if ($kgm_vt != &_ZTV15IORegistryEntry)
        printf ", "
        set $kgm_state =  $kgm_re->__state[0]
        # kIOServiceRegisteredState
        if (0 == ($kgm_state & 2))
            printf "!"
        end
        printf "registered, "
        # kIOServiceMatchedState
        if (0 == ($kgm_state & 4))
            printf "!"
        end
        printf "matched, "
        # kIOServiceInactiveState
        if ($kgm_state & 1)
            printf "in"
        end
        printf "active, busy %d, retain count %d", (0xff & $kgm_re->__state[1]), (0xffff & $kgm_re->retainCount)
    end
    printf ">\n"

    if ($kgm_show_props)
        set $kgm_props = $kgm_re->fPropertyTable
        showregdictionary $kgm_props $kgm$arg0_stack
    end

    # recurse
    if ($kgm$arg0_child_count != 0)

        set $kgm_reg_depth = $kgm_reg_depth + 1
        set $kgm$arg0_child_idx = 0

        while ($kgm$arg0_child_idx < $kgm$arg0_child_count)
            set $kgm_re = $kgm$arg0_child_array->array[$kgm$arg0_child_idx++]
            set $kgm_more_sib = ($kgm$arg0_child_idx < $kgm$arg0_child_count)
	    if $kgm_reg_depth >= $kgm_reg_depth_max + 1
	       loop_break
	    end
   	    showregistryentryrecurse _$arg0 $kgm_re $kgm$arg0_stack $kgm_more_sib
        end

        set $kgm_reg_depth = $kgm_reg_depth - 1
    end
end

define showregistryentryint
    if !$kgm_reg_plane
       set $kgm_reg_plane = (IORegistryPlane *) gIOServicePlane
    end

    if !$kgm_reg_plane
       printf "Please load kgmacros after KDP attaching to the target.\n"
    else        
       set $kgm_namekey   = (OSSymbol *) $kgm_reg_plane->nameKey
       set $kgm_childkey  = (OSSymbol *) $kgm_reg_plane->keys[1]
       showregistryentryrecurse _ $arg0 0 0
    end
end

define showregistry
    set $kgm_reg_depth  = 0
    set $kgm_show_props = 0
    showregistryentryint gRegistryRoot
end
document showregistry
Syntax: (gdb) showregistry 
| Show info about all registry entries in the current plane. You can specify the maximum
| display depth with $kgm_reg_depth_max.
end

define showregistryprops
    set $kgm_reg_depth  = 0
    set $kgm_show_props = 1
    showregistryentryint gRegistryRoot
end
document showregistryprops
Syntax: (gdb) showregistryprops 
| Show info about all registry entries in the current plane, and their properties.
| set $kgm_show_object_addrs = 1 and/or set $kgm_show_object_retain = 1 will display
| more verbose information
end

define showregistryentry
    set $kgm_reg_depth  = 0
    set $kgm_show_props = 1
    showregistryentryint $arg0
end
document showregistryentry
Syntax: (gdb) showregistryentry <object address>
| Show info about a registry entry; its properties and descendants in the current plane.
end

define setregistryplane
    if ($arg0 != 0)
        set $kgm_reg_plane = (IORegistryPlane *) $arg0
    else
        showobjectint _ gIORegistryPlanes
        printf "\n"
    end
end
document setregistryplane
Syntax: (gdb) setregistryplane <plane object address>
| Set the plane to be used for the iokit registry macros. An argument of zero will 
| display known planes.
end

define guessclass
    set $kgm_classidx = 0
    set $kgm_lookvt = *((void **) $arg0)
    set $kgm_bestvt = (void *) 0
    set $kgm_bestidx = 0
    
    while $kgm_classidx < sAllClassesDict->count
	set $kgm_meta = (OSMetaClass *) sAllClassesDict->dictionary[$kgm_classidx].value

	set $kgm_vt = *((void **) $kgm_meta)

	if (($kgm_vt > $kgm_bestvt) && ($kgm_vt < $kgm_lookvt))
	    set $kgm_bestvt  = $kgm_vt
	    set $kgm_bestidx = $kgm_classidx
	end
	set $kgm_classidx = $kgm_classidx + 1
    end
    printf "%s", sAllClassesDict->dictionary[$kgm_bestidx].key->string
end

define showallclasses
    set $kgm_classidx = 0
    while $kgm_classidx < sAllClassesDict->count
	set $kgm_meta = (OSMetaClass *) sAllClassesDict->dictionary[$kgm_classidx++].value
	showmetaclass $kgm_meta
    end
end

document showallclasses
Syntax: (gdb) showallclasses
| Show the instance counts and ivar size of all OSObject subclasses. See ioclasscount man page for details.
end

define showioalloc
    printf " Instance allocation = 0x%08lx = %4ld K\n", (int) debug_ivars_size, ((int) debug_ivars_size) / 1024
    printf "Container allocation = 0x%08lx = %4ld K\n", (int) debug_container_malloc_size, ((int) debug_container_malloc_size) / 1024
    printf " IOMalloc allocation = 0x%08lx = %4ld K\n", (int) debug_iomalloc_size, ((int) debug_iomalloc_size) / 1024
    printf " Pageable allocation = 0x%08lx = %4ld K\n", (vm_size_t) debug_iomallocpageable_size, ((vm_size_t) debug_iomallocpageable_size) / 1024
end

document showioalloc
Syntax: (gdb) showioalloc
| Show some accounting of memory allocated by IOKit allocators. See ioalloccount man page for details.
end

define showosobjecttracking
    set $kgm_next = (OSObjectTracking *) gOSObjectTrackList.next
    while $kgm_next != &gOSObjectTrackList
	set $obj = (OSObject *) ($kgm_next+1)
	showobject $obj
	set $kgm_idx = 0
	while $kgm_idx < (sizeof($kgm_next->bt) / sizeof($kgm_next->bt[0]))
	    if ((unsigned long) $kgm_next->bt[$kgm_idx] > (unsigned long) &last_kernel_symbol)
		showkmodaddr $kgm_next->bt[$kgm_idx]
		printf "\n"
	    else
		if ((unsigned long) $kgm_next->bt[$kgm_idx] > 0)
		    output /a $kgm_next->bt[$kgm_idx]
		    printf "\n"
		end
	    end
	    set $kgm_idx = $kgm_idx + 1
	end
	printf "\n"
	set $kgm_next = (OSObjectTracking *) $kgm_next->link.next
    end
end

document showosobjecttracking
Syntax: (gdb) showosobjecttracking
| Show the list of tracked OSObject allocations with backtraces.
| Boot with the kOSTraceObjectAlloc (0x00400000) io debug flag set. 
| Set gOSObjectTrackThread to 1 or a thread_t to capture new OSObjects allocated by a thread or all threads.
end

# $kgm_readphys_force_kdp and $kgm_readphys_force_physmap
# can respectively cause physical memory access to use
# a KDP manual packet or the physical memory mapping
# even if the default behavior would be otherwise.
define readphysint
    set $kgm_readphysint_result = 0xBAD10AD

    if ($kgm_readphys_force_kdp != 0)
        set $kgm_readphys_use_kdp = 1
    else
        if ($kgm_readphys_force_physmap)
            set $kgm_readphys_use_kdp = 0
        else
            set $kgm_readphys_use_kdp = ( kdp->is_conn > 0 )
        end
    end

    if ($kgm_readphys_use_kdp)

        # set up the manual KDP packet
        set manual_pkt.input = 0
        set manual_pkt.len = sizeof(kdp_readphysmem64_req_t)
        set $kgm_pkt = (kdp_readphysmem64_req_t *)&manual_pkt.data
        set $kgm_pkt->hdr.request  = KDP_READPHYSMEM64
        set $kgm_pkt->hdr.len      = sizeof(kdp_readphysmem64_req_t)
        set $kgm_pkt->hdr.is_reply = 0
        set $kgm_pkt->hdr.seq      = 0
        set $kgm_pkt->hdr.key      = 0
        set $kgm_pkt->address      = (uint64_t)$arg0
        set $kgm_pkt->nbytes       = $arg1 >> 3
        set $kgm_pkt->lcpu         = $arg2
        set manual_pkt.input       = 1
        # dummy to make sure manual packet is executed
        set $kgm_dummy = &_mh_execute_header
        set $kgm_pkt = (kdp_readphysmem64_reply_t *)&manual_pkt.data
        if ($kgm_pkt->error == 0)
            if $arg1 == 8
                set $kgm_readphysint_result = *((uint8_t *)$kgm_pkt->data)
            end
            if $arg1 == 16
                set $kgm_readphysint_result = *((uint16_t *)$kgm_pkt->data)
            end
            if $arg1 == 32
                set $kgm_readphysint_result = *((uint32_t *)$kgm_pkt->data)
            end
            if $arg1 == 64
                set $kgm_readphysint_result = *((uint64_t *)$kgm_pkt->data)
            end
        end

    else
        # No KDP. Attempt to use physical memory mapping

        if ($kgm_mtype == $kgm_mtype_x86_64)
            set $kgm_readphys_paddr_in_kva = (unsigned long long)$arg0 + physmap_base
        else
            if ($kgm_mtype == $kgm_mtype_arm)
                set $kgm_readphys_paddr_in_kva = (unsigned long long)$arg0 - gPhysBase + gVirtBase
            else
                printf "readphys not available for current architecture.\n"
                set $kgm_readphys_paddr_in_kva = 0
            end
        end
        if $kgm_readphys_paddr_in_kva
            if $arg1 == 8
                set $kgm_readphysint_result = *((uint8_t *)$kgm_readphys_paddr_in_kva)
            end
            if $arg1 == 16
                set $kgm_readphysint_result = *((uint16_t *)$kgm_readphys_paddr_in_kva)
            end
            if $arg1 == 32
                set $kgm_readphysint_result = *((uint32_t *)$kgm_readphys_paddr_in_kva)
            end
            if $arg1 == 64
                set $kgm_readphysint_result = *((uint64_t *)$kgm_readphys_paddr_in_kva)
            end
        end
    end
end

define readphys8
       readphysint $arg0 8 $kgm_lcpu_self
       output /a $arg0
       printf ":\t0x%02hhx\n", $kgm_readphysint_result
       set $kgm_readphys_result = (uint64_t)$kgm_readphysint_result
end

define readphys16
       readphysint $arg0 16 $kgm_lcpu_self
       output /a $arg0
       printf ":\t0x%04hx\n", $kgm_readphysint_result
       set $kgm_readphys_result = (uint64_t)$kgm_readphysint_result
end

define readphys32
       readphysint $arg0 32 $kgm_lcpu_self
       output /a $arg0
       printf ":\t0x%08x\n", $kgm_readphysint_result
       set $kgm_readphys_result = (uint64_t)$kgm_readphysint_result
end

define readphys64
       readphysint $arg0 64 $kgm_lcpu_self
       output /a $arg0
       printf ":\t0x%016llx\n", $kgm_readphysint_result
       set $kgm_readphys_result = (uint64_t)$kgm_readphysint_result
end

define readphys
       readphys32 $arg0
end

document readphys8
| See readphys64
end

document readphys16
| See readphys64
end

document readphys32
| See readphys64
end

document readphys64
| The argument is interpreted as a physical address, and the 64-bit word
| addressed is displayed. Saves 64-bit result in $kgm_readphys_result.
end

define writephysint
       # set up the manual KDP packet
       set manual_pkt.input = 0
       set manual_pkt.len = sizeof(kdp_writephysmem64_req_t)
       set $kgm_pkt = (kdp_writephysmem64_req_t *)&manual_pkt.data
       set $kgm_pkt->hdr.request  = KDP_WRITEPHYSMEM64
       set $kgm_pkt->hdr.len      = sizeof(kdp_writephysmem64_req_t)
       set $kgm_pkt->hdr.is_reply = 0
       set $kgm_pkt->hdr.seq      = 0
       set $kgm_pkt->hdr.key      = 0
       set $kgm_pkt->address      = (uint64_t)$arg0
       set $kgm_pkt->nbytes       = $arg1 >> 3
       set $kgm_pkt->lcpu         = $arg3
       if $arg1 == 8
       	  set *(uint8_t *)$kgm_pkt->data = (uint8_t)$arg2
       end
       if $arg1 == 16
       	  set *(uint16_t *)$kgm_pkt->data = (uint16_t)$arg2
       end
       if $arg1 == 32
       	  set *(uint32_t *)$kgm_pkt->data = (uint32_t)$arg2
       end
       if $arg1 == 64
       	  set *(uint64_t *)$kgm_pkt->data = (uint64_t)$arg2
       end
       set manual_pkt.input = 1
       # dummy to make sure manual packet is executed
       set $kgm_dummy = &_mh_execute_header
       set $kgm_pkt = (kdp_writephysmem64_reply_t *)&manual_pkt.data
       set $kgm_writephysint_result = $kgm_pkt->error
end

define writephys8
       writephysint $arg0 8 $arg1 $kgm_lcpu_self
end

define writephys16
       writephysint $arg0 16 $arg1 $kgm_lcpu_self
end

define writephys32
       writephysint $arg0 32 $arg1 $kgm_lcpu_self
end

define writephys64
       writephysint $arg0 64 $arg1 $kgm_lcpu_self
end

document writephys8
| See writephys64
end

document writephys16
| See writephys64
end

document writephys32
| See writephys64
end

document writephys64
| The argument is interpreted as a physical address, and the second argument is
| written to that address as a 64-bit word.
end

define addkextsyms
	if ($argc <= 1)
		if ($argc == 0)
			printf "Adding kext symbols from in-kernel summary data.\n"
			add-all-kexts
		else
			printf "Adding kext symbols from $arg0.\n"
			shell echo cd `pwd` > /tmp/gdb-cd
			cd $arg0
			source kcbmacros
			source /tmp/gdb-cd
		end
		set $kgm_show_kmod_syms = 1
#ifndef _OPEN_SOURCE_
		echo \n\nIf you're having trouble with kext symbols, see:\n\thttp://eightball.apple.com/luna/index.php/DWARF_Kernel_Extensions\n\n
#endif
	else
		printf "| Usage:\n|\n"
		help addkextsyms
	end
end

document addkextsyms
| If specified without an argument, uses gdb's add-all-kexts command to load
| kext symbols. Otherwise, takes a directory of kext symbols generated with
| kextcache -y or kcgen and loads them into gdb.
| (gdb) addkextsyms
| - or -
| (gdb) addkextsyms /path/to/symboldir
end

define showprocfiles
    if ($argc == 1)
	_showprocheader
	_showprocfiles $arg0
    else
    	printf "| Usage:\n|\n"
	help showprocfiles
    end
end
document showprocfiles
Syntax: (gdb) showprocfiles <proc_t>
| Given a proc_t pointer, display the list of open file descriptors for the
| referenced process.
end

define _showprocheader
    printf "fd     fileglob  "
    showptrhdrpad
    printf "  fg flags    fg type   fg data   "
    showptrhdrpad
    printf "  info\n"
    printf "-----  ----------"
    if $kgm_lp64
        printf "--------"
    end
    printf "  ----------  --------  ----------"
    if $kgm_lp64
        printf "--------"
    end
    printf "  -------------------\n"
end

define _showprocfiles
    set $kgm_spf_filedesc = ((proc_t)$arg0)->p_fd
    set $kgm_spf_last = $kgm_spf_filedesc->fd_lastfile
    set $kgm_spf_ofiles = $kgm_spf_filedesc->fd_ofiles
    set $kgm_spf_count = 0
    while ($kgm_spf_count <= $kgm_spf_last)
	if ($kgm_spf_ofiles[$kgm_spf_count] == 0)
	    # DEBUG: For files that were open, but are now closed
	    # printf "%-5d  FILEPROC_NULL\n", $kgm_spf_count
	else
	    # display fd #, fileglob address, fileglob flags
	    set $kgm_spf_flags = $kgm_spf_ofiles[$kgm_spf_count].f_flags
	    set $kgm_spf_fg = $kgm_spf_ofiles[$kgm_spf_count].f_fglob
	    printf "%-5d  ", $kgm_spf_count
	    showptr $kgm_spf_fg
	    printf "  0x%08x  ", $kgm_spf_flags
	    # decode fileglob type
	    set $kgm_spf_fgt = $kgm_spf_fg->fg_type
	    if ($kgm_spf_fgt == 1)
	    	printf "VNODE   "
	    end
	    if ($kgm_spf_fgt == 2)
	    	printf "SOCKET  "
	    end
	    if ($kgm_spf_fgt == 3)
	    	printf "PSXSHM  "
	    end
	    if ($kgm_spf_fgt == 4)
	    	printf "PSXSEM  "
	    end
	    if ($kgm_spf_fgt == 5)
	    	printf "KQUEUE  "
	    end
	    if ($kgm_spf_fgt == 6)
	    	printf "PIPE    "
	    end
	    if ($kgm_spf_fgt == 7)
	    	printf "FSEVENTS"
	    end
	    if ($kgm_spf_fgt < 1 || $kgm_spf_fgt > 7)
	        printf "?: %-5d", $kgm_spf_fgt
	    end

	    # display fileglob data address and decode interesting fact(s)
	    # about data, if we know any
	    set $kgm_spf_fgd = $kgm_spf_fg->fg_data
	    printf "  "
	    showptr $kgm_spf_fgd
	    printf "  "
	    if ($kgm_spf_fgt == 1)
	    	set $kgm_spf_name = ((struct vnode *)$kgm_spf_fgd)->v_name
		if ($kgm_spf_name == 0)
		    printf "(null)"
		else
		    printf "%s", $kgm_spf_name
		end
	    end
	    printf "\n"
	end
    	set $kgm_spf_count = $kgm_spf_count + 1
    end
end

#
# Show all the advisory file locks held by a process for each of the vnode
# type files that it has open; do this by walking the per process open file
# table and looking at any vnode type fileglob that has a non-NULL lock list
# associated with it.
#
define showproclocks
    if ($argc == 1)
	_showproclocks $arg0
    else
    	printf "| Usage:\n|\n"
	help showproclocks
    end
end
document showproclocks
Syntax: (gdb) showproclocks <proc_t>
| Given a proc_t pointer, display the list of advisory file locks held by the
| referenced process.
end

define _showproclocks
    set $kgm_spl_filedesc = ((proc_t)$arg0)->p_fd
    set $kgm_spl_last = $kgm_spl_filedesc->fd_lastfile
    set $kgm_spl_ofiles = $kgm_spl_filedesc->fd_ofiles
    set $kgm_spl_count = 0
    set $kgm_spl_seen = 0
    while ($kgm_spl_count <= $kgm_spl_last)
	if ($kgm_spl_ofiles[$kgm_spl_count] == 0)
	    # DEBUG: For files that were open, but are now closed
	    # printf "%-5d  FILEPROC_NULL\n", $kgm_spl_count
	else
	    set $kgm_spl_fg = $kgm_spl_ofiles[$kgm_spl_count].f_fglob
	    # decode fileglob type
	    set $kgm_spl_fgt = $kgm_spl_fg->fg_type
	    if ($kgm_spl_fgt == 1)
		set $kgm_spl_fgd = $kgm_spl_fg->fg_data
	    	set $kgm_spl_name = ((struct vnode *)$kgm_spl_fgd)->v_name
		set $kgm_spl_vnode = ((vnode_t)$kgm_spl_fgd)
		set $kgm_spl_lockiter = $kgm_spl_vnode->v_lockf
		if ($kgm_spl_lockiter != 0)
		    if ($kgm_spl_seen == 0)
			_showvnodelockheader
		    end
		    set $kgm_spl_seen = $kgm_spl_seen + 1
		    printf "( fd %d, name ", $kgm_spl_count
		    if ($kgm_spl_name == 0)
			printf "(null) )"
		    else
			printf "%s )\n", $kgm_spl_name
		    end
		    _showvnodelocks $kgm_spl_fgd
		end
	    end
	end
    	set $kgm_spl_count = $kgm_spf_count + 1
    end
    printf "%d total locks for ", $kgm_spl_seen
    showptr $arg0
    printf "\n"
end

define showprocinfo
    set $kgm_spi_proc = (proc_t)$arg0
    printf "Process "
    showptr $kgm_spi_proc
    printf "\n"
    printf "   name %s\n", $kgm_spi_proc->p_comm
    printf "   pid:%.8d", $kgm_spi_proc->p_pid
    printf "   task:"
    showptr $kgm_spi_proc->task
    printf "   p_stat:%.1d", $kgm_spi_proc->p_stat
    printf "   parent pid:%.8d", $kgm_spi_proc->p_ppid
    printf "\n"
    # decode part of credential
    set $kgm_spi_cred = $kgm_spi_proc->p_ucred
    if ($kgm_spi_cred != 0)
	printf "Cred: euid %d ruid %d svuid %d\n", $kgm_spi_cred->cr_posix.cr_uid, $kgm_spi_cred->cr_posix.cr_ruid, $kgm_spi_cred->cr_posix.cr_svuid
    else
    	printf "Cred: (null)\n"
    end
    # decode flags
    set $kgm_spi_flag = $kgm_spi_proc->p_flag
    printf "Flags: 0x%08x\n", $kgm_spi_flag
    if ($kgm_spi_flag & 0x00000001)
	printf "    0x00000001 - may hold advisory locks\n"
    end
    if ($kgm_spi_flag & 0x00000002)
	printf "    0x00000002 - has a controlling tty\n"
    end
    if ($kgm_spi_flag & 0x00000004)
	printf "    0x00000004 - process is 64 bit\n"
    else
	printf "   !0x00000004 - process is 32 bit\n"
    end
    if ($kgm_spi_flag & 0x00000008)
	printf "    0x00000008 - no SIGCHLD on child stop\n"
    end
    if ($kgm_spi_flag & 0x00000010)
	printf "    0x00000010 - waiting for child exec/exit\n"
    end
    if ($kgm_spi_flag & 0x00000020)
	printf "    0x00000020 - has started profiling\n"
    end
    if ($kgm_spi_flag & 0x00000040)
	printf "    0x00000040 - in select; wakeup/waiting danger\n"
    end
    if ($kgm_spi_flag & 0x00000080)
	printf "    0x00000080 - was stopped and continued\n"
    end
    if ($kgm_spi_flag & 0x00000100)
	printf "    0x00000100 - has set privileges since exec\n"
    end
    if ($kgm_spi_flag & 0x00000200)
	printf "    0x00000200 - system process: no signals, stats, or swap\n"
    end
    if ($kgm_spi_flag & 0x00000400)
	printf "    0x00000400 - timing out during a sleep\n"
    end
    if ($kgm_spi_flag & 0x00000800)
	printf "    0x00000800 - debugged process being traced\n"
    end
    if ($kgm_spi_flag & 0x00001000)
	printf "    0x00001000 - debugging process has waited for child\n"
    end
    if ($kgm_spi_flag & 0x00002000)
	printf "    0x00002000 - exit in progress\n"
    end
    if ($kgm_spi_flag & 0x00004000)
	printf "    0x00004000 - process has called exec\n"
    end
    if ($kgm_spi_flag & 0x00008000)
	printf "    0x00008000 - owe process an addupc() XXX\n"
    end
    if ($kgm_spi_flag & 0x00010000)
	printf "    0x00010000 - affinity for Rosetta children\n"
    end
    if ($kgm_spi_flag & 0x00020000)
	printf "    0x00020000 - wants to run Rosetta\n"
    end
    if ($kgm_spi_flag & 0x00040000)
	printf "    0x00040000 - has wait() in progress\n"
    end
    if ($kgm_spi_flag & 0x00080000)
	printf "    0x00080000 - kdebug tracing on for this process\n"
    end
    if ($kgm_spi_flag & 0x00100000)
	printf "    0x00100000 - blocked due to SIGTTOU or SIGTTIN\n"
    end
    if ($kgm_spi_flag & 0x00200000)
	printf "    0x00200000 - has called reboot()\n"
    end
    if ($kgm_spi_flag & 0x00400000)
	printf "    0x00400000 - is TBE state\n"
    end
    if ($kgm_spi_flag & 0x00800000)
	printf "    0x00800000 - signal exceptions\n"
    end
    if ($kgm_spi_flag & 0x01000000)
	printf "    0x01000000 - has thread cwd\n"
    end
    if ($kgm_spi_flag & 0x02000000)
	printf "    0x02000000 - has vfork() children\n"
    end
    if ($kgm_spi_flag & 0x04000000)
	printf "    0x04000000 - not allowed to attach\n"
    end
    if ($kgm_spi_flag & 0x08000000)
	printf "    0x08000000 - vfork() in progress\n"
    end
    if ($kgm_spi_flag & 0x10000000)
	printf "    0x10000000 - no shared libraries\n"
    end
    if ($kgm_spi_flag & 0x20000000)
	printf "    0x20000000 - force quota for root\n"
    end
    if ($kgm_spi_flag & 0x40000000)
	printf "    0x40000000 - no zombies when children exit\n"
    end
    if ($kgm_spi_flag & 0x80000000)
	printf "    0x80000000 - don't hang on remote FS ops\n"
    end
    # decode state
    set $kgm_spi_state = $kgm_spi_proc->p_stat
    printf "State: "
    if ($kgm_spi_state == 1)
    	printf "Idle\n"
    end
    if ($kgm_spi_state == 2)
    	printf "Run\n"
    end
    if ($kgm_spi_state == 3)
    	printf "Sleep\n"
    end
    if ($kgm_spi_state == 4)
    	printf "Stop\n"
    end
    if ($kgm_spi_state == 5)
    	printf "Zombie\n"
    end
    if ($kgm_spi_state == 6)
    	printf "Reaping\n"
    end
    if ($kgm_spi_state < 1 || $kgm_spi_state > 6)
    	printf "(Unknown)\n"
    end
end

document showprocinfo
Syntax: (gdb) showprocinfo <proc_t>
| Displays name, pid, parent and task for a proc_t. Decodes cred, flag and p_stat fields.
end

#
# dump the zombprocs 
#
define zombproc
  set $basep = (struct proc  *)zombproc->lh_first
  set $pp = $basep
  while $pp
	showprocinfo $pp
      set $pp = $pp->p_list.le_next
  end
end

document zombproc
Syntax: (gdb) zombproc 
| Routine to print out all procs in the zombie list
end

#
# dump the zombstacks 
#
define zombstacks
  set $basep = (struct proc  *)zombproc->lh_first
  set $pp = $basep
  while $pp
	if $pp->p_stat != 5
		showtaskstacks $pp->task
	end
     set $pp = $pp->p_list.le_next
  end
end

document zombstacks
Syntax: (gdb) zombstacks 
| Routine to print out all stacks of tasks that are exiting
end


#
# dump the allprocs
#
define allproc
  set $basep = (struct proc  *)allproc->lh_first
  set $pp = $basep
  while $pp
	showprocinfo $pp
      set $pp = $pp->p_list.le_next
  end
end

document allproc
Syntax: (gdb) allproc 
| Routine to print out all process in the system 
| which are not in the zombie list
end
define showprocsiblingint
    set $kgm_sibling_ptr = (struct proc *)$arg0
    set $kgm_lx = $arg1 
    while $kgm_lx
        printf "|  " 
        set $kgm_lx = $kgm_lx-3 
    end   
    printf "|--%d    %s    [ 0x%llx ]\n", $kgm_sibling_ptr->p_pid, $kgm_sibling_ptr->p_comm, $kgm_sibling_ptr
end
define showproctreeint
#Initialize all the set variables used in this macro
    set $kgm_basep1 = 0
    set $kgm_sibling_ptr = 0
    set $kgm_lx = 0
    set $kgm_tmp_base = 0
    set $kgm_head_ptr = 0
    set $kgm_search_pid = 0 
    set $kgm_rev = 0
    set $kgm_x = 0

    set $kgm_basep1 = (struct proc *)allproc->lh_first
    if ($arg0 == 0)
        set $kgm_head_ptr = (struct proc *)initproc
    end       
    if ($arg0 > 0)
        set $kgm_tmp_base = (struct proc *)allproc->lh_first
        set $kgm_search_pid = $arg0 
        while $kgm_tmp_base
            if ( $kgm_tmp_base->p_pid == $kgm_search_pid)
               if ($kgm_tmp_base->p_childrencnt > 0)
                    set $kgm_head_ptr = $kgm_tmp_base->p_children.lh_first
               else
                    set $kgm_head_ptr = 0
                    printf "No children present for PID=%d", $kgm_search_pid
               end
               loop_break
            end
            set $kgm_tmp_base = $kgm_tmp_base->p_list.le_next
        end
    end
    set $kgm_rev = 0
    set $kgm_x = 0
    if ($kgm_head_ptr)
        printf "PID   PROCESS       POINTER]\n"
        printf "===   =======       =======\n"
        printf "%d    %s      [ 0x%llx ]\n", $kgm_head_ptr->p_ppid, $kgm_head_ptr->p_pptr->p_comm, $kgm_head_ptr
        printf "|--%d    %s      [ 0x%llx ]\n", $kgm_head_ptr->p_pid, $kgm_head_ptr->p_comm, $kgm_head_ptr
    end
    while ($kgm_head_ptr)
       #Is childrencnt = 0?       YES  {=> no children}
        if ($kgm_head_ptr->p_childrencnt == 0)
            # Does it have sibling? 
            if($kgm_head_ptr->p_sibling.le_next == 0)
                #No, it does not have sibling, so go back to its parent which will go to its sibling
                if($kgm_head_ptr == $kgm_head_ptr->p_pptr)
                    loop_break
                end
                set $kgm_head_ptr = $kgm_head_ptr->p_pptr
                if ($kgm_head_ptr == $kgm_tmp_base)
                    loop_break
                end
                if ($kgm_x > 3)
                    set $kgm_x = $kgm_x - 3
                end
                set $kgm_rev = 1
            end
            if($kgm_head_ptr->p_sibling.le_next != 0)
                # Yes, it has sibling. So print sibling
                set $kgm_rev = 0
                showprocsiblingint $kgm_head_ptr->p_sibling.le_next $kgm_x
                set $kgm_head_ptr = $kgm_head_ptr->p_sibling.le_next
            end
        # childrencnt != 0  {=> it has children}
        else
            if ($kgm_rev == 1)
                if($kgm_head_ptr->p_sibling.le_next == 0)
                    #No, it does not have sibling, so go back to its parent which will go to its sibling
                    if($kgm_head_ptr == $kgm_head_ptr->p_pptr)
                        loop_break
                    end
                    set $kgm_head_ptr = $kgm_head_ptr->p_pptr
                    if ($kgm_head_ptr == $kgm_tmp_base)
                        loop_break
                    end

                    if ($kgm_x > 3)
                        set $kgm_x = $kgm_x - 3
                    end
                    set $kgm_rev = 1
                end
                if($kgm_head_ptr->p_sibling.le_next != 0)
                    set $kgm_rev = 0
                    # Yes, it has sibling. So print sibling
                    showprocsiblingint $kgm_head_ptr->p_sibling.le_next $kgm_x
                    set $kgm_head_ptr = $kgm_head_ptr->p_sibling.le_next
                end
            else
                set $kgm_head_ptr = $kgm_head_ptr->p_children.lh_first
                set $kgm_x = $kgm_x + 3
                set $kgm_lx = $kgm_x
                while $kgm_lx
                    printf "|  "
                    set $kgm_lx = $kgm_lx-3
                end
                printf "|--%d    %s      [ 0x%llx ] \n", $kgm_head_ptr->p_pid, $kgm_head_ptr->p_comm, $kgm_head_ptr
            end
        end
    end
    printf "\n"
#Unset all the set variables used in this macro
    set $kgm_basep1 = 0
    set $kgm_sibling_ptr = 0
    set $kgm_lx = 0
    set $kgm_tmp_base = 0
    set $kgm_head_ptr = 0
    set $kgm_search_pid = 0
    set $kgm_rev = 0
    set $kgm_x = 0
end
define showproctree
    if ($argc > 0)
        showproctreeint $arg0
    else
        showproctreeint 0
    end
end
document showproctree
Syntax: (gdb) showproctree <pid>
| Routine to print the processes in the system in a hierarchical tree form. This routine does not print zombie processes.
| If no argument is given, showproctree will print all the processes in the system.  
| If pid is specified, showproctree prints all the descendants of the indicated process
end


define print_vnode
   set $vp = (struct vnode *)$arg0
   printf "   "
   printf " vp "
   showptr $vp
   printf " use %d", $vp->v_usecount
   printf " io %d", $vp->v_iocount
   printf " kuse %d", $vp->v_kusecount
   printf " type %d", $vp->v_type
   printf " flg 0x%.8x", $vp->v_flag
   printf " lflg 0x%.8x", $vp->v_lflag
   printf " par "
   showptr $vp->v_parent
   set $_name = (char *)$vp->v_name
   if ($_name != 0)
      printf " %s", $_name
   end
  if ($vp->v_type == VREG) && ($vp->v_un.vu_ubcinfo != 0)
       printf " mapped %d", ($vp->v_un.vu_ubcinfo.ui_flags & 0x08) ? 1 : 0
   end
   printf "\n"
end

document print_vnode
Syntax: (gdb) print_vnode <vnode>
| Prints out the fields of a vnode struct
end

define showprocvnodes
	set $pp = (struct proc *)$arg0
	set $fdp = (struct filedesc *)$pp->p_fd
	set $cvp = $fdp->fd_cdir
	set $rvp = $fdp->fd_rdir
	if $cvp
		printf "Current Working Directory \n"
		print_vnode $cvp
		printf "\n"
	end
	if $rvp
		printf "Current Root Directory \n"
		print_vnode $rvp
		printf "\n"
	end
	set $count = 0
	set $fpp =  (struct fileproc **)($fdp->fd_ofiles)
	set $fpo =  (char)($fdp->fd_ofileflags[0])
	while $count < $fdp->fd_nfiles
		#printf"fpp %x ", *$fpp
		if *$fpp
			set $fg =(struct fileglob *)((**$fpp)->f_fglob)
			if  $fg && (($fg)->fg_type == 1) 
				if $fdp->fd_ofileflags[$count] & 4
					printf "U: "
				else
					printf " "
				end
				printf "fd = %d ", $count
				print_vnode $fg->fg_data
			end
		end
		set $fpp = $fpp + 1
	 	set $count = $count + 1		
	end
end

document showprocvnodes
Syntax: (gdb) showprocvnodes <proc_address>
| Routine to print out all the open fds
| which are vnodes in a process
end

define showallprocvnodes
  set $basep = (struct proc  *)allproc->lh_first
  set $pp = $basep
  while $pp
	printf "============================================ \n"
	showprocinfo $pp
	showprocvnodes $pp
  	set $pp = $pp->p_list.le_next
  end
end

document showallprocvnodes
Syntax: (gdb) showallprocvnodes
| Routine to print out all the open fds
| which are vnodes 
end


#   
# dump the childrent of a proc 
#
define showinitchild
  set $basep = (struct proc  *)initproc->p_children.lh_first
  set $pp = $basep
  while $pp
	showprocinfo $pp
      set $pp = $pp->p_sibling.le_next
  end
end

document showinitchild
Syntax: (gdb) showinitchild 
| Routine to print out all processes in the system 
| which are children of init process
end


define showmountallvnodes
  set $mp = (struct mount *)$arg0
  set $basevp = (struct vnode *)$mp->mnt_vnodelist.tqh_first
  set $vp = $basevp
  printf "____________________ Vnode list Queue ---------------\n"
  while $vp
      print_vnode $vp
      set $vp = $vp->v_mntvnodes->tqe_next
  end
  set $basevp = (struct vnode *)$mp->mnt_workerqueue.tqh_first
  set $vp = $basevp
  printf "____________________ Worker Queue ---------------\n"
  while $vp
      print_vnode $vp
      set $vp = $vp->v_mntvnodes->tqe_next
  end
  set $basevp = (struct vnode *)$mp->mnt_newvnodes.tqh_first
  set $vp = $basevp
  printf "____________________ New vnodes  Queue ---------------\n"
  while $vp
      print_vnode $vp
      set $vp = $vp->v_mntvnodes->tqe_next
  end
end
document showmountallvnodes
Syntax: showmountallvnodes <struct mount *>
| Print the vnode inactive list
end


define showmountvnodes
  set $mp = (struct mount *)$arg0
  set $basevp = (struct vnode *)$mp->mnt_vnodelist.tqh_first
  set $vp = $basevp
  printf "____________________ Vnode list Queue ---------------\n"
  while $vp
      print_vnode $vp
      set $vp = $vp->v_mntvnodes->tqe_next
  end
end
document showmountvnodes
Syntax: showmountvnodes <struct mount *>
| Print the vnode list
end



define showworkqvnodes
  set $mp = (struct mount *)$arg0
  set $basevp = (struct vnode *)$mp->mnt_workerqueue.tqh_first
  set $vp = $basevp
  printf "____________________ Worker Queue ---------------\n"
  while $vp
      print_vnode $vp
      set $vp = $vp->v_mntvnodes->tqe_next
  end
end
document showworkqvnodes
Syntax: showworkqvnodes <struct mount *>
| Print the vnode worker list
end


define shownewvnodes
  set $mp = (struct mount *)$arg0
  set $basevp = (struct vnode *)$mp->mnt_newvnodes.tqh_first
  set $vp = $basevp
  printf "____________________ New vnodes  Queue ---------------\n"
  while $vp
      print_vnode $vp
      set $vp = $vp->v_mntvnodes->tqe_next
  end
end

document shownewvnodes
Syntax: shownewvnodes <struct mount *>
| Print the new vnode list
end


#
# print mount point info
define print_mount 
   set $mp = (struct mount *)$arg0
   printf "   "
   printf " mp "
   showptr $mp
   printf " flag %x", $mp->mnt_flag
   printf " kern_flag %x", $mp->mnt_kern_flag
   printf " lflag %x", $mp->mnt_lflag
   printf " type:  %s", $mp->mnt_vfsstat.f_fstypename
   printf " mnton:  %s", $mp->mnt_vfsstat.f_mntonname
   printf " mntfrom:  %s", $mp->mnt_vfsstat.f_mntfromname
   printf "\n"
end

define showallmounts
	set $mp=(struct mount *)mountlist.tqh_first
	while $mp
	 	print_mount $mp
		set $mp = $mp->mnt_list.tqe_next
	end
end
	
document showallmounts
Syntax: showallmounts
| Print all mount points
end

define pcprint
	if (((unsigned long) $arg0 < (unsigned long) &_mh_execute_header || \
	     (unsigned long) $arg0 >= (unsigned long) &last_kernel_symbol ))
		showkmodaddr $arg0
	else
		output /a $arg0
	end
end

define mbuf_walkpkt
	set $mp = (struct mbuf *)$arg0
	set $cnt = 1
	set $tot = 0
	while $mp
		printf "%4d: %p [len %4d, type %2d, ", $cnt, $mp, \
		    $mp->m_hdr.mh_len, $mp->m_hdr.mh_type
		if mclaudit != 0
			mbuf_buf2mca $mp
			printf ", "
		end
		set $tot = $tot + $mp->m_hdr.mh_len
		printf "total %d]\n", $tot
		set $mp = $mp->m_hdr.mh_nextpkt
		set $cnt = $cnt + 1
	end
end

document mbuf_walkpkt
Syntax: (gdb) mbuf_walkpkt <addr>
| Given an mbuf address, walk its m_nextpkt pointer
end

define mbuf_walk
	set $mp = (struct mbuf *)$arg0
	set $cnt = 1
	set $tot = 0
	while $mp
		printf "%4d: %p [len %4d, type %2d, ", $cnt, $mp, \
		    $mp->m_hdr.mh_len, $mp->m_hdr.mh_type
		if mclaudit != 0
			mbuf_buf2mca $mp
			printf ", "
		end
		set $tot = $tot + $mp->m_hdr.mh_len
		printf "total %d]\n", $tot
		set $mp = $mp->m_hdr.mh_next
		set $cnt = $cnt + 1
	end
end

document mbuf_walk
Syntax: (gdb) mbuf_walk <addr>
| Given an mbuf address, walk its m_next pointer
end

define mbuf_buf2slab
	set $addr = $arg0
	set $gix = ((char *)$addr - (char *)mbutl) >> 20
	set $ix = ((char *)$addr - (char *)slabstbl[$gix].slg_slab[0].sl_base) >> 12
	set $slab = &slabstbl[$gix].slg_slab[$ix]
	if $kgm_lp64
		printf "0x%-16llx", $slab
	else
		printf "0x%-8x", $slab
	end
end

document mbuf_buf2slab
| Given an mbuf object, find its corresponding slab address.
end

define mbuf_buf2mca
	set $addr = $arg0
	set $ix = ((char *)$addr - (char *)mbutl) >> 12
	set $clbase = ((union mbigcluster *)mbutl) + $ix
	set $mclidx = (((char *)$addr - (char *)$clbase) >> 8)
	set $mca = mclaudit[$ix].cl_audit[$mclidx]
	if $kgm_lp64
		printf "mca: 0x%-16llx", $mca
	else
		printf "mca: 0x%-8x", $mca
	end
end

document mbuf_buf2mca
Syntax: (gdb) mbuf_buf2mca <addr>
| Given an mbuf object, find its buffer audit structure address.
| This requires mbuf buffer auditing to be turned on, by setting
| the appropriate flags to the "mbuf_debug" boot-args parameter.
end

define mbuf_showmca
	set language c
	set $mca = (mcache_audit_t *)$arg0
	set $cp = (mcache_t *)$mca->mca_cache
	printf "object type:\t\t"
	mbuf_mca_ctype $mca 1
	printf "\ncontrolling mcache:\t%p (%s)\n", $mca->mca_cache, $cp->mc_name
	if $mca->mca_uflags & $MB_SCVALID
		set $ix = ((char *)$mca->mca_addr - (char *)mbutl) >> 12
		set $clbase = ((union mbigcluster *)mbutl) + $ix
		set $mclidx = (((char *)$mca->mca_addr - (char *)$clbase) >> 8)
		printf "mbuf obj:\t\t%p\n", $mca->mca_addr
		printf "mbuf index:\t\t%d (out of 16) in cluster base %p\n", \
		    $mclidx + 1, $clbase
		if $mca->mca_uptr != 0
			set $peer_mca = (mcache_audit_t *)$mca->mca_uptr
			printf "paired cluster obj:\t%p (mca %p)\n", \
			    $peer_mca->mca_addr, $peer_mca
		end
		printf "saved contents:\t\t%p (%d bytes)\n", \
		    $mca->mca_contents, $mca->mca_contents_size
	else
		printf "cluster obj:\t\t%p\n", $mca->mca_addr
		if $mca->mca_uptr != 0
			set $peer_mca = (mcache_audit_t *)$mca->mca_uptr
			printf "paired mbuf obj:\t%p (mca %p)\n", \
			    $peer_mca->mca_addr, $peer_mca
		end
	end
	printf "recent transaction for this buffer (thread %p):\n", \
	    $mca->mca_thread
	set $cnt = 0
	while $cnt < $mca->mca_depth
		set $kgm_pc = $mca->mca_stack[$cnt]
		printf "%4d: ", $cnt + 1
		pcprint $kgm_pc
		printf "\n"
		set $cnt = $cnt + 1
	end
	if $mca->mca_pdepth > 0
		printf "previous transaction for this buffer (thread %p):\n", \
		    $mca->mca_pthread
	end
	set $cnt = 0
	while $cnt < $mca->mca_pdepth
		set $kgm_pc = $mca->mca_pstack[$cnt]
		printf "%4d: ", $cnt + 1
		pcprint $kgm_pc
		printf "\n"
		set $cnt = $cnt + 1
	end
	set language auto
end

document mbuf_showmca
Syntax: (gdb) mbuf_showmca <addr>
| Given an mbuf/cluster buffer audit structure address, print the audit
| records including the stack trace of the last buffer transaction.
end

define mbuf_topleak
	set language c
	set $topcnt = 0
	if $arg0 < 5
		set $maxcnt = $arg0
	else
		set $maxcnt = 5
	end
	while $topcnt < $maxcnt
		mbuf_traceleak mleak_top_trace[$topcnt]
		set $topcnt = $topcnt + 1
	end
	set language auto
end

document mbuf_topleak
Syntax: (gdb) mbuf_topleak <num>
| Prints information about the top <num> suspected mbuf leakers
| where <num> is a value <= 5
end

define mbuf_traceleak
	set language c
	set $trace = (struct mtrace *) $arg0
	if $trace->allocs != 0
		printf "%p:%d outstanding allocs\n", $trace, $trace->allocs
		printf "backtrace saved %d deep:\n", $trace->depth
		if $trace->depth != 0
			set $cnt = 0
			while $cnt < $trace->depth
		                printf "%4d: ", $cnt + 1
				pcprint $trace->addr[$cnt]
				printf "\n"
				set $cnt = $cnt + 1
			end
		end
	end
	set language auto
end

document mbuf_traceleak
Syntax: (gdb) mbuf_traceleak <addr>
| Given an mbuf leak trace (mtrace) structure address, print out the
| stored information with that trace
end

set $MCF_NOCPUCACHE = 0x10

define mcache_stat
	set $head = (mcache_t *)mcache_head
	set $mc = $head

    if $kgm_lp64
		printf "cache                        cache              cache    buf   buf            backing             (# of retries)     bufs\n"
		printf "name                         state               addr   size align               zone     wait   nowait   failed  incache\n"
		printf "------------------------- -------- ------------------ ------ ----- ------------------ -------------------------- --------\n"
	else
		printf "cache                        cache      cache    buf   buf    backing             (# of retries)     bufs\n"
		printf "name                         state       addr   size align       zone     wait   nowait   failed  incache\n"
		printf "------------------------- -------- ---------- ------ ----- ---------- -------------------------- --------\n"
	end
	while $mc != 0
		set $bktsize = $mc->mc_cpu.cc_bktsize
		printf "%-25s ", $mc->mc_name
		if ($mc->mc_flags & $MCF_NOCPUCACHE)
			printf "disabled"
		else
			if $mc->mc_purge_cnt > 0
				printf " purging"
			else
				if $bktsize == 0
					printf " offline"
				else
					printf "  online"
				end
			end
		end
		printf " %p %6d %5d ",$mc, \
		    $mc->mc_bufsize, $mc->mc_align
		if $mc->mc_slab_zone != 0
			printf "%p", $mc->mc_slab_zone
		else
		    if $kgm_lp64
				printf "            custom"
			else
				printf "    custom"
			end
		end
		set $tot = 0
		set $tot += $mc->mc_full.bl_total * $bktsize
		set $ccp = (mcache_cpu_t *)$mc->mc_cpu
		set $n = 0
		while $n < ncpu
			if $ccp->cc_objs > 0
				set $tot += $ccp->cc_objs
			end
			if $ccp->cc_pobjs > 0
				set $tot += $ccp->cc_pobjs
			end
			set $n += 1
			set $ccp += 1
		end
		printf " %8d %8d %8d %8d", $mc->mc_wretry_cnt, \
		    $mc->mc_nwretry_cnt, $mc->mc_nwfail_cnt, $tot
		printf "\n"
		set $mc = (mcache_t *)$mc->mc_list.le_next
	end
end

document mcache_stat
Syntax: (gdb) mcache_stat
| Print all mcaches in the system.
end

define mcache_showzone
	set $mc = (mcache_t *)$arg0
	if $mc->mc_slab_zone != 0
		printf "%p", $mc->mc_slab_zone
	else
		printf "   custom"
end

document mcache_showzone
Syntax: (gdb) mcache_showzone <mcache_addr>
| Print the type of backend (custom or zone) of a mcache.
end

define mcache_walkobj
	set $p = (mcache_obj_t *)$arg0
	set $cnt = 1
	set $tot = 0
	while $p
		printf "%4d: %p\n", $cnt, $p,
		set $p = $p->obj_next
		set $cnt = $cnt + 1
	end
end

document mcache_walkobj
Syntax: (gdb) mcache_walkobj <addr>
| Given a mcache object address, walk its obj_next pointer
end

define mcache_showcache
	set $cp = (mcache_t *)$arg0
	set $ccp = (mcache_cpu_t *)$cp->mc_cpu
	set $bktsize = $cp->mc_cpu.cc_bktsize
	set $cnt = 0
	set $tot = 0
	printf "Showing cache '%s':\n\n", $cp->mc_name
	printf " CPU  cc_objs cc_pobjs    total\n"
	printf "---- -------- -------- --------\n"
	while $cnt < ncpu
		set $objs = $ccp->cc_objs
		if $objs <= 0
			set $objs = 0
		end
		set $pobjs = $ccp->cc_pobjs
		if $pobjs <= 0
			set $pobjs = 0
		end
		set $tot_cpu = $objs + $pobjs
		set $tot += $tot_cpu
		printf "%4d %8d %8d %8d\n", $cnt, $objs, $pobjs, $tot_cpu
		set $ccp += 1
		set $cnt += 1
	end
	printf "                       ========\n"
	printf "                       %8d\n", $tot
	printf "\n"
	set $tot += $cp->mc_full.bl_total * $bktsize
	printf "Total # of full buckets (%d objs/bkt):\t%-8d\n", \
	    $bktsize, $cp->mc_full.bl_total
	printf "Total # of objects cached:\t\t%-8d\n", $tot
end

document mcache_showcache
| Display the number of objects in the cache
end

set $NSLABSPMB = sizeof(mcl_slabg_t)/sizeof(mcl_slab_t)

define mbuf_slabstbl
	set $x = 0

	if $kgm_lp64
		printf "slot slabg              slabs range\n"
		printf "---- ------------------ -------------------------------------------\n"
	else
		printf "slot slabg      slabs range\n"
		printf "---- ---------- ---------------------------\n"
	end
	while $x < maxslabgrp
		set $slg = slabstbl[$x]
		printf "%3d: ", $x
		if $slg == 0
			printf "-\n"
		else
			if $kgm_lp64
				printf "0x%-16llx [ 0x%-16llx - 0x%-16llx ]\n", $slg, &$slg->slg_slab[0], \
				    &$slg->slg_slab[$NSLABSPMB-1]
			else
				printf "0x%-8x [ 0x%-8x - 0x%-8x ]\n", $slg, &$slg->slg_slab[0], \
				    &$slg->slg_slab[$NSLABSPMB-1]
			end
		end
		set $x += 1
	end
end

document mbuf_slabstbl
| Display the mbuf slabs table
end

set $SLF_MAPPED=0x0001
set $SLF_PARTIAL=0x0002
set $SLF_DETACHED=0x0004

define mbuf_slabs
	set $slg = (mcl_slabg_t *)$arg0
	set $x = 0

	if $kgm_lp64
		printf "slot slab               next               obj                mca                 C  R  N   size flags\n"
		printf "---- ------------------ ------------------ ------------------ ------------------ -- -- -- ------ -----\n"
	else
		printf "slot slab       next       obj        mca         C  R  N   size flags\n"
		printf "---- ---------- ---------- ---------- ---------- -- -- -- ------ -----\n"
	end
	while $x < $NSLABSPMB
		set $sl = &$slg->slg_slab[$x]
		set $mca = 0
		set $obj = $sl->sl_base

		if mclaudit != 0
			set $ix = ((char *)$obj - (char *)mbutl) >> 12
			set $clbase = ((union mbigcluster *)mbutl) + $ix
			set $mclidx = (((char *)$obj - (char *)$clbase) >> 8)
			set $mca = mclaudit[$ix].cl_audit[$mclidx]
		end

		if $kgm_lp64
			printf "%3d: 0x%-16llx 0x%-16llx 0x%-16llx 0x%-16llx %2d %2d %2d %6d 0x%04x ", \
			    $x + 1, $sl, $sl->sl_next, $obj, $mca, $sl->sl_class, \
			    $sl->sl_refcnt, $sl->sl_chunks, $sl->sl_len, \
			    $sl->sl_flags
		else
			printf "%3d: 0x%-8x 0x%-8x 0x%-8x 0x%-8x %2d %2d %2d %6d 0x%04x ", \
			    $x + 1, $sl, $sl->sl_next, $obj, $mca, $sl->sl_class, \
			    $sl->sl_refcnt, $sl->sl_chunks, $sl->sl_len, \
			    $sl->sl_flags
		end
		if $sl->sl_flags != 0
			printf "<"
			if $sl->sl_flags & $SLF_MAPPED
				printf "mapped"
			end
			if $sl->sl_flags & $SLF_PARTIAL
				printf ",partial"
			end
			if $sl->sl_flags & $SLF_DETACHED
				printf ",detached"
			end
			printf ">"
		end
		printf "\n"

		if $sl->sl_chunks > 1
			set $z = 1
			set $c = $sl->sl_len / $sl->sl_chunks

			while $z < $sl->sl_chunks
				set $obj = $sl->sl_base + ($c * $z)
				set $mca = 0

				if mclaudit != 0
					set $ix = ((char *)$obj - (char *)mbutl) >> 12
					set $clbase = ((union mbigcluster *)mbutl) + $ix
					set $mclidx = (((char *)$obj - (char *)$clbase) >> 8)
					set $mca = mclaudit[$ix].cl_audit[$mclidx]
				end

				if $kgm_lp64
					printf "                                           0x%-16llx 0x%-16llx\n", $obj, $mca
				else
					printf "                           0x%-8x 0x%-8x\n", $obj, $mca
				end
				set $z += 1
			end
		end

		set $x += 1
	end
end

document mbuf_slabs
| Display all mbuf slabs in the group
end

define mbuf_stat
	set $x = 0

	printf "class               total   cached     uncached           inuse           failed   waiter notified    purge\n"
	printf "name                 objs     objs     objs / slabs        objs      alloc count    count    count    count\n"
	printf "---------------- -------- -------- ------------------- -------- ---------------- -------- -------- --------\n"
	while $x < (sizeof(mbuf_table) / sizeof(mbuf_table[0]))
		set $mbt = mbuf_table[$x]
		set $mcs = (mb_class_stat_t *)mbuf_table[$x].mtbl_stats
		set $tot = 0
		set $mc = $mbt->mtbl_cache
		set $bktsize = $mc->mc_cpu.cc_bktsize
		set $tot += $mc->mc_full.bl_total * $bktsize
		set $ccp = (mcache_cpu_t *)$mc->mc_cpu
		set $n = 0
		while $n < ncpu
			if $ccp->cc_objs > 0
				set $tot += $ccp->cc_objs
			end
			if $ccp->cc_pobjs > 0
				set $tot += $ccp->cc_pobjs
			end
			set $n += 1
			set $ccp += 1
		end

		printf "%-16s %8d %8d %8d / %-8d %8d %16llu %8d %8llu %8llu", \
		    $mcs->mbcl_cname, $mcs->mbcl_total, $tot, \
		    $mcs->mbcl_infree, $mcs->mbcl_slab_cnt, \
		    ($mcs->mbcl_total - $tot - $mcs->mbcl_infree), \
		    $mcs->mbcl_fail_cnt, $mc->mc_waiter_cnt, \
		    $mcs->mbcl_notified, $mcs->mbcl_purge_cnt
		printf "\n"
		set $x += 1
	end
end

document mbuf_stat
| Print extended mbuf allocator statistics.
end

set $MB_INUSE = 0x1
set $MB_COMP_INUSE = 0x2
set $MB_SCVALID = 0x4

set $MCLBYTES = 2048
set $MSIZE = 256
set $NBPG = 4096
set $M16KCLBYTES = 16384

define mbuf_mca_ctype
	set $mca = (mcache_audit_t *)$arg0
	set $vopt = $arg1
	set $cp = $mca->mca_cache
	set $class = (unsigned int)$cp->mc_private
	set $csize = mbuf_table[$class].mtbl_stats->mbcl_size
	set $done = 0
	if $csize == $MSIZE
		if $vopt
			printf "M (mbuf) "
		else
			printf "M     "
		end
		set $done = 1
	end
	if !$done && $csize == $MCLBYTES
		if $vopt
			printf "CL (2K cluster) "
		else
			printf "CL    "
		end
		set $done = 1
	end
	if !$done && $csize == $NBPG
		if $vopt
			printf "BCL (4K cluster) "
		else
			printf "BCL   "
		end
		set $done = 1
	end
	if !$done && $csize == $M16KCLBYTES
		if $vopt
			printf "JCL (16K cluster) "
		else
			printf "JCL   "
		end
		set $done = 1
	end
	if !$done && $csize == ($MSIZE+$MCLBYTES)
		if $mca->mca_uflags & $MB_SCVALID
			if $mca->mca_uptr
				printf "M+CL  "
				if $vopt
					printf "(paired mbuf, 2K cluster)"
				end
			else
				printf "M-CL  "
				if $vopt
					printf "(unpaired mbuf, 2K cluster) "
				end
			end
		else
			if $mca->mca_uptr
				printf "CL+M  "
				if $vopt
					printf "(paired 2K cluster, mbuf) "
				end
			else
				printf "CL-M  "
				if $vopt
					printf "(paired 2K cluster, mbuf) "
				end
			end
		end
		set $done = 1
	end
	if !$done && $csize == ($MSIZE+$NBPG)
		if $mca->mca_uflags & $MB_SCVALID
			if $mca->mca_uptr
				printf "M+BCL "
				if $vopt
					printf "(paired mbuf, 4K cluster) "
				end
			else
				printf "M-BCL "
				if $vopt
					printf "(unpaired mbuf, 4K cluster) "
				end
			end
		else
			if $mca->mca_uptr
				printf "BCL+M "
				if $vopt
					printf "(paired 4K cluster, mbuf) "
				end
			else
				printf "BCL-M "
				if $vopt
					printf "(unpaired 4K cluster, mbuf) "
				end
			end
		end
		set $done = 1
	end
	if !$done && $csize == ($MSIZE+$M16KCLBYTES)
		if $mca->mca_uflags & $MB_SCVALID
			if $mca->mca_uptr
				printf "M+JCL "
				if $vopt
					printf "(paired mbuf, 16K cluster) "
				end
			else
				printf "M-JCL "
				if $vopt
					printf "(unpaired mbuf, 16K cluster) "
				end
			end
		else
			if $mca->mca_uptr
				printf "JCL+M "
				if $vopt
					printf "(paired 16K cluster, mbuf) "
				end
			else
				printf "JCL-M "
				if $vopt
					printf "(unpaired 16K cluster, mbuf) "
				end
			end
		end
		set $done = 1
	end
	if !$done
		printf "unknown: %s ", $cp->mc_name
	end
end

document mbuf_mca_ctype
| This is a helper macro for mbuf_show{active,inactive,all} that prints
| out the mbuf object type represented by a given mcache audit structure.
end

define mbuf_showactive
	if $argc == 0
		mbuf_walkallslabs 1 0
	else
		mbuf_walkallslabs 1 0 $arg0
	end
end

document mbuf_showactive
Syntax: (gdb) mbuf_showactive
| Walk the mbuf objects pool and print only the active ones; this
| requires mbuf debugging to be turned on, by setting the appropriate flags
| to the "mbuf_debug" boot-args parameter.  Active objects are those that
| are outstanding (have not returned to the mbuf slab layer) and in use
| by the client (have not been freed).
end

define mbuf_showinactive
	mbuf_walkallslabs 0 1
end

document mbuf_showinactive
Syntax: (gdb) mbuf_showinactive
| Walk the mbuf objects pool and print only the inactive ones; this
| requires mbuf debugging to be turned on, by setting the appropriate flags
| to the "mbuf_debug" boot-args parameter.  Inactive objects are those that
| are outstanding (have not returned to the mbuf slab layer) but have been
| freed by the client, i.e. they still reside in the mcache layer ready to
| be used for subsequent allocation requests.
end

define mbuf_showall
	mbuf_walkallslabs 1 1
end

document mbuf_showall
Syntax: (gdb) mbuf_showall
| Walk the mbuf objects pool and print them all; this requires
| mbuf debugging to be turned on, by setting the appropriate flags to the
| "mbuf_debug" boot-args parameter.
end

define mbuf_mcaobjs
end

define mbuf_walkallslabs
	set $show_a = $arg0
	set $show_f = $arg1
	if $argc == 3
		set $show_tr = $arg2
	else
		set $show_tr = 0
	end
	set $x = 0
	set $total = 0
	set $total_a = 0
	set $total_f = 0

	printf "("
	if $show_a && !$show_f
		printf "Searching only for active "
	end
	if !$show_a && $show_f
		printf "Searching only for inactive "
	end
	if $show_a && $show_f
		printf "Displaying all "
	end
	printf "objects; this may take a while ...)\n\n"

	if $kgm_lp64
		printf "                        slab                mca                obj        allocation\n"
		printf "slot idx             address            address            address type        state\n"
		printf "---- ---- ------------------ ------------------ ------------------ ----- -----------\n"
	else
		printf "                slab        mca        obj        allocation\n"
		printf "slot idx     address    address    address type        state\n"
		printf "---- ---- ---------- ---------- ---------- ----- -----------\n"
	end
	
	while $x < slabgrp
		set $slg = slabstbl[$x]
		set $y = 0
		set $stop = 0
		while $y < $NSLABSPMB && $stop == 0
			set $sl = &$slg->slg_slab[$y]
			set $base = (char *)$sl->sl_base
			set $ix = ($base - (char *)mbutl) >> 12
			set $clbase = ((union mbigcluster *)mbutl) + $ix
			set $mclidx = ($base - (char *)$clbase) >> 8
			set $mca = mclaudit[$ix].cl_audit[$mclidx]
			set $first = 1

			while $mca != 0 && $mca->mca_addr != 0
				set $printmca = 0
				if $mca->mca_uflags & ($MB_INUSE|$MB_COMP_INUSE)
					set $total_a = $total_a + 1
					set $printmca = $show_a
				else
					set $total_f = $total_f + 1
					set $printmca = $show_f
				end

				if $printmca != 0
					if $first == 1
						if $kgm_lp64
							printf "%4d %4d 0x%-16llx ", $x, $y, $sl
						else
							printf "%4d %4d 0x%-8x ", $x, $y, $sl
						end
					else
					    if $kgm_lp64
							printf "                             "
					    else
							printf "                     "
					    end
					end

					if $kgm_lp64
						printf "0x%-16llx 0x%-16llx ", $mca, $mca->mca_addr
					else
						printf "0x%-8x 0x%-8x ", $mca, $mca->mca_addr
					end

					mbuf_mca_ctype $mca 0
					if $mca->mca_uflags & ($MB_INUSE|$MB_COMP_INUSE)
						printf "active      "
					else
						printf "      freed "
					end
					if $first == 1
						set $first = 0
					end
					printf "\n"
					set $total = $total + 1
					
					if $show_tr != 0
						printf "recent transaction for this buffer (thread %p):\n", \
							$mca->mca_thread
						set $cnt = 0
						while $cnt < $mca->mca_depth
							set $kgm_pc = $mca->mca_stack[$cnt]
							printf "%4d: ", $cnt + 1
							pcprint $kgm_pc
							printf "\n"
							set $cnt = $cnt + 1
						end
					end
				end
				
				set $mca = $mca->mca_next
			end
			set $y += 1
			if $slg->slg_slab[$y].sl_base == 0
				set $stop = 1
			end
		end
		set $x += 1
	end
	if $total && $show_a && $show_f
		printf "\ntotal objects:\t%d\n", $total
		printf "active/unfreed:\t%d\n", $total_a
		printf "freed/in_cache:\t%d\n", $total_f
	end
end

document mbuf_walkallslabs
| Walk the mbuf objects pool; this requires mbuf debugging to be
| turned on, by setting the appropriate flags to the "mbuf_debug" boot-args
| parameter.  This is a backend routine for mbuf_show{active,inactive,all}.
end

define mbuf_countchain
	set $mp = (struct mbuf *)$arg0
	
	set $pkt = 0
	set $nxt = 0

	while $mp != 0
		set $pkt = $pkt + 1
	
		set $mn = (struct mbuf *)$mp->m_hdr.mh_next
		while $mn != 0
			set $nxt = $nxt + 1
			
			set $mn = (struct mbuf *)$mn->m_hdr.mh_next
		end
		
		set $mp = $mp->m_hdr.mh_nextpkt

		if (($pkt + $nxt) % 50) == 0
			printf "... %d\n", $pkt + $nxt
		end
	end

	printf "\ntotal: %d (via m_next: %d)\n", $pkt + $nxt, $nxt
end

document mbuf_countchain
Syntax: mbuf_countchain <addr>
| Count the total number of mbufs chained from the given the address of an mbuf. 
| The routine follows both the m_next pointers and m_nextpkt pointers.
end

set $RTF_UP          = 0x1
set $RTF_GATEWAY     = 0x2
set $RTF_HOST        = 0x4
set $RTF_REJECT      = 0x8
set $RTF_DYNAMIC     = 0x10
set $RTF_MODIFIED    = 0x20
set $RTF_DONE        = 0x40
set $RTF_DELCLONE    = 0x80
set $RTF_CLONING     = 0x100
set $RTF_XRESOLVE    = 0x200
set $RTF_LLINFO      = 0x400
set $RTF_STATIC      = 0x800
set $RTF_BLACKHOLE   = 0x1000
set $RTF_PROTO2      = 0x4000
set $RTF_PROTO1      = 0x8000
set $RTF_PRCLONING   = 0x10000
set $RTF_WASCLONED   = 0x20000
set $RTF_PROTO3      = 0x40000
set $RTF_PINNED      = 0x100000
set $RTF_LOCAL       = 0x200000
set $RTF_BROADCAST   = 0x400000
set $RTF_MULTICAST   = 0x800000
set $RTF_IFSCOPE     = 0x1000000
set $RTF_CONDEMNED   = 0x2000000
set $RTF_IFREF       = 0x4000000
set $RTF_PROXY       = 0x8000000
set $RTF_ROUTER      = 0x10000000

set $AF_INET = 2
set $AF_INET6 = 30
set $AF_LINK = 18

define rtentry_prdetails
	set $rt = (struct rtentry *)$arg0
	set $is_v6 = 0

	set $dst = (struct sockaddr *)$rt->rt_nodes->rn_u.rn_leaf.rn_Key
	if $dst->sa_family == $AF_INET
		showsockaddr_in $dst
		printf " "
	else
		if $dst->sa_family == $AF_INET6
			showsockaddr_in6 $dst
			printf " "
			set $is_v6 = 1
		else
			if $dst->sa_family == $AF_LINK
				showsockaddr_dl $dst
				printf " "
			else
				showsockaddr_unspec $dst
			end
		end
	end

	set $dst = (struct sockaddr *)$rt->rt_gateway
	if $dst->sa_family == $AF_INET
		showsockaddr_in $dst
		printf "   "
	else
		if $dst->sa_family == $AF_INET6
			set $is_v6 = 1
			showsockaddr_in6 $dst
			printf " "
		else
			if $dst->sa_family == $AF_LINK
				showsockaddr_dl $dst
				if $is_v6
					printf "                       "
				else
					printf " "
				end
			else
				showsockaddr_unspec $dst
			end
		end
	end

	if $rt->rt_flags & $RTF_WASCLONED
		if $kgm_lp64
			printf "%18p ", $rt->rt_parent
		else
			printf "%10p ", $rt->rt_parent
		end
	else
		if $kgm_lp64
			printf "                   "
		else
			printf "           "
		end
	end

	printf "%6u %8u ", $rt->rt_refcnt, $rt->rt_rmx.rmx_pksent

	if $rt->rt_flags & $RTF_UP
		printf "U"
	end
	if $rt->rt_flags & $RTF_GATEWAY
		printf "G"
	end
	if $rt->rt_flags & $RTF_HOST
		printf "H"
	end
	if $rt->rt_flags & $RTF_REJECT
		printf "R"
	end
	if $rt->rt_flags & $RTF_DYNAMIC
		printf "D"
	end
	if $rt->rt_flags & $RTF_MODIFIED
		printf "M"
	end
	if $rt->rt_flags & $RTF_CLONING
		printf "C"
	end
	if $rt->rt_flags & $RTF_PRCLONING
		printf "c"
	end
	if $rt->rt_flags & $RTF_LLINFO
		printf "L"
	end
	if $rt->rt_flags & $RTF_STATIC
		printf "S"
	end
	if $rt->rt_flags & $RTF_PROTO1
		printf "1"
	end
	if $rt->rt_flags & $RTF_PROTO2
		printf "2"
	end
	if $rt->rt_flags & $RTF_PROTO3
		printf "3"
	end
	if $rt->rt_flags & $RTF_WASCLONED
		printf "W"
	end
	if $rt->rt_flags & $RTF_BROADCAST
		printf "b"
	end
	if $rt->rt_flags & $RTF_MULTICAST
		printf "m"
	end
	if $rt->rt_flags & $RTF_XRESOLVE
		printf "X"
	end
	if $rt->rt_flags & $RTF_BLACKHOLE
		printf "B"
	end
	if $rt->rt_flags & $RTF_IFSCOPE
		printf "I"
	end
	if $rt->rt_flags & $RTF_CONDEMNED
		printf "Z"
	end
	if $rt->rt_flags & $RTF_IFREF
		printf "i"
	end
	if $rt->rt_flags & $RTF_PROXY
		printf "Y"
	end
	if $rt->rt_flags & $RTF_ROUTER
		printf "r"
	end

	printf "/%s%d", $rt->rt_ifp->if_name, $rt->rt_ifp->if_unit
end

set $RNF_ROOT   = 2

define _rttable_dump
	set $rnh = $arg0
	set $rn = (struct radix_node *)$rnh->rnh_treetop
	set $rnh_cnt = $rnh->rnh_cnt
		
	while $rn->rn_bit >= 0
		set $rn = $rn->rn_u.rn_node.rn_L
	end
	
	while 1
		set $base = (struct radix_node *)$rn
		while ($rn->rn_parent->rn_u.rn_node.rn_R == $rn) && ($rn->rn_flags & $RNF_ROOT) == 0
			set $rn = $rn->rn_parent
		end
		set $rn = $rn->rn_parent->rn_u.rn_node.rn_R
		while $rn->rn_bit >= 0
			set $rn = $rn->rn_u.rn_node.rn_L
		end
		set $next = $rn
		while $base != 0
			set $rn = $base
			set $base = $rn->rn_u.rn_leaf.rn_Dupedkey
			if ($rn->rn_flags & $RNF_ROOT) == 0
				
				set $rt = (struct rtentry *)$rn
				
				if $kgm_lp64
					printf "%18p ", $rt
				else
					printf "%10p ", $rt
				end
				rtentry_prdetails $rt
				printf "\n"
				
			end
		end
		set $rn = $next
		if ($rn->rn_flags & $RNF_ROOT) != 0
			loop_break
		end
	end
end


define show_rt_inet
	if $kgm_lp64
		printf " rtentry           dst             gw                parent             Refs   Use      flags/if\n"
		printf " ----------------- --------------- ----------------- ------------------ ------ -------- -----------\n"
	else
		printf " rtentry   dst             gw                parent     Refs   Use      flags/if\n"
		printf " --------- --------------- ----------------- ---------- ------ -------- -----------\n"
	end
	_rttable_dump rt_tables[2]
end

document show_rt_inet
Syntax: (gdb) show_rt_inet
| Show the entries of the IPv4 routing table.
end

define show_rt_inet6
	if $kgm_lp64
		printf " rtentry           dst                                     gw                                      parent             Refs   Use      flags/if\n"
		printf " ----------------- --------------------------------------- --------------------------------------- ------------------ ------ -------- -----------\n"
	else
		printf " rtentry   dst                                     gw                                      parent     Refs   Use      flags/if\n"
		printf " --------- --------------------------------------- --------------------------------------- ---------- ------ -------- -----------\n"
	end
	_rttable_dump rt_tables[30]
end

document show_rt_inet6
Syntax: (gdb) show_rt_inet6
| Show the entries of the IPv6 routing table.
end

define rtentry_trash
	set $rtd = (struct rtentry_dbg *)rttrash_head.tqh_first
	set $cnt = 0
	while $rtd != 0
		if $cnt == 0
		    if $kgm_lp64
				printf "                rtentry ref   hold   rele             dst    gw             parent flags/if\n"
				printf "      ----------------- --- ------ ------ --------------- ----- ------------------ -----------\n"
			else
				printf "        rtentry ref   hold   rele             dst    gw     parent flags/if\n"
				printf "      --------- --- ------ ------ --------------- ----- ---------- -----------\n"
			end
		end
		printf "%4d: %p %3d %6d %6d ", $cnt + 1, $rtd, \
		    $rtd->rtd_refhold_cnt - $rtd->rtd_refrele_cnt, \
		    $rtd->rtd_refhold_cnt, $rtd->rtd_refrele_cnt
		rtentry_prdetails $rtd
		printf "\n"
		set $rtd = $rtd->rtd_trash_link.tqe_next
		set $cnt = $cnt + 1
	end
end

document rtentry_trash
Syntax: (gdb) rtentry_trash
| Walk the list of trash route entries; this requires route entry
| debugging to be turned on, by setting the appropriate flags to the
| "rte_debug" boot-args parameter.
end

set $CTRACE_STACK_SIZE = ctrace_stack_size
set $CTRACE_HIST_SIZE = ctrace_hist_size

define rtentry_showdbg
	set $rtd = (struct rtentry_dbg *)$arg0
	set $cnt = 0

	printf "Total holds:\t%d\n", $rtd->rtd_refhold_cnt
	printf "Total releases:\t%d\n", $rtd->rtd_refrele_cnt

	set $ix = 0
	while $ix < $CTRACE_STACK_SIZE
		set $kgm_pc = $rtd->rtd_alloc.pc[$ix]
		if $kgm_pc != 0
			if $ix == 0
				printf "\nAlloc (thread %p):\n", \
				    $rtd->rtd_alloc.th
			end
			printf "%4d: ", $ix + 1
			pcprint $kgm_pc
			printf "\n"
		end
		set $ix = $ix + 1
	end
	set $ix = 0
	while $ix < $CTRACE_STACK_SIZE
		set $kgm_pc = $rtd->rtd_free.pc[$ix]
		if $kgm_pc != 0
			if $ix == 0
				printf "\nFree: (thread %p)\n", \
				    $rtd->rtd_free.th
			end
			printf "%4d: ", $ix + 1
			pcprint $kgm_pc
			printf "\n"
		end
		set $ix = $ix + 1
	end
	while $cnt < $CTRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $rtd->rtd_refhold[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nHold [%d] (thread %p):\n", \
					    $cnt, $rtd->rtd_refhold[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
	set $cnt = 0
	while $cnt < $CTRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $rtd->rtd_refrele[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nRelease [%d] (thread %p):\n",\
					    $cnt, $rtd->rtd_refrele[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end

	printf "\nTotal locks:\t%d\n", $rtd->rtd_lock_cnt
	printf "Total unlocks:\t%d\n", $rtd->rtd_unlock_cnt

	set $cnt = 0
	while $cnt < $CTRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $rtd->rtd_lock[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nLock [%d] (thread %p):\n",\
					    $cnt, $rtd->rtd_lock[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
	set $cnt = 0
	while $cnt < $CTRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $rtd->rtd_unlock[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nUnlock [%d] (thread %p):\n",\
					    $cnt, $rtd->rtd_unlock[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
end

document rtentry_showdbg
Syntax: (gdb) rtentry_showdbg <addr>
| Given a route entry structure address, print the debug information
| related to it.  This requires route entry debugging to be turned
| on, by setting the appropriate flags to the "rte_debug" boot-args
| parameter.
end

set $INIFA_TRACE_HIST_SIZE = inifa_trace_hist_size

define inifa_showdbg
	set $inifa = (struct in_ifaddr_dbg *)$arg0
	set $cnt = 0

	printf "Total holds:\t%d\n", $inifa->inifa_refhold_cnt
	printf "Total releases:\t%d\n", $inifa->inifa_refrele_cnt

	set $ix = 0
	while $ix < $CTRACE_STACK_SIZE
		set $kgm_pc = $inifa->inifa_alloc.pc[$ix]
		if $kgm_pc != 0
			if $ix == 0
				printf "\nAlloc (thread %p):\n", \
				    $inifa->inifa_alloc.th
			end
			printf "%4d: ", $ix + 1
			pcprint $kgm_pc
			printf "\n"
		end
		set $ix = $ix + 1
	end
	set $ix = 0
	while $ix < $CTRACE_STACK_SIZE
		set $kgm_pc = $inifa->inifa_free.pc[$ix]
		if $kgm_pc != 0
			if $ix == 0
				printf "\nFree: (thread %p)\n", \
				    $inifa->inifa_free.th
			end
			printf "%4d: ", $ix + 1
			pcprint $kgm_pc
			printf "\n"
		end
		set $ix = $ix + 1
	end
	while $cnt < $INIFA_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $inifa->inifa_refhold[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nHold [%d] (thread %p):\n", \
					    $cnt, $inifa->inifa_refhold[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
	set $cnt = 0
	while $cnt < $INIFA_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $inifa->inifa_refrele[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nRelease [%d] (thread %p):\n",\
					    $cnt, $inifa->inifa_refrele[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
end

document inifa_showdbg
Syntax: (gdb) inifa_showdbg <addr>
| Given an IPv4 interface structure address, print the debug information
| related to it.  This requires interface address debugging to be turned
| on, by setting the appropriate flags to the "ifa_debug" boot-args
| parameter.
end

set $IN6IFA_TRACE_HIST_SIZE = in6ifa_trace_hist_size

define in6ifa_showdbg
	set $in6ifa = (struct in6_ifaddr_dbg *)$arg0
	set $cnt = 0

	printf "Total holds:\t%d\n", $in6ifa->in6ifa_refhold_cnt
	printf "Total releases:\t%d\n", $in6ifa->in6ifa_refrele_cnt

	set $ix = 0
	while $ix < $CTRACE_STACK_SIZE
		set $kgm_pc = $in6ifa->in6ifa_alloc.pc[$ix]
		if $kgm_pc != 0
			if $ix == 0
				printf "\nAlloc (thread %p):\n", \
				    $in6ifa->in6ifa_alloc.th
			end
			printf "%4d: ", $ix + 1
			pcprint $kgm_pc
			printf "\n"
		end
		set $ix = $ix + 1
	end
	set $ix = 0
	while $ix < $CTRACE_STACK_SIZE
		set $kgm_pc = $in6ifa->in6ifa_free.pc[$ix]
		if $kgm_pc != 0
			if $ix == 0
				printf "\nFree: (thread %p)\n", \
				    $in6ifa->in6ifa_free.th
			end
			printf "%4d: ", $ix + 1
			pcprint $kgm_pc
			printf "\n"
		end
		set $ix = $ix + 1
	end
	while $cnt < $IN6IFA_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $in6ifa->in6ifa_refhold[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nHold [%d] (thread %p):\n", \
					  $cnt, $in6ifa->in6ifa_refhold[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
	set $cnt = 0
	while $cnt < $IN6IFA_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $in6ifa->in6ifa_refrele[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nRelease [%d] (thread %p):\n",\
					  $cnt, $in6ifa->in6ifa_refrele[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
end

document in6ifa_showdbg
Syntax: (gdb) in6ifa_showdbg <addr>
| Given an IPv6 interface structure address, print the debug information
| related to it.  This requires interface address debugging to be turned
| on, by setting the appropriate flags to the "ifa_debug" boot-args
| parameter.
end

set $IFMA_TRACE_HIST_SIZE = ifma_trace_hist_size

define ifma_showdbg
	set $ifma = (struct ifmultiaddr_dbg *)$arg0
	set $cnt = 0

	printf "Total holds:\t%d\n", $ifma->ifma_refhold_cnt
	printf "Total releases:\t%d\n", $ifma->ifma_refrele_cnt

	while $cnt < $IFMA_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $ifma->ifma_refhold[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nHold [%d] (thread %p):\n", \
					  $cnt, $ifma->ifma_refhold[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
	set $cnt = 0
	while $cnt < $IFMA_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $ifma->ifma_refrele[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nRelease [%d] (thread %p):\n",\
					  $cnt, $ifma->ifma_refrele[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
end

document ifma_showdbg
Syntax: (gdb) ifma_showdbg <addr>
| Given a link multicast structure address, print the debug information
| related to it.  This requires interface address debugging to be turned
| on, by setting the appropriate flags to the "ifa_debug" boot-args
| parameter.
end

set $INM_TRACE_HIST_SIZE = inm_trace_hist_size

define inm_showdbg
	set $inm = (struct in_multi_dbg *)$arg0
	set $cnt = 0

	printf "Total holds:\t%d\n", $inm->inm_refhold_cnt
	printf "Total releases:\t%d\n", $inm->inm_refrele_cnt

	while $cnt < $INM_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $inm->inm_refhold[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nHold [%d] (thread %p):\n", \
					  $cnt, $inm->inm_refhold[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
	set $cnt = 0
	while $cnt < $INM_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $inm->inm_refrele[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nRelease [%d] (thread %p):\n",\
					  $cnt, $inm->inm_refrele[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
end

document inm_showdbg
Syntax: (gdb) inm_showdbg <addr>
| Given an IPv4 multicast structure address, print the debug information
| related to it.  This requires interface address debugging to be turned
| on, by setting the appropriate flags to the "ifa_debug" boot-args
| parameter.
end

set $IF_REF_TRACE_HIST_SIZE = if_ref_trace_hist_size

define ifpref_showdbg
	set $dl_if = (struct dlil_ifnet_dbg *)$arg0
	set $cnt = 0

	printf "Total references:\t%d\n", $dl_if->dldbg_if_refhold_cnt
	printf "Total releases:\t\t%d\n", $dl_if->dldbg_if_refrele_cnt

	while $cnt < $IF_REF_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $dl_if->dldbg_if_refhold[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nHold [%d] (thread %p):\n", \
					    $cnt, \
					    $dl_if->dldbg_if_refhold[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
	set $cnt = 0
	while $cnt < $IF_REF_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $dl_if->dldbg_if_refrele[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nRelease [%d] (thread %p):\n",\
					    $cnt, \
					    $dl_if->dldbg_if_refrele[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
end

document ifpref_showdbg
Syntax: (gdb) ifpref_showdbg <addr>
| Given an ifnet structure address, print the debug information
| related to its refcnt.  This requires ifnet debugging to be turned
| on, by setting the appropriate flags to the "ifnet_debug" boot-args
| parameter.
end

define in6ifa_trash
	set $ifa = (struct in6_ifaddr_dbg *)in6ifa_trash_head.tqh_first
	set $cnt = 0
	while $ifa != 0
		if $cnt == 0
		    if $kgm_lp64
				printf "                in6_ifa ref   hold   rele\n"
				printf "      ----------------- --- ------ ------\n"
			else
				printf "        in6_ifa ref   hold   rele\n"
				printf "      --------- --- ------ ------\n"
			end
		end
		printf "%4d: %p %3d %6d %6d ", $cnt + 1, $ifa, \
		    $ifa->in6ifa_refhold_cnt - $ifa->in6ifa_refrele_cnt, \
		    $ifa->in6ifa_refhold_cnt, $ifa->in6ifa_refrele_cnt
		showsockaddr_in6 $ifa->in6ifa.ia_ifa.ifa_addr
		printf "\n"
		set $ifa = $ifa->in6ifa_trash_link.tqe_next
		set $cnt = $cnt + 1
	end
end

set $NDPR_TRACE_HIST_SIZE = ndpr_trace_hist_size

define ndpr_showdbg
	set $ndpr = (struct nd_prefix_dbg *)$arg0
	set $cnt = 0

	printf "Total references:\t%d\n", $ndpr->ndpr_refhold_cnt
	printf "Total releases:\t\t%d\n", $ndpr->ndpr_refrele_cnt

	while $cnt < $NDPR_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $ndpr->ndpr_refhold[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nHold [%d] (thread %p):\n", \
					    $cnt, \
					    $ndpr->ndpr_refhold[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
	set $cnt = 0
	while $cnt < $NDPR_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $ndpr->ndpr_refrele[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nRelease [%d] (thread %p):\n",\
					    $cnt, \
					    $ndpr->ndpr_refrele[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
end

document ndpr_showdbg
Syntax: (gdb) ndpr_showdbg <addr>
| Given a nd_prefix structure address, print the debug information
| related to its refcnt.  This requires the interface address debugging
| to be turned on, by setting the appropriate flags to the "ifa_debug"
| boot-args parameter.
end

set $NDDR_TRACE_HIST_SIZE = nddr_trace_hist_size

define nddr_showdbg
	set $nddr = (struct nd_defrouter_dbg *)$arg0
	set $cnt = 0

	printf "Total references:\t%d\n", $nddr->nddr_refhold_cnt
	printf "Total releases:\t\t%d\n", $nddr->nddr_refrele_cnt

	while $cnt < $NDDR_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $nddr->nddr_refhold[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nHold [%d] (thread %p):\n", \
					    $cnt, \
					    $nddr->nddr_refhold[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
	set $cnt = 0
	while $cnt < $NDDR_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $nddr->nddr_refrele[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nRelease [%d] (thread %p):\n",\
					    $cnt, \
					    $nddr->nddr_refrele[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
end

document nddr_showdbg
Syntax: (gdb) nddr_showdbg <addr>
| Given a nd_defrouter structure address, print the debug information
| related to its refcnt.  This requires the interface address debugging
| to be turned on, by setting the appropriate flags to the "ifa_debug"
| boot-args parameter.
end
set $IMO_TRACE_HIST_SIZE = imo_trace_hist_size

define imo_showdbg
	set $imo = (struct ip_moptions_dbg *)$arg0
	set $cnt = 0

	printf "Total references:\t%d\n", $imo->imo_refhold_cnt
	printf "Total releases:\t\t%d\n", $imo->imo_refrele_cnt

	while $cnt < $IMO_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $imo->imo_refhold[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nHold [%d] (thread %p):\n", \
					    $cnt, \
					    $imo->imo_refhold[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
	set $cnt = 0
	while $cnt < $IMO_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $imo->imo_refrele[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nRelease [%d] (thread %p):\n",\
					    $cnt, \
					    $imo->imo_refrele[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
end

document imo_showdbg
Syntax: (gdb) imo_showdbg <addr>
| Given a ip_moptions structure address, print the debug information
| related to its refcnt.  This requires the interface address debugging
| to be turned on, by setting the appropriate flags to the "ifa_debug"
| boot-args parameter.
end

set $IM6O_TRACE_HIST_SIZE = im6o_trace_hist_size

define im6o_showdbg
	set $im6o = (struct ip6_moptions_dbg *)$arg0
	set $cnt = 0

	printf "Total references:\t%d\n", $im6o->im6o_refhold_cnt
	printf "Total releases:\t\t%d\n", $im6o->im6o_refrele_cnt

	while $cnt < $IM6O_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $im6o->im6o_refhold[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nHold [%d] (thread %p):\n", \
					    $cnt, \
					    $im6o->im6o_refhold[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
	set $cnt = 0
	while $cnt < $IM6O_TRACE_HIST_SIZE
		set $ix = 0
		while $ix < $CTRACE_STACK_SIZE
			set $kgm_pc = $im6o->im6o_refrele[$cnt].pc[$ix]
			if $kgm_pc != 0
				if $ix == 0
					printf "\nRelease [%d] (thread %p):\n",\
					    $cnt, \
					    $im6o->im6o_refrele[$cnt].th
				end
				printf "%4d: ", $ix + 1
				pcprint $kgm_pc
				printf "\n"
			end
			set $ix = $ix + 1
		end
		set $cnt = $cnt + 1
	end
end

document im6o_showdbg
Syntax: (gdb) im6o_showdbg <addr>
| Given a ip6_moptions structure address, print the debug information
| related to its refcnt.  This requires the interface address debugging
| to be turned on, by setting the appropriate flags to the "ifa_debug"
| boot-args parameter.
end

document in6ifa_trash
Syntax: (gdb) in6ifa_trash
| Walk the list of trash in6_ifaddr entries; this requires interface
| address debugging to be turned on, by setting the appropriate flags
| to the "ifa_debug" boot-args parameter.
end

define inifa_trash
	set $ifa = (struct in_ifaddr_dbg *)inifa_trash_head.tqh_first
	set $cnt = 0
	while $ifa != 0
		if $cnt == 0
		    if $kgm_lp64
				printf "                 in_ifa ref   hold   rele\n"
				printf "      ----------------- --- ------ ------\n"
			else
				printf "         in_ifa ref   hold   rele\n"
				printf "      --------- --- ------ ------\n"
			end
		end
		printf "%4d: %p %3d %6d %6d ", $cnt + 1, $ifa, \
		    $ifa->inifa_refhold_cnt - $ifa->inifa_refrele_cnt, \
		    $ifa->inifa_refhold_cnt, $ifa->inifa_refrele_cnt
		showsockaddr_in $ifa->inifa.ia_ifa.ifa_addr
		printf "\n"
		set $ifa = $ifa->inifa_trash_link.tqe_next
		set $cnt = $cnt + 1
	end
end

document inifa_trash
Syntax: (gdb) inifa_trash
| Walk the list of trash in_ifaddr entries; this requires interface
| address debugging to be turned on, by setting the appropriate flags
| to the "ifa_debug" boot-args parameter.
end

define ifma_trash
	set $ifma = (struct ifmultiaddr_dbg *)ifma_trash_head.tqh_first
	set $cnt = 0
	while $ifma != 0
		if $cnt == 0
		    if $kgm_lp64
				printf "                   ifma ref   hold   rele\n"
				printf "      ----------------- --- ------ ------\n"
			else
				printf "          ifma  ref   hold   rele\n"
				printf "      --------- --- ------ ------\n"
			end
		end
		printf "%4d: %p %3d %6d %6d ", $cnt + 1, $ifma, \
		    $ifma->ifma_refhold_cnt - $ifma->ifma_refrele_cnt, \
		    $ifma->ifma_refhold_cnt, $ifma->ifma_refrele_cnt
		showsockaddr $ifma->ifma.ifma_addr
		printf " @ %s%d", $ifma->ifma.ifma_ifp->if_name, \
		    $ifma->ifma.ifma_ifp->if_unit
		printf "\n"
		set $ifma = $ifma->ifma_trash_link.tqe_next
		set $cnt = $cnt + 1
	end
end

document ifma_trash
Syntax: (gdb) ifma_trash
| Walk the list of trash ifmultiaddr entries; this requires interface
| address debugging to be turned on, by setting the appropriate flags
| to the "ifa_debug" boot-args parameter.
end

define inm_trash
	set $inm = (struct in_multi_dbg *)inm_trash_head.tqh_first
	set $cnt = 0
	while $inm != 0
		if $cnt == 0
		    if $kgm_lp64
				printf "                    inm ref   hold   rele\n"
				printf "      ----------------- --- ------ ------\n"
			else
				printf "            inm ref   hold   rele\n"
				printf "      --------- --- ------ ------\n"
			end
		end
		printf "%4d: %p %3d %6d %6d ", $cnt + 1, $inm, \
		    $inm->inm_refhold_cnt - $inm->inm_refrele_cnt, \
		    $inm->inm_refhold_cnt, $inm->inm_refrele_cnt
		show_in_addr &($inm->inm.inm_addr)
		printf "\n"
		set $inm = $inm->inm_trash_link.tqe_next
		set $cnt = $cnt + 1
	end
end

document inm_trash
Syntax: (gdb) inm_trash
| Walk the list of trash in_multi entries; this requires interface
| address debugging to be turned on, by setting the appropriate flags
| to the "ifa_debug" boot-args parameter.
end

define in6m_trash
	set $in6m = (struct in6_multi_dbg *)in6m_trash_head.tqh_first
	set $cnt = 0
	while $in6m != 0
		if $cnt == 0
		    if $kgm_lp64
				printf "                   in6m ref   hold   rele\n"
				printf "      ----------------- --- ------ ------\n"
			else
				printf "           in6m ref   hold   rele\n"
				printf "      --------- --- ------ ------\n"
			end
		end
		printf "%4d: %p %3d %6d %6d ", $cnt + 1, $in6m, \
		    $in6m->in6m_refhold_cnt - $in6m->in6m_refrele_cnt, \
		    $in6m->in6m_refhold_cnt, $in6m->in6m_refrele_cnt
		show_in_addr &($in6m->in6m.in6m_addr)
		printf "\n"
		set $in6m = $in6m->in6m_trash_link.tqe_next
		set $cnt = $cnt + 1
	end
end

document in6m_trash
Syntax: (gdb) in6m_trash
| Walk the list of trash in6_multi entries; this requires interface
| address debugging to be turned on, by setting the appropriate flags
| to the "ifa_debug" boot-args parameter.
end

#
# print all OSMalloc stats 

define ostag_print
set $kgm_tagp = (OSMallocTag)$arg0
printf "0x%08x: ", $kgm_tagp
printf "%8d ",$kgm_tagp->OSMT_refcnt
printf "%8x ",$kgm_tagp->OSMT_state
printf "%8x ",$kgm_tagp->OSMT_attr
printf "%s ",$kgm_tagp->OSMT_name
printf "\n"
end


define showosmalloc 
printf "TAG          COUNT     STATE     ATTR     NAME\n"
set $kgm_tagheadp = (struct _OSMallocTag_ *)&OSMalloc_tag_list
    set $kgm_tagptr = (struct _OSMallocTag_ * )($kgm_tagheadp->OSMT_link.next)
    while $kgm_tagptr != $kgm_tagheadp
	ostag_print $kgm_tagptr
	set $kgm_tagptr = (struct _OSMallocTag_ *)$kgm_tagptr->OSMT_link.next
    end
	printf "\n"
end
document showosmalloc
Syntax: (gdb) showosmalloc
| Print the outstanding allocation count by OSMallocTags.
end


define systemlog
    if msgbufp->msg_bufc[msgbufp->msg_bufx] == 0 \
       && msgbufp->msg_bufc[0] != 0
        # The buffer hasn't wrapped, so take the easy (and fast!) path
        printf "%s", msgbufp->msg_bufc
    else
        set $kgm_msgbuf = *msgbufp
        set $kgm_syslog_bufsize = $kgm_msgbuf.msg_size
        set $kgm_syslog_bufend = $kgm_msgbuf.msg_bufx
        if $kgm_syslog_bufend >= $kgm_syslog_bufsize
            set $kgm_syslog_bufend = 0
        end
    
        # print older messages from msg_bufx to end of buffer
        set $kgm_i = $kgm_syslog_bufend
        while $kgm_i < $kgm_syslog_bufsize
            set $kgm_syslog_char = $kgm_msgbuf.msg_bufc[$kgm_i]
            if $kgm_syslog_char == 0
                # break out of loop
                set $kgm_i = $kgm_syslog_bufsize
            else
                printf "%c", $kgm_syslog_char
            end
            set $kgm_i = $kgm_i + 1
        end
        
        # print newer messages from start of buffer to msg_bufx
        set $kgm_i = 0
        while $kgm_i < $kgm_syslog_bufend
            set $kgm_syslog_char = $kgm_msgbuf.msg_bufc[$kgm_i]
            if $kgm_syslog_char != 0
                printf "%c", $kgm_syslog_char
            end
            set $kgm_i = $kgm_i + 1
        end
    end
    printf "\n"
end
document systemlog
| Syntax: systemlog
| Display the kernel's printf ring buffer
end


define hexdump
	#set $kgm_addr = (unsigned char *)$arg0
    derefer_uint8 $kgm_addr $arg0
	set $kgm_len = $arg1
	while $kgm_len > 0
		showptr $kgm_addr
		printf ": "
		set $kgm_i = 0
		while $kgm_i < 16
			printf "%02x ", *($kgm_addr+$kgm_i)
			set $kgm_i += 1
		end
		printf " |"
		set $kgm_i = 0
		while $kgm_i < 16
			set $kgm_temp = *($kgm_addr+$kgm_i)
			if $kgm_temp < 32 || $kgm_temp >= 127
				printf "."
			else
				printf "%c", $kgm_temp
			end
			set $kgm_i += 1
		end
		printf "|\n"
		set $kgm_addr += 16
		set $kgm_len -= 16
	end
end
document hexdump
| Show the contents of memory as a hex/ASCII dump
| The following is the syntax:
| (gdb) hexdump <address> <length>
end


define printcolonhex
    if ($argc == 2)
	set $addr = $arg0
	set $count = $arg1
	set $li = 0
	while ($li < $count)
	    if ($li == 0)
            printf "%02x", (u_char)$addr[$li]
	    end
	    if ($li != 0)
            printf ":%02x", (u_char)$addr[$li]
	    end
	    set $li = $li + 1
	end
    end
end

define showsockaddr_dl
    set $sdl = (struct sockaddr_dl *)$arg0
    if ($sdl == 0)
        printf "(null)           "
    else
	    if $sdl->sdl_nlen == 0 && $sdl->sdl_alen == 0 && $sdl->sdl_slen == 0
    		printf "link#%3d         ", $sdl->sdl_index
	    else
            set $addr = $sdl->sdl_data + $sdl->sdl_nlen
    		set $count = $sdl->sdl_alen
    		printcolonhex $addr $count
	    end
    end
end

define showsockaddr_unspec
    set $sockaddr = (struct sockaddr *)$arg0
    set $addr = $sockaddr->sa_data
    set $count = $sockaddr->sa_len - 2
    printcolonhex $addr $count
end

define showsockaddr_at
    set $sockaddr = (struct sockaddr *)$arg0
    set $addr = $sockaddr->sa_data
    set $count = $sockaddr->sa_len - 2
    printcolonhex $addr $count
end

define show_in_addr
    set $ia = (unsigned char *)$arg0
    printf "%3u.%03u.%03u.%03u", $ia[0], $ia[1], $ia[2], $ia[3]
end

define showsockaddr_in
    set $sin = (struct sockaddr_in *)$arg0
    set $sa_bytes = (unsigned char *)&($sin->sin_addr)
    show_in_addr $sa_bytes
end

define show_in6_addr
    set $ia = (unsigned char *)$arg0
    printf "%2x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x", \
    	$ia[0], $ia[1], $ia[2], $ia[3], $ia[4], $ia[5], $ia[6], $ia[7], $ia[8], $ia[9], $ia[10], $ia[11], $ia[12], $ia[13], $ia[14], $ia[15]
end

define showsockaddr_in6
    set $sin6 = (struct sockaddr_in6 *)$arg0
    set $sa_bytes = $sin6->sin6_addr.__u6_addr.__u6_addr8
    show_in6_addr $sa_bytes
end

define showsockaddr_un
	set $sun = (struct sockaddr_un *)$arg0
	if $sun == 0
		printf "(null)"
	else
		if $sun->sun_path[0] == 0
			printf "\"\""
		else
			printf "%s", $sun->sun_path
		end
	end
end

define showifmultiaddrs
   set $ifp = (struct ifnet *)$arg0
   set $if_multi = (struct ifmultiaddr *)$ifp->if_multiaddrs->lh_first
   set $mymulti = $if_multi
   set $myi = 0
   while ($mymulti != 0)
	printf "%2d. %p ", $myi, $mymulti
	set $sa_family = $mymulti->ifma_addr.sa_family
	if ($sa_family == 2)
	    if ($mymulti->ifma_ll != 0)
	    	showsockaddr_dl $mymulti->ifma_ll->ifma_addr
	        printf " "
	    end
	    showsockaddr_in $mymulti->ifma_addr
	end
	if ($sa_family == 30)
	    if ($mymulti->ifma_ll != 0)
	    	showsockaddr_dl $mymulti->ifma_ll->ifma_addr
	        printf " "
	    end
	    showsockaddr_in6 $mymulti->ifma_addr
	end
 	if ($sa_family == 18)
	    showsockaddr_dl $mymulti->ifma_addr
	end
	if ($sa_family == 0)
	    showsockaddr_unspec $mymulti->ifma_addr 6
	end
	printf " [%d]", $mymulti->ifma_refcount
	printf "\n"
	set $mymulti = $mymulti->ifma_link.le_next
	set $myi = $myi + 1
   end
end

document showifmultiaddrs
Syntax showifmultiaddrs <ifp>
| show the (struct ifnet).if_multiaddrs list of multicast addresses for the given ifp
end

define showinmultiaddrs
   set $in_multi = (struct in_multi *)(in_multihead->lh_first)
   set $mymulti = $in_multi
   set $myi = 0
   while ($mymulti != 0)
	set $ifp = (struct ifnet *)$mymulti->inm_ifp
	printf "%2d. %p ", $myi, $mymulti
	show_in_addr &($mymulti->inm_addr)
	printf " (ifp %p [%s%d] ifma %p) ", $ifp, $ifp->if_name, \
	    $ifp->if_unit, $mymulti->inm_ifma
	printf "\n"
	set $mymulti = $mymulti->inm_link.le_next
	set $myi = $myi + 1
   end
end

document showinmultiaddrs
Syntax showinmultiaddrs
| show the contents of IPv4 multicast address records
end

define showin6multiaddrs
   set $in6_multi = (struct in6_multi *)(in6_multihead->lh_first)
   set $mymulti = $in6_multi
   set $myi = 0
   while ($mymulti != 0)
	set $ifp = (struct ifnet *)$mymulti->in6m_ifp
	printf "%2d. %p ", $myi, $mymulti
	show_in6_addr &($mymulti->in6m_addr)
	printf " (ifp %p [%s%d] ifma %p) ", $ifp, $ifp->if_name, \
	    $ifp->if_unit, $mymulti->in6m_ifma
	printf "\n"
	set $mymulti = $mymulti->in6m_entry.le_next
	set $myi = $myi + 1
   end
end

document showin6multiaddrs
Syntax showin6multiaddrs
| show the contents of IPv6 multicast address records
end

define showsockaddr
    set $mysock = (struct sockaddr *)$arg0
    set $showsockaddr_handled = 0
    if ($mysock == 0)
	printf "(null)"
    else
	if ($mysock->sa_family == 0)
		printf "UNSPC"
	    showsockaddr_unspec $mysock
	    set $showsockaddr_handled = 1
	end
	if ($mysock->sa_family == 1)
		printf "UNIX "
	    showsockaddr_un $mysock
	    set $showsockaddr_handled = 1
	end
	if ($mysock->sa_family == 2)
		printf "INET "
	    showsockaddr_in $mysock
	    set $showsockaddr_handled = 1
	end
	if ($mysock->sa_family == 30)
		printf "INET6 "
	    showsockaddr_in6 $mysock
	    set $showsockaddr_handled = 1
	end
	if ($mysock->sa_family == 18)
		printf "LINK "
	    showsockaddr_dl $mysock
	    set $showsockaddr_handled = 1
	end
	if ($mysock->sa_family == 16)
		printf "ATLK "
	    showsockaddr_at $mysock
	    set $showsockaddr_handled = 1
	end
	if ($showsockaddr_handled == 0)
	    printf "FAM %d ", $mysock->sa_family
	    set $addr = $mysock->sa_data
	    set $count = $mysock->sa_len
	    printcolonhex $addr $count
	end
    end
end

define showifflags
	set $flags = (u_short)$arg0
	set $first = 1
	printf "<"
	if ($flags & 0x1)
	    printf "UP"
	    set $first = 0
	end
	if ($flags & 0x2)
	    if ($first == 1)
		set $first = 0
	    else
	    	printf ","
	    end
	    printf "BROADCAST"
	end
	if ($flags & 0x4)
	    printf "DEBUG"
	end
	if ($flags & 0x8)
	    if ($first == 1)
		set $first = 0
	    else
	    	printf ","
	    end
	    printf "LOOPBACK"
	end
	if ($flags & 0x10)
	    if ($first == 1)
		set $first = 0
	    else
	    	printf ","
	    end
	    printf "POINTTOPOINT"
	end
##	if ($flags & 0x20)
##	    if ($first == 1)
#		set $first = 0
##	    else
#	    	printf ","
#	    end
#	    printf "NOTRAILERS"
#	end
	if ($flags & 0x40)
	    if ($first == 1)
		set $first = 0
	    else
	    	printf ","
	    end
	    printf "RUNNING"
	end
	if ($flags & 0x80)
	    if ($first == 1)
		set $first = 0
	    else
	    	printf ","
	    end
	    printf "NOARP"
	end
	if ($flags & 0x100)
	    if ($first == 1)
		set $first = 0
	    else
	    	printf ","
	    end
	    printf "PROMISC"
	end
	if ($flags & 0x200)
	    if ($first == 1)
		set $first = 0
	    else
	    	printf ","
	    end
	    printf "ALLMULTI"
	end
	if ($flags & 0x400)
	    if ($first == 1)
		set $first = 0
	    else
	    	printf ","
	    end
	    printf "OACTIVE"
	end
	if ($flags & 0x800)
	    if ($first == 1)
		set $first = 0
	    else
	    	printf ","
	    end
	    printf "SIMPLEX"
	end
	if ($flags & 0x1000)
	    if ($first == 1)
		set $first = 0
	    else
	    	printf ","
	    end
	    printf "LINK0"
	end
	if ($flags & 0x2000)
	    if ($first == 1)
		set $first = 0
	    else
	    	printf ","
	    end
	    printf "LINK1"
	end
	if ($flags & 0x4000)
	    if ($first == 1)
		set $first = 0
	    else
	    	printf ","
	    end
	    printf "LINK2-ALTPHYS"
	end
	if ($flags & 0x8000)
	    if ($first == 1)
		set $first = 0
	    else
	    	printf ","
	    end
	    printf "MULTICAST"
	end
	printf ">"
end

define showifaddrs
   set $ifp = (struct ifnet *)$arg0
   set $myifaddr = (struct ifaddr *)$ifp->if_addrhead->tqh_first
   set $myi = 0
   while ($myifaddr != 0)
	printf "\t%d. %p ", $myi, $myifaddr
	showsockaddr $myifaddr->ifa_addr
	printf " [%d]\n", $myifaddr->ifa_refcnt
	set $myifaddr = $myifaddr->ifa_link->tqe_next
	set $myi = $myi + 1
   end
end

document showifaddrs
Syntax: showifaddrs <ifp>
| show the (struct ifnet).if_addrhead list of addresses for the given ifp
end

define ifconfig
   set $ifconfig_all = 0
   if ($argc == 1)
	set $ifconfig_all = 1
   end
   set $ifp = (struct ifnet *)(ifnet_head->tqh_first)
   while ($ifp != 0)
	printf "%s%d: flags=%hx", $ifp->if_name, $ifp->if_unit, (u_short)$ifp->if_flags
	showifflags $ifp->if_flags
	printf " index %d", $ifp->if_index
	printf " mtu %d\n", $ifp->if_data.ifi_mtu
	printf "\t(struct ifnet *)"
    showptr $ifp
    printf "\n"
	if ($ifconfig_all == 1) 
	   showifaddrs $ifp
    end
	set $ifp = $ifp->if_link->tqe_next
   end
end
document ifconfig
Syntax: (gdb) ifconfig
| display ifconfig-like output, and print the (struct ifnet *) pointers for further inspection
end

set $DLIF_INUSE	= 0x1
set $DLIF_REUSE	= 0x2

define showifnets
	set $all = 0
	if ($argc == 1)
		set $all = 1
	end
	set $dlifp = (struct dlil_ifnet *)(dlil_ifnet_head->tqh_first)
	while ($dlifp != 0)
		set $ifp = (struct ifnet *)$dlifp
		if ($dlifp->dl_if_flags & $DLIF_REUSE)
			printf "*"
		end
		if ($dlifp->dl_if_flags & $DLIF_INUSE)
			printf "%s%d: ", $ifp->if_name, $ifp->if_unit
		else
			printf "[%s%d]: ", $ifp->if_name, $ifp->if_unit
		end
		printf "flags=%hx", (u_short)$ifp->if_flags
		showifflags $ifp->if_flags
		printf " index %d", $ifp->if_index
		printf " mtu %d\n", $ifp->if_data.ifi_mtu
		printf "\t(struct ifnet *)"
		showptr $ifp
		printf "\n"
		if ($all == 1) 
			showifaddrs $ifp
		end
		set $dlifp = $dlifp->dl_if_link->tqe_next
	end
end

document showifnets
Syntax: (gdb) showifnets
| Display ifconfig-like output for all attached and detached interfaces
end

define _show_unix_domain_socket
	set $so = (struct socket *)$arg0
	set $pcb = (struct unpcb *)$so->so_pcb
	if $pcb == 0
		printf "unpcb: (null) "
	else
		printf "unpcb: %p ", $pcb
		printf "unp_vnode: %p ", $pcb->unp_vnode
		printf "unp_conn: %p ", $pcb->unp_conn
		printf "unp_addr: "
		showsockaddr_un $pcb->unp_addr
	end
end

define _show_in_port
	set $str = (unsigned char *)$arg0
	set $port = *(unsigned short *)$arg0
	
	if (((($port & 0xff00) >> 8) == $str[0])) && ((($port & 0x00ff) == $str[1]))
		#printf "big endian "
		printf ":%d ", $port
	else
		#printf "little endian "
		printf ":%d ", (($port & 0xff00) >> 8) | (($port & 0x00ff) << 8)
	end
end

define _show_in_addr_4in6
	set $ia = (unsigned char *)$arg0
	if $ia
	    printf "%3u.%03u.%03u.%03u", $ia[0], $ia[1], $ia[2], $ia[3]
	end
end

define _show_in6_addr
	set $ia = (unsigned char *)$arg0
	if $ia
		printf "%2x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x", \
			$ia[0], $ia[1], $ia[2], $ia[3], $ia[4], $ia[5], $ia[6], $ia[7], \
			$ia[8], $ia[9], $ia[10], $ia[11], $ia[12], $ia[13], $ia[14], $ia[15]
	end
end

define _showtcpstate
	set $tp = (struct tcpcb *)$arg0
	if $tp
		if $tp->t_state == 0
			printf "CLOSED      "
		end
		if $tp->t_state == 1
			printf "LISTEN      "
		end
		if $tp->t_state == 2
			printf "SYN_SENT    "
		end
		if $tp->t_state == 3
			printf "SYN_RCVD    "
		end
		if $tp->t_state == 4
			printf "ESTABLISHED "
		end
		if $tp->t_state == 5
			printf "CLOSE_WAIT   "
		end
		if $tp->t_state == 6
			printf "FIN_WAIT_1   "
		end
		if $tp->t_state == 7
			printf "CLOSING      "
		end
		if $tp->t_state == 8
			printf "LAST_ACK     "
		end
		if $tp->t_state == 9
			printf "FIN_WAIT_2   "
		end
		if $tp->t_state == 10
			printf "TIME_WAIT    "
		end
	end
end

define _showsockprotocol
	set $so = (struct socket *)$arg0
	set $inpcb = (struct inpcb *)$so->so_pcb

	if $so->so_proto->pr_protocol == 6
		printf "TCP "
		_showtcpstate $inpcb->inp_ppcb
	end
	if $so->so_proto->pr_protocol == 17
		printf "UDP "
	end
	if $so->so_proto->pr_protocol == 1
		printf "ICMP "
	end
	if $so->so_proto->pr_protocol == 254
		printf "DIVERT "
	end
	if $so->so_proto->pr_protocol == 255
		printf "RAW "
	end
end

define _show_ipv4_socket
	set $so = (struct socket *)$arg0
	set $inpcb = (struct inpcb *)$so->so_pcb
	if $inpcb == 0
		printf "inpcb: (null) "
	else
		printf "inpcb: %p ", $inpcb
		
		_showsockprotocol $so

		_show_in_addr_4in6  &$inpcb->inp_dependladdr.inp46_local
		_show_in_port  &$inpcb->inp_lport
		printf "-> "
		_show_in_addr_4in6  &$inpcb->inp_dependfaddr.inp46_foreign
		_show_in_port &$inpcb->inp_fport
	end
end

define _show_ipv6_socket
	set $so = (struct socket *)$arg0
	set $pcb = (struct inpcb *)$so->so_pcb
	if $pcb == 0
		printf "inpcb: (null) "
	else
		printf "inpcb: %p ", $pcb

		_showsockprotocol $so

		_show_in6_addr  &$pcb->inp_dependladdr.inp6_local
		_show_in_port  &$pcb->inp_lport
		printf "-> "
		_show_in6_addr  &$pcb->inp_dependfaddr.inp6_foreign
		_show_in_port &$pcb->inp_fport
	end
end


define showsocket
	set $so = (struct socket *)$arg0
	if $so == 0
		printf "so: (null) "
	else
		printf "so: %p ", $so
		if $so && $so->so_proto && $so->so_proto->pr_domain
			set $domain = (struct  domain *) $so->so_proto->pr_domain

			printf "%s ", $domain->dom_name
			if  $domain->dom_family == 1
				_show_unix_domain_socket $so
			end
			if  $domain->dom_family == 2
				_show_ipv4_socket $so
			end
			if  $domain->dom_family == 30
				_show_ipv6_socket $so
			end
		end
	end
	printf "\n"
end
document showsocket
Syntax: (gdb) showsocket <socket_address>
| Routine to print out a socket
end

define showprocsockets
	set $pp = (struct proc *)$arg0
	set $fdp = (struct filedesc *)$pp->p_fd

	set $count = 0
	set $fpp =  (struct fileproc **)($fdp->fd_ofiles)
	set $fpo =  (char)($fdp->fd_ofileflags[0])
	while $count < $fdp->fd_nfiles
		if *$fpp
			set $fg =(struct fileglob *)((**$fpp)->f_fglob)
			if  $fg && (($fg)->fg_type == 2) 
				if $fdp->fd_ofileflags[$count] & 4
					printf "U: "
				else
					printf " "
				end
				printf "fd = %d ", $count
				if  $fg->fg_data
					showsocket  $fg->fg_data
				else
					printf "\n"
				end
			end
		end
		set $fpp = $fpp + 1
	 	set $count = $count + 1		
	end
end
document showprocsockets
Syntax: (gdb) showprocsockets <proc_address>
| Routine to print out all the open fds
| which are sockets in a process
end

define showallprocsockets
  set $basep = (struct proc  *)allproc->lh_first
  set $pp = $basep
  while $pp
	printf "============================================ \n"
	showproc $pp
	showprocsockets $pp
  	set $pp = $pp->p_list.le_next
  end
end
document showallprocsockets
Syntax: (gdb) showallprocsockets
| Routine to print out all the open fds
| which are sockets 
end

define _print_ntohs
	set $port = (unsigned short)$arg0
	set $port = (unsigned short)((($arg0 & 0xff00) >> 8) & 0xff)
	set $port |= (unsigned short)(($arg0 & 0xff) << 8)
	printf "%5d", $port
end

set $INPCB_STATE_INUSE=0x1
set $INPCB_STATE_CACHED=0x2
set $INPCB_STATE_DEAD=0x3

set $INP_RECVOPTS=0x01
set $INP_RECVRETOPTS=0x02
set $INP_RECVDSTADDR=0x04
set $INP_HDRINCL=0x08
set $INP_HIGHPORT=0x10
set $INP_LOWPORT=0x20
set $INP_ANONPORT=0x40
set $INP_RECVIF=0x80
set $INP_MTUDISC=0x100
set $INP_STRIPHDR=0x200
set $INP_RECV_ANYIF=0x400
set $INP_INADDR_ANY=0x800
set $INP_RECVTTL=0x1000
set $INP_UDP_NOCKSUM=0x2000
set $IN6P_IPV6_V6ONLY=0x008000
set $IN6P_PKTINFO=0x010000
set $IN6P_HOPLIMIT=0x020000
set $IN6P_HOPOPTS=0x040000
set $IN6P_DSTOPTS=0x080000
set $IN6P_RTHDR=0x100000
set $IN6P_RTHDRDSTOPTS=0x200000
set $IN6P_AUTOFLOWLABEL=0x800000
set $IN6P_BINDV6ONLY=0x10000000

set $INP_IPV4=0x1
set $INP_IPV6=0x2

set $IPPROTO_TCP=6
set $IPPROTO_UDP=17

define _dump_inpcb
	set $pcb = (struct inpcb *)$arg0
	if $kgm_lp64
		printf "%18p", $pcb
	else
		printf "%10p ", $pcb
	end
	if $arg1 == $IPPROTO_TCP
		printf "tcp"
	else
		if $arg1 == $IPPROTO_UDP
			printf "udp"
		else
			printf "%2d.", $arg1
		end
	end
	if ($pcb->inp_vflag & $INP_IPV4)
		printf "4 "
	end
	if ($pcb->inp_vflag & $INP_IPV6)
		printf "6 "
	end

	if ($pcb->inp_vflag & $INP_IPV4)
		printf "                        "
		_show_in_addr &$pcb->inp_dependladdr.inp46_local.ia46_addr4
	else
		_show_in6_addr &$pcb->inp_dependladdr.inp6_local
	end
	printf " "
	_print_ntohs $pcb->inp_lport
	printf " "
	if ($pcb->inp_vflag & $INP_IPV4)
		printf "                        "
		_show_in_addr &($pcb->inp_dependfaddr.inp46_foreign.ia46_addr4)
	else
		_show_in6_addr &($pcb->inp_dependfaddr.inp6_foreign)
	end
	printf " "
	_print_ntohs $pcb->inp_fport
	printf " "

	if $arg1 == $IPPROTO_TCP
		_showtcpstate $pcb->inp_ppcb
	end

#	printf "phd "
#	set $phd = $pcb->inp_phd
#	while $phd != 0
#		printf " "
#		_print_ntohs $phd->phd_port
#		set $phd = $phd->phd_hash.le_next
#	end
#	printf ", "
	if ($pcb->inp_flags & $INP_RECVOPTS)
		printf "recvopts "
	end
	if ($pcb->inp_flags & $INP_RECVRETOPTS)
		printf "recvretopts "
	end
	if ($pcb->inp_flags & $INP_RECVDSTADDR)
		printf "recvdstaddr "
	end
	if ($pcb->inp_flags & $INP_HDRINCL)
		printf "hdrincl "
	end
	if ($pcb->inp_flags & $INP_HIGHPORT)
		printf "highport "
	end
	if ($pcb->inp_flags & $INP_LOWPORT)
		printf "lowport "
	end
	if ($pcb->inp_flags & $INP_ANONPORT)
		printf "anonport "
	end
	if ($pcb->inp_flags & $INP_RECVIF)
		printf "recvif "
	end
	if ($pcb->inp_flags & $INP_MTUDISC)
		printf "mtudisc "
	end
	if ($pcb->inp_flags & $INP_STRIPHDR)
		printf "striphdr "
	end
	if ($pcb->inp_flags & $INP_RECV_ANYIF)
		printf "recv_anyif "
	end
	if ($pcb->inp_flags & $INP_INADDR_ANY)
		printf "inaddr_any "
	end
	if ($pcb->inp_flags & $INP_RECVTTL)
		printf "recvttl "
	end
	if ($pcb->inp_flags & $INP_UDP_NOCKSUM)
		printf "nocksum "
	end
	if ($pcb->inp_flags & $IN6P_IPV6_V6ONLY)
		printf "v6only "
	end
	if ($pcb->inp_flags & $IN6P_PKTINFO)
		printf "pktinfo "
	end
	if ($pcb->inp_flags & $IN6P_HOPLIMIT)
		printf "hoplimit "
	end
	if ($pcb->inp_flags & $IN6P_HOPOPTS)
		printf "hopopts "
	end
	if ($pcb->inp_flags & $IN6P_DSTOPTS)
		printf "dstopts "
	end
	if ($pcb->inp_flags & $IN6P_RTHDR)
		printf "rthdr "
	end
	if ($pcb->inp_flags & $IN6P_RTHDRDSTOPTS)
		printf "rthdrdstopts "
	end
	if ($pcb->inp_flags & $IN6P_AUTOFLOWLABEL)
		printf "autoflowlabel "
	end
	if ($pcb->inp_flags & $IN6P_BINDV6ONLY)
		printf "bindv6only "
	end
	set $so = (struct socket *)$pcb->inp_socket
	if $so != 0
		printf "[so=%p s=%ld r=%ld usecnt=%ld] ", $so, $so->so_snd.sb_cc, \
		    $so->so_rcv.sb_cc, $so->so_usecount
	end
	if ($pcb->inp_state == 0 || $pcb->inp_state == $INPCB_STATE_INUSE)
		printf "inuse, "
	else
		if ($pcb->inp_state == $INPCB_STATE_CACHED)
			printf "cached, "
		else
			if ($pcb->inp_state == $INPCB_STATE_DEAD)
				printf "dead, "
			else
				printf "unknown (%d), ", $pcb->inp_state
			end
		end
	end
end

define _dump_inpcbport
	set $ppcb = (struct inpcbport *)$arg0
	printf "%p: lport ", $ppcb
	_print_ntohs $ppcb->phd_port
end

set $UDBHASHSIZE=16

define _dump_pcbinfo
	set $snd_cc = 0
	set $snd_buf = (unsigned int)0
	set $rcv_cc = 0
	set $rcv_buf = (unsigned int)0
	set $pcbseen = 0
	set $pcbi = (struct inpcbinfo *)$arg0
	printf "lastport %d lastlow %d lasthi %d\n", \
	    $pcbi->lastport, $pcbi->lastlow, $pcbi->lasthi
	printf "active pcb count is %d\n", $pcbi->ipi_count
	set $hashsize = $pcbi->hashmask + 1
	printf "hash size is %d\n", $hashsize
	printf "hash base %p has the following inpcb(s):\n", $pcbi->hashbase
	if $kgm_lp64
		printf "pcb                prot source                          address port  destination                     address port\n"
		printf "------------------ ---- --------------------------------------- ----- --------------------------------------- -----\n"
	else
		printf "pcb        prot source                          address port  destination                     address port\n"
		printf "---------- ---- --------------------------------------- ----- --------------------------------------- -----\n"
	end
	set $i = 0
	set $hashbase = $pcbi->hashbase
	set $head = *(uintptr_t *)$hashbase
	while $i < $hashsize
		if $head != 0
			set $pcb0 = (struct inpcb *)$head
			while $pcb0  != 0
				set $pcbseen += 1
				_dump_inpcb $pcb0 $arg1
				set $so = (struct socket *)$pcb->inp_socket
				if $so != 0
					set $snd_cc += $so->so_snd.sb_cc
					set $mp = $so->so_snd.sb_mb
					while $mp
						set $snd_buf += 256
						if ($mp->m_hdr.mh_flags & 0x01)
							set $snd_buf += $mp->M_dat.MH.MH_dat.MH_ext.ext_size
						end
						set $mp = $mp->m_hdr.mh_next
					end
					set $rcv_cc += $so->so_rcv.sb_cc
					set $mp = $so->so_rcv.sb_mb
					while $mp
						set $rcv_buf += 256
						if ($mp->m_hdr.mh_flags & 0x01)
							set $rcv_buf += $mp->M_dat.MH.MH_dat.MH_ext.ext_size
						end
						set $mp = $mp->m_hdr.mh_next
					end
				end
				set $pcb0 = $pcb0->inp_hash.le_next
				printf "\n"
			end
		end
		set $i += 1
		set $hashbase += 1
		set $head = *(uintptr_t *)$hashbase
	end
	printf "total seen %ld snd_cc %ld rcv_cc %ld\n", $pcbseen, $snd_cc, $rcv_cc
	printf "total snd_buf %u rcv_buf %u \n", (unsigned int)$snd_buf, (unsigned int)$rcv_buf
	printf "port hash base is %p\n", $pcbi->porthashbase
	set $i = 0
	set $hashbase = $pcbi->porthashbase
	set $head = *(uintptr_t *)$hashbase
	while $i < $hashsize
		if $head != 0
			set $pcb0 = (struct inpcbport *)$head
			while $pcb0  != 0
				printf "\t"
				_dump_inpcbport $pcb0
				printf "\n"
				set $pcb0 = $pcb0->phd_hash.le_next
			end
		end
		set $i += 1
		set $hashbase += 1
		set $head = *(uintptr_t *)$hashbase
	end
end

set $N_TIME_WAIT_SLOTS=128

define show_tcp_timewaitslots
	set $slot = -1
	set $all = 0
	if $argc == 1
		if (int)$arg0 == -1
			set $all = 1
		else
			set $slot = (int)$arg0
		end
	end
	printf "time wait slot size %d cur_tw_slot %ld\n", $N_TIME_WAIT_SLOTS, cur_tw_slot
	set $i = 0
	while $i < $N_TIME_WAIT_SLOTS
		set $perslot = 0
		set $head = (uintptr_t *)time_wait_slots[$i]
		if $i == $slot || $slot == -1
			if $head != 0
				set $pcb0 = (struct inpcb *)$head
				while $pcb0  != 0
					set $perslot += 1
					set $pcb0 = $pcb0->inp_list.le_next
				end
			end
			printf "  slot %ld count %ld\n", $i, $perslot
		end
		if $all ||  $i == $slot
			if $head != 0
				set $pcb0 = (struct inpcb *)$head
				while $pcb0  != 0
					printf "\t"
					_dump_inpcb $pcb0 $IPPROTO_TCP
					printf "\n"
					set $pcb0 = $pcb0->inp_list.le_next
				end
			end
		end
		set $i += 1
	end
end
document show_tcp_timewaitslots
Syntax: (gdb) show_tcp_timewaitslots
| Print the list of TCP protocol control block in the TIMEWAIT state
| Pass -1 to see the list of PCB for each slot
| Pass a slot number to see information for that slot with the list of PCB
end

define show_tcp_pcbinfo
	_dump_pcbinfo &tcbinfo $IPPROTO_TCP
end
document show_tcp_pcbinfo
Syntax: (gdb) show_tcp_pcbinfo
| Print the list of TCP protocol control block information
end


define show_udp_pcbinfo
	_dump_pcbinfo &udbinfo $IPPROTO_UDP
end
document show_udp_pcbinfo
Syntax: (gdb) show_udp_pcbinfo
| Print the list of UDP protocol control block information
end

define showbpfdtab
    set $myi = 0
    while ($myi < bpf_dtab_size)
	if (bpf_dtab[$myi] != 0)
		printf "Address 0x%x, bd_next 0x%x\n", bpf_dtab[$myi], bpf_dtab[$myi]->bd_next
		print *bpf_dtab[$myi]
	end
	set $myi = $myi + 1
    end
end

define printvnodepathint_recur
	if $arg0 != 0
		if ($arg0->v_flag & 0x000001) && ($arg0->v_mount != 0)
			if $arg0->v_mount->mnt_vnodecovered != 0
				printvnodepathint_recur  $arg0->v_mount->mnt_vnodecovered $arg0->v_mount->mnt_vnodecovered->v_name
			end
		else
			printvnodepathint_recur $arg0->v_parent $arg0->v_parent->v_name
			printf "/%s", $arg1
		end
	end
end

define showvnodepath
	set $vp = (struct vnode *)$arg0
	if $vp != 0
		if ($vp->v_flag & 0x000001) && ($vp->v_mount != 0) && ($vp->v_mount->mnt_flag & 0x00004000)
			printf "/"
		else
			printvnodepathint_recur $vp $vp->v_name
		end
	end
	printf "\n"
end

document showvnodepath
Syntax: (gdb) showvnodepath <vnode>
| Prints the path for a vnode
end

define showallvols
	printf "volume    "
    showptrhdrpad
    printf "  mnt_data  "
    showptrhdrpad
    printf "  mnt_devvp "
    showptrhdrpad
    printf "  typename    mountpoint\n"
	set $kgm_vol = (mount_t) mountlist.tqh_first
	while $kgm_vol
        showptr $kgm_vol
        printf "  "
        showptr $kgm_vol->mnt_data
        printf "  "
        showptr $kgm_vol->mnt_devvp
        printf "  "
		if  ($kgm_vol->mnt_vtable->vfc_name[0] == 'h') && \
		    ($kgm_vol->mnt_vtable->vfc_name[1] == 'f') && \
		    ($kgm_vol->mnt_vtable->vfc_name[2] == 's') && \
		    ($kgm_vol->mnt_vtable->vfc_name[3] == '\0')
			set $kgm_hfsmount = \
			    (struct hfsmount *) $kgm_vol->mnt_data
			if $kgm_hfsmount->hfs_freezing_proc != 0
				printf "FROZEN hfs  "
			else
				printf "hfs         "
			end
		else
			printf "%-10s  ", $kgm_vol->mnt_vtable->vfc_name
		end
		printf "%s\n", $kgm_vol->mnt_vfsstat.f_mntonname
		
		set $kgm_vol = (mount_t) $kgm_vol->mnt_list.tqe_next
	end
end

document showallvols
Syntax: (gdb) showallvols
| Display a summary of mounted volumes
end

define showvnodeheader
	printf "vnode     "
    showptrhdrpad
    printf "  usecount  iocount  v_data    "
    showptrhdrpad
    printf "  vtype  parent    "
    showptrhdrpad    
    printf "  name\n"
end

define showvnodeint
	set $kgm_vnode = (vnode_t) $arg0
	showptr $kgm_vnode
	printf "  %8d  ", $kgm_vnode->v_usecount
	printf "%7d  ", $kgm_vnode->v_iocount
# print information about clean/dirty blocks?
	showptr $kgm_vnode->v_data
    printf "  "
	# print the vtype, using the enum tag
	set $kgm_vtype = $kgm_vnode->v_type
	if $kgm_vtype == VNON
		printf "VNON   "
	end
	if $kgm_vtype == VREG
		printf "VREG   "
	end
	if $kgm_vtype == VDIR
		printf "VDIR   "
	end
	if $kgm_vtype == VBLK
		printf "VBLK   "
	end
	if $kgm_vtype == VCHR
		printf "VCHR   "
	end
	if $kgm_vtype == VLNK
		printf "VLNK   "
	end
	if $kgm_vtype == VSOCK
		printf "VSOCK  "
	end
	if $kgm_vtype == VFIFO
		printf "VFIFO  "
	end
	if $kgm_vtype == VBAD
		printf "VBAD   "
	end
	if ($kgm_vtype < VNON) || ($kgm_vtype > VBAD)
		printf "%5d  ", $kgm_vtype
	end

	showptr $kgm_vnode->v_parent
    printf "  "
	if ($kgm_vnode->v_name != 0)
		printf "%s\n", $kgm_vnode->v_name
	else 
		# If this is HFS vnode, get name from the cnode
		if ($kgm_vnode->v_tag == 16) 
			set $kgm_cnode = (struct cnode *)$kgm_vnode->v_data
			printf "hfs: %s\n", (char *)$kgm_cnode->c_desc->cd_nameptr
		else 
			printf "\n"
		end
	end
end

define showvnode
	showvnodeheader
	showvnodeint $arg0
end

document showvnode
Syntax: (gdb) showvnode <vnode>
| Display info about one vnode
end

define showvolvnodes
	showvnodeheader
	set $kgm_vol = (mount_t) $arg0
	set $kgm_vnode = (vnode_t) $kgm_vol.mnt_vnodelist.tqh_first
	while $kgm_vnode
		showvnodeint $kgm_vnode
		set $kgm_vnode = (vnode_t) $kgm_vnode->v_mntvnodes.tqe_next
	end
end

document showvolvnodes
Syntax: (gdb) showvolvnodes <mouont_t>
| Display info about all vnodes of a given mount_t
end

define showvolbusyvnodes
	showvnodeheader
	set $kgm_vol = (mount_t) $arg0
	set $kgm_vnode = (vnode_t) $kgm_vol.mnt_vnodelist.tqh_first
	while $kgm_vnode
		if $kgm_vnode->v_iocount != 0
			showvnodeint $kgm_vnode
		end
		set $kgm_vnode = (vnode_t) $kgm_vnode->v_mntvnodes.tqe_next
	end
end

document showvolbusyvnodes
Syntax: (gdb) showvolbusyvnodes <mount_t>
| Display info about busy (iocount!=0) vnodes of a given mount_t
end

define showallbusyvnodes
	showvnodeheader
	set $kgm_vol = (mount_t) mountlist.tqh_first
	while $kgm_vol
		set $kgm_vnode = (vnode_t) $kgm_vol.mnt_vnodelist.tqh_first
		while $kgm_vnode
			if $kgm_vnode->v_iocount != 0
				showvnodeint $kgm_vnode
			end
			set $kgm_vnode = (vnode_t) $kgm_vnode->v_mntvnodes.tqe_next
		end
		set $kgm_vol = (mount_t) $kgm_vol->mnt_list.tqe_next
	end
end

document showallbusyvnodes
Syntax: (gdb) showallbusyvnodes <vnode>
| Display info about all busy (iocount!=0) vnodes
end

define showallvnodes
	showvnodeheader
	set $kgm_vol = (mount_t) mountlist.tqh_first
	while $kgm_vol
		set $kgm_vnode = (vnode_t) $kgm_vol.mnt_vnodelist.tqh_first
		while $kgm_vnode
			showvnodeint $kgm_vnode
			set $kgm_vnode = (vnode_t) $kgm_vnode->v_mntvnodes.tqe_next
		end
		set $kgm_vol = (mount_t) $kgm_vol->mnt_list.tqe_next
	end
end

document showallvnodes
Syntax: (gdb) showallvnodes
| Display info about all vnodes
end

define _showvnodelockheader
    printf "*  type   W  held by        lock type  start               end\n"
    printf "-  -----  -  -------------  ---------  ------------------  ------------------\n"
end

define _showvnodelock
    set $kgm_svl_lock = ((struct lockf *)$arg0)

    # decode flags
    set $kgm_svl_flags = $kgm_svl_lock->lf_flags
    set $kgm_svl_type = $kgm_svl_lock->lf_type
    if ($kgm_svl_flags & 0x20)
	printf "flock"
    end
    if ($kgm_svl_flags & 0x40)
	printf "posix"
    end
    if ($kgm_svl_flags & 0x80)
	printf "prov "
    end
    if ($kgm_svl_flags & 0x10)
	printf "  W  "
    else
	printf "  .  "
    end

    # POSIX file vs. advisory range locks
    if ($kgm_svl_flags & 0x40)
	set $kgm_svl_proc = (proc_t)$kgm_svl_lock->lf_id
	printf "PID %8d   ", $kgm_svl_proc->p_pid
    else
	printf "ID 0x%08x  ", $kgm_svl_lock->lf_id
    end

    # lock type
    if ($kgm_svl_type == 1)
		printf "shared     "
    else
	if ($kgm_svl_type == 3)
		printf "exclusive  "
	else
	    if ($kgm_svl_type == 2)
		printf "unlock     "
	    else
		printf "unknown    "
	    end
	end
    end

    # start and stop
    printf "0x%016x..", $kgm_svl_lock->lf_start
    printf "0x%016x  ", $kgm_svl_lock->lf_end
    printf "\n"
end
# Body of showvnodelocks, not including header
define _showvnodelocks
    set $kgm_svl_vnode = ((vnode_t)$arg0)
    set $kgm_svl_lockiter = $kgm_svl_vnode->v_lockf
    while ($kgm_svl_lockiter != 0)
	# locks that are held
    	printf "H  "
    	_showvnodelock $kgm_svl_lockiter

	# and any locks blocked by them
	set $kgm_svl_blocker = $kgm_svl_lockiter->lf_blkhd.tqh_first
	while ($kgm_svl_blocker != 0)
	    printf ">  "
	    _showvnodelock $kgm_svl_blocker
	    set $kgm_svl_blocker = $kgm_svl_blocker->lf_block.tqe_next
	end

	# and on to the next one...
    	set $kgm_svl_lockiter = $kgm_svl_lockiter->lf_next
    end
end


define showvnodelocks
    if ($argc == 1)
    	_showvnodelockheader
	_showvnodelocks $arg0
    else
    	printf "| Usage:\n|\n"
	help showvnodelocks
    end
end

document showvnodelocks
Syntax: (gdb) showvnodelocks <vnode_t>
| Given a vnodet pointer, display the list of advisory record locks for the
| referenced pvnodes
end

define showbootargs
	printf "%s\n", (char*)((boot_args*)PE_state.bootArgs).CommandLine
end

document showbootargs
Syntax: showbootargs
| Display boot arguments passed to the target kernel
end

define showbootermemorymap
        if ($kgm_mtype == $kgm_mtype_i386)
            set $kgm_voffset = 0
        else
            if ($kgm_mtype == $kgm_mtype_x86_64)
                set $kgm_voffset = 0xFFFFFF8000000000ULL
            else
                echo showbootermemorymap not supported on this architecture
            end
        end

        set $kgm_boot_args = kernelBootArgs
        set $kgm_msize = kernelBootArgs->MemoryMapDescriptorSize
        set $kgm_mcount = kernelBootArgs->MemoryMapSize / $kgm_msize
        set $kgm_i = 0
       
        printf "Type       Physical Start   Number of Pages  Virtual Start    Attributes\n"
        while $kgm_i < $kgm_mcount
	     set $kgm_mptr = (EfiMemoryRange *)((unsigned long)kernelBootArgs->MemoryMap + $kgm_voffset + $kgm_i * $kgm_msize)
#	     p/x *$kgm_mptr
	     if $kgm_mptr->Type == 0
	       printf "Reserved  "
	     end
	     if $kgm_mptr->Type == 1
	       printf "LoaderCode"
	     end
	     if $kgm_mptr->Type == 2
	       printf "LoaderData"
	     end
	     if $kgm_mptr->Type == 3
	       printf "BS_code   "
	     end
	     if $kgm_mptr->Type == 4
	       printf "BS_data   "
	     end
	     if $kgm_mptr->Type == 5
	       printf "RT_code   "
	     end
	     if $kgm_mptr->Type == 6
	       printf "RT_data   "
	     end
	     if $kgm_mptr->Type == 7
	       printf "Convention"
	     end
	     if $kgm_mptr->Type == 8
    	       printf "Unusable  "
	     end
	     if $kgm_mptr->Type == 9
               printf "ACPI_recl "
	     end
	     if $kgm_mptr->Type == 10
               printf "ACPI_NVS  "
	     end
	     if $kgm_mptr->Type == 11
               printf "MemMapIO  "
	     end
	     if $kgm_mptr->Type == 12
               printf "MemPortIO "
	     end
	     if $kgm_mptr->Type == 13
               printf "PAL_code  "
	     end
	     if $kgm_mptr->Type > 13
               printf "UNKNOWN   "
	     end

	     printf " %016llx %016llx", $kgm_mptr->PhysicalStart, $kgm_mptr->NumberOfPages
	     if $kgm_mptr->VirtualStart != 0
	       printf " %016llx", $kgm_mptr->VirtualStart
	     else
	       printf "                 "
	     end
	     printf " %016llx\n", $kgm_mptr->Attribute
	     set $kgm_i = $kgm_i + 1
       end
end

document showbootermemorymap
Syntax: (gdb) showbootermemorymap
| Prints out the phys memory map from kernelBootArgs
end


define showstacksaftertask
    set $kgm_head_taskp = &tasks
    set $kgm_taskp = (struct task *)$arg0
    set $kgm_taskp = (struct task *)$kgm_taskp->tasks.next
    while $kgm_taskp != $kgm_head_taskp
	showtaskheader
	showtaskint $kgm_taskp
	set $kgm_head_actp = &($kgm_taskp->threads)
	set $kgm_actp = (struct thread *)($kgm_taskp->threads.next)
	while $kgm_actp != $kgm_head_actp
	    showactheader
	    if ($decode_wait_events > 0)
	       showactint $kgm_actp 1
	    else
	       showactint $kgm_actp 2
	    end
	    set $kgm_actp = (struct thread *)($kgm_actp->task_threads.next)
	end
	printf "\n"
	set $kgm_taskp = (struct task *)($kgm_taskp->tasks.next)
    end
end
document showstacksaftertask
Syntax: (gdb) showstacksaftertask <task>
| Routine to print out all stacks (as in showallstacks) starting after a given task
| Useful if that gdb refuses to print a certain task's stack.
end

define showpmworkqueueint
    set $kgm_pm_workqueue = (IOPMWorkQueue *)$arg0
    set $kgm_pm_wq = &($kgm_pm_workqueue->fWorkQueue)
    set $kgm_pm_wqe = (IOServicePM *)$kgm_pm_wq->next
    while ((queue_entry_t) $kgm_pm_wqe != (queue_entry_t) $kgm_pm_wq)
        printf "service   "
        showptrhdrpad
        printf "  ps  ms  wr  name\n"
        showptr $kgm_pm_wqe->Owner
        printf "  "
        printf "%02d  ", $kgm_pm_wqe->CurrentPowerState
        printf "%02d  ", $kgm_pm_wqe->MachineState
        printf "%02d  ", $kgm_pm_wqe->WaitReason
        printf "%s\n", $kgm_pm_wqe->Name
        printf "request   "
        showptrhdrpad
        printf "  type  next      "
        showptrhdrpad
        printf "  root      "
        showptrhdrpad
        printf "  work_wait   free_wait\n"
        set $kgm_pm_rq = &($kgm_pm_wqe->RequestHead)
        set $kgm_pm_rqe = (IOPMRequest *)$kgm_pm_rq->next
        while ((queue_entry_t) $kgm_pm_rqe != (queue_entry_t) $kgm_pm_rq)
            showptr $kgm_pm_rqe
            printf "  0x%02x  ", $kgm_pm_rqe->fType
            showptr $kgm_pm_rqe->fRequestNext
            printf "  "
            showptr $kgm_pm_rqe->fRequestRoot
            printf "  0x%08x  0x%08x\n", $kgm_pm_rqe->fWorkWaitCount, $kgm_pm_rqe->fFreeWaitCount
            showptrhdrpad
            printf "            args  "
            showptr $kgm_pm_rqe->fArg0
            printf "  "
            showptr $kgm_pm_rqe->fArg1
            printf "  "
            showptr $kgm_pm_rqe->fArg2
            printf "\n"
            set $kgm_pm_rqe = (IOPMRequest *)$kgm_pm_rqe->fCommandChain.next
        end
        printf "\n"
        set $kgm_pm_wqe = (IOServicePM *)$kgm_pm_wqe->WorkChain.next
    end
end

define showpmworkqueue
    printf "IOPMWorkQueue "
    showptr gIOPMWorkQueue
    printf " length "
    printf "%u", gIOPMWorkQueue->fQueueLength
    printf "\n"
    if (gIOPMWorkQueue->fQueueLength > 0)
        showpmworkqueueint gIOPMWorkQueue
    end
end

document showpmworkqueue
Syntax: (gdb) showpmworkqueue
| Display the IOPMWorkQueue object
end

define showioservicepm
    set $kgm_iopmpriv = (IOServicePM *)$arg0
    printf "{ "
    printf "MachineState = %d (", $kgm_iopmpriv->MachineState
    if ( $kgm_iopmpriv->MachineState == 0 )
        printf "kIOPM_Finished"
    else
    if ( $kgm_iopmpriv->MachineState == 1 )
        printf "kIOPM_OurChangeTellClientsPowerDown"
    else
    if ( $kgm_iopmpriv->MachineState == 2 )
        printf "kIOPM_OurChangeTellPriorityClientsPowerDown"
    else
    if ( $kgm_iopmpriv->MachineState == 3 )
        printf "kIOPM_OurChangeNotifyInterestedDriversWillChange"
    else
    if ( $kgm_iopmpriv->MachineState == 4 )
        printf "kIOPM_OurChangeSetPowerState"
    else
    if ( $kgm_iopmpriv->MachineState == 5 )
        printf "kIOPM_OurChangeWaitForPowerSettle"
    else
    if ( $kgm_iopmpriv->MachineState == 6 )
        printf "kIOPM_OurChangeNotifyInterestedDriversDidChange"
    else
    if ( $kgm_iopmpriv->MachineState == 7 )
        printf "kIOPM_OurChangeTellCapabilityDidChange"
    else
    if ( $kgm_iopmpriv->MachineState == 8 )
        printf "kIOPM_OurChangeFinish"
    else
    if ( $kgm_iopmpriv->MachineState == 9 )
        printf "Unused_MachineState_9"
    else
    if ( $kgm_iopmpriv->MachineState == 10 )
        printf "kIOPM_ParentChangeTellPriorityClientsPowerDown"
    else
    if ( $kgm_iopmpriv->MachineState == 11 )
        printf "kIOPM_ParentChangeNotifyInterestedDriversWillChange"
    else
    if ( $kgm_iopmpriv->MachineState == 12 )
        printf "kIOPM_ParentChangeSetPowerState"
    else
    if ( $kgm_iopmpriv->MachineState == 13 )
        printf "kIOPM_ParentChangeWaitForPowerSettle"
    else
    if ( $kgm_iopmpriv->MachineState == 14)
        printf "kIOPM_ParentChangeNotifyInterestedDriversDidChange"
    else
    if ( $kgm_iopmpriv->MachineState == 15)
        printf "kIOPM_ParentChangeTellCapabilityDidChange"
    else
    if ( $kgm_iopmpriv->MachineState == 16)
        printf "kIOPM_ParentChangeAcknowledgePowerChange"
    else
    if ( $kgm_iopmpriv->MachineState == 17)
        printf "kIOPM_NotifyChildrenStart"
    else
    if ( $kgm_iopmpriv->MachineState == 18)
        printf "kIOPM_NotifyChildrenOrdered"
    else
    if ( $kgm_iopmpriv->MachineState == 19)
        printf "kIOPM_NotifyChildrenDelayed"
    else
    if ( $kgm_iopmpriv->MachineState == 20)
        printf "kIOPM_SyncTellClientsPowerDown"
    else
    if ( $kgm_iopmpriv->MachineState == 21)
        printf "kIOPM_SyncTellPriorityClientsPowerDown"
    else
    if ( $kgm_iopmpriv->MachineState == 22)
        printf "kIOPM_SyncNotifyWillChange"
    else
    if ( $kgm_iopmpriv->MachineState == 23)
        printf "kIOPM_SyncNotifyDidChange"
    else
    if ( $kgm_iopmpriv->MachineState == 24)
        printf "kIOPM_SyncTellCapabilityDidChange"
    else
    if ( $kgm_iopmpriv->MachineState == 25)
        printf "kIOPM_SyncFinish"
    else
    if ( $kgm_iopmpriv->MachineState == 26)
        printf "kIOPM_TellCapabilityChangeDone"
    else
    if ( $kgm_iopmpriv->MachineState == 27)
        printf "kIOPM_DriverThreadCallDone"
    else
        printf "Unknown_MachineState"
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
	end
	printf "), "
	
	if ( $kgm_iopmpriv->MachineState != 20 )
        printf "DriverTimer = %d, ",(unsigned int)$kgm_iopmpriv->DriverTimer
        printf "SettleTime  = %d, ",(unsigned int)$kgm_iopmpriv->SettleTimeUS
        printf "HeadNoteFlags = %08x, ",(unsigned int)$kgm_iopmpriv->HeadNoteChangeFlags
        printf "HeadNotePendingAcks = %x, ",(unsigned int)$kgm_iopmpriv->HeadNotePendingAcks
	end

    if ( $kgm_iopmpriv->DeviceOverrideEnabled != 0 )
        printf"DeviceOverrides, "
    end
	
    printf "DeviceDesire = %d, ",(unsigned int)$kgm_iopmpriv->DeviceDesire
    printf "DesiredPowerState = %d, ",(unsigned int)$kgm_iopmpriv->DesiredPowerState
    printf "PreviousRequest = %d }\n",(unsigned int)$kgm_iopmpriv->PreviousRequestPowerFlags
end

document showioservicepm
Syntax: (gdb) showioservicepm <IOServicePM pointer>
| Routine to dump the IOServicePM object
end

define showregistryentryrecursepmstate
    set $kgm_re         = (IOService *)$arg1
    set $kgm$arg0_stack = (unsigned long long) $arg2

    if ($arg3)
	set $kgm$arg0_stack = $kgm$arg0_stack | (1ULL << $kgm_reg_depth)
    else
	set $kgm$arg0_stack = $kgm$arg0_stack & ~(1ULL << $kgm_reg_depth)
    end

    dictget $kgm_re->fRegistryTable $kgm_childkey
    set $kgm$arg0_child_array = (OSArray *) $kgm_result

    if ($kgm$arg0_child_array)
	set $kgm$arg0_child_count = $kgm$arg0_child_array->count
    else
	set $kgm$arg0_child_count = 0
    end

    if ($kgm$arg0_child_count)
	set $kgm$arg0_stack = $kgm$arg0_stack | (2ULL << $kgm_reg_depth)
    else
	set $kgm$arg0_stack = $kgm$arg0_stack & ~(2ULL << $kgm_reg_depth)
    end

    indent $kgm_reg_depth $kgm$arg0_stack
    printf "+-o "

    dictget $kgm_re->fRegistryTable $kgm_namekey
    if ($kgm_result == 0)
	dictget $kgm_re->fRegistryTable gIONameKey
    end
    if ($kgm_result == 0)
	dictget $kgm_re->fPropertyTable gIOClassKey
    end

    if ($kgm_result != 0)
	printf "%s <%p>", ((OSString *)$kgm_result)->string, $kgm_re
    else
 	if (((IOService*)$kgm_re)->pwrMgt &&  ((IOService*)$kgm_re)->pwrMgt->Name)
 	    printf "%s <", ((IOService*)$kgm_re)->pwrMgt->Name
 	    showptr $kgm_re
 	    printf ">"
	else
	    printf "?? <"
 	    showptr $kgm_re
 	    printf ">"
	end
    end

    if (((IOService*)$kgm_re)->pwrMgt )
    	printf " Current Power State: %ld ", ((IOService*)$kgm_re)->pwrMgt->CurrentPowerState
    	#printf " Mach State %ld", ((IOService*)$kgm_re)->pwrMgt->MachineState
        showioservicepm ((IOService*)$kgm_re)->pwrMgt
    end
    printf "\n"
   

    # recurse
    if ($kgm$arg0_child_count != 0)

	set $kgm_reg_depth = $kgm_reg_depth + 1
	set $kgm$arg0_child_idx = 0

	while ($kgm$arg0_child_idx < $kgm$arg0_child_count)
	    set $kgm_re = $kgm$arg0_child_array->array[$kgm$arg0_child_idx++]
	    set $kgm_more_sib = ($kgm$arg0_child_idx < $kgm$arg0_child_count)
	    if $kgm_reg_depth >= $kgm_reg_depth_max + 1
	       loop_break
	    end
	    showregistryentryrecursepmstate _$arg0 $kgm_re $kgm$arg0_stack $kgm_more_sib
	end

	set $kgm_reg_depth = $kgm_reg_depth - 1
    end
end

define showregistryentryintpmstate
    if !$kgm_reg_plane
       set $kgm_reg_plane = (IORegistryPlane *) gIOServicePlane
    end

    if !$kgm_reg_plane
       printf "Please load kgmacros after KDP attaching to the target.\n"
    else
       set $kgm_namekey   = (OSSymbol *) $kgm_reg_plane->nameKey
       set $kgm_childkey  = (OSSymbol *) $kgm_reg_plane->keys[1]
       showregistryentryrecursepmstate _ $arg0 0 0
    end
end

define showregistrypmstate
#    setregistryplane gIOPowerPlane
    set $kgm_reg_depth  = 0
    set $kgm_show_props = 1
    showregistryentryintpmstate gRegistryRoot
end

document showregistrypmstate
Syntax: (gdb) showregistrypmstate
| Routine to dump the PM state of each IOPower registry entry
end

define showstacksafterthread
    set $kgm_head_taskp = &tasks
    set $kgm_actp = (struct thread *)$arg0
    set $kgm_actp = (struct thread *)($kgm_actp->task_threads.next)
    set $kgm_taskp = (struct task *)$kgm_actp->task
    while $kgm_taskp != $kgm_head_taskp
	showtaskheader
	showtaskint $kgm_taskp
	set $kgm_head_actp = &($kgm_taskp->threads)
	if $kgm_actp == 0
	    set $kgm_actp = (struct thread *)($kgm_taskp->threads.next)
	end
	while $kgm_actp != $kgm_head_actp
	    showactheader
	    if ($decode_wait_events > 0)
	       showactint $kgm_actp 1
	    else
	       showactint $kgm_actp 2
	    end
	    set $kgm_actp = (struct thread *)($kgm_actp->task_threads.next)
	end
	printf "\n"
	set $kgm_taskp = (struct task *)($kgm_taskp->tasks.next)
	set $kgm_actp = 0
    end
end

document showstacksafterthread
Syntax: (gdb) showstacksafterthread <thread>
| Routine to print out all stacks (as in showallstacks) starting after a given thread
| Useful if that gdb refuses to print a certain task's stack.
end

define kdp-reenter
       set kdp_reentry_deadline = ((unsigned) $arg0)*1000
       continue
end

document kdp-reenter
Syntax: (gdb) kdp-reenter <seconds>
| Schedules reentry into the debugger after <seconds> seconds, and resumes
| the target system.
end

define _if_present
    if (!$arg0)
        printf " not"
    end
    printf " present"
end

define showMCAstate
    if (($kgm_mtype & $kgm_mtype_x86_mask) != $kgm_mtype_x86_any)
        printf "Not available for current architecture.\n"
    else
        printf "MCA"
        _if_present mca_MCA_present
        printf ", control MSR"
        _if_present mca_control_MSR_present
        printf ", threshold status"
        _if_present mca_threshold_status_present
        printf "\n%d error banks, ", mca_error_bank_count
        printf "family code 0x%x, ", mca_family
        printf "machine-check dump state: %d\n", mca_dump_state
        set $kgm_cpu = 0
        while cpu_data_ptr[$kgm_cpu] != 0
            set $kgm_mcp = cpu_data_ptr[$kgm_cpu]->cpu_mca_state
            if $kgm_mcp
                printf "CPU %d:", $kgm_cpu
                printf " mca_mcg_ctl: 0x%016llx", $kgm_mcp->mca_mcg_ctl
                printf " mca_mcg_status: 0x%016llx\n", $kgm_mcp->mca_mcg_status.u64
                printf "bank   "
                printf "mca_mci_ctl        "
                printf "mca_mci_status     "
                printf "mca_mci_addr       "
                printf "mca_mci_misc\n"
                set $kgm_bank = 0
                while $kgm_bank < mca_error_bank_count
                    set $kgm_bp = &$kgm_mcp->mca_error_bank[$kgm_bank]
                    printf " %2d:", $kgm_bank
                    printf " 0x%016llx", $kgm_bp->mca_mci_ctl
                    printf " 0x%016llx", $kgm_bp->mca_mci_status.u64
                    printf " 0x%016llx", $kgm_bp->mca_mci_addr
                    printf " 0x%016llx\n", $kgm_bp->mca_mci_misc
                    set $kgm_bank = $kgm_bank + 1
                end
            end
            set $kgm_cpu = $kgm_cpu + 1
        end
    end
end

document showMCAstate
Syntax: showMCAstate
| Print machine-check register state after MC exception.
end

define _pt_step
    #
    # Step to lower-level page table and print attributes
    #   $kgm_pt_paddr: current page table entry physical address
    #   $kgm_pt_index: current page table entry index (0..511)
    # returns
    #   $kgm_pt_paddr: next level page table entry physical address
    #                  or null if invalid
    #   $kgm_pt_valid: 1 if $kgm_pt_paddr is valid, 0 if the walk
    #                  should be aborted
    #   $kgm_pt_large: 1 if kgm_pt_paddr is a page frame address
    #                  of a large page and not another page table entry
    # For $kgm_pt_verbose = 0: print nothing
    #                       1: print basic information
    #                       2: print basic information and hex table dump
    #
    set $kgm_entryp = $kgm_pt_paddr + 8*$kgm_pt_index
    readphysint $kgm_entryp 64 $kgm_lcpu_self
    set $entry = $kgm_readphysint_result
    if $kgm_pt_verbose >= 3
        set $kgm_pte_loop = 0
        while $kgm_pte_loop < 512
            set $kgm_pt_paddr_tmp = $kgm_pt_paddr + $kgm_pte_loop*8
            readphys64 $kgm_pt_paddr_tmp
            set $kgm_pte_loop = $kgm_pte_loop + 1
        end
    end
    set $kgm_paddr_mask = ~((0xfffULL<<52) | 0xfffULL)
    set $kgm_paddr_largemask = ~((0xfffULL<<52) | 0x1fffffULL)
    if $kgm_pt_verbose < 2
        if $entry & (0x1 << 0)
            set $kgm_pt_valid = 1
            if $entry & (0x1 << 7)
                set $kgm_pt_large = 1
                set $kgm_pt_paddr = $entry & $kgm_paddr_largemask
            else
                set $kgm_pt_large = 0
                set $kgm_pt_paddr = $entry & $kgm_paddr_mask
            end     
        else
            set $kgm_pt_valid = 0
            set $kgm_pt_large = 0
            set $kgm_pt_paddr = 0
        end
    else
        printf "0x%016llx:\n\t0x%016llx\n\t", $kgm_entryp, $entry
        if $entry & (0x1 << 0)
            printf "valid"      
            set $kgm_pt_paddr = $entry & $kgm_paddr_mask
            set $kgm_pt_valid = 1
        else
            printf "invalid"
            set $kgm_pt_paddr = 0
            set $kgm_pt_valid = 0
            # stop decoding other bits
            set $entry = 0
        end
        if $entry & (0x1 << 1)
            printf " writeable" 
        else
            printf " read-only" 
        end
        if $entry & (0x1 << 2)
            printf " user" 
        else
            printf " supervisor" 
        end
        if $entry & (0x1 << 3)
            printf " PWT" 
        end
        if $entry & (0x1 << 4)
            printf " PCD" 
        end
        if $entry & (0x1 << 5)
            printf " accessed" 
        end
        if $entry & (0x1 << 6)
            printf " dirty" 
        end
        if $entry & (0x1 << 7)
            printf " large" 
            set $kgm_pt_large = 1
        else
            set $kgm_pt_large = 0
        end
        if $entry & (0x1 << 8)
            printf " global" 
        end
        if $entry & (0x3 << 9)
            printf " avail:0x%x", ($entry >> 9) & 0x3
        end
        if $entry & (0x1ULL << 63)
            printf " noexec" 
        end
        printf "\n"
    end
end

define _pml4_walk
    set $kgm_pt_paddr = $arg0
    set $kgm_vaddr = $arg1
    set $kgm_pt_valid = $kgm_pt_paddr != 0
    set $kgm_pt_large = 0
    set $kgm_pframe_offset = 0
    if $kgm_pt_valid && cpu_64bit
        # Look up bits 47:39 of the linear address in PML4T
        set $kgm_pt_index = ($kgm_vaddr >> 39) & 0x1ffULL
        set $kgm_pframe_offset = $kgm_vaddr & 0x7fffffffffULL
        if $kgm_pt_verbose >= 2
            printf "pml4 (index %d):\n", $kgm_pt_index
        end
        _pt_step
    end
    if $kgm_pt_valid
        # Look up bits 38:30 of the linear address in PDPT
        set $kgm_pt_index = ($kgm_vaddr >> 30) & 0x1ffULL
        set $kgm_pframe_offset = $kgm_vaddr & 0x3fffffffULL
        if $kgm_pt_verbose >= 2
            printf "pdpt (index %d):\n", $kgm_pt_index
        end
        _pt_step
    end
    if $kgm_pt_valid && !$kgm_pt_large
        # Look up bits 29:21 of the linear address in PDT
        set $kgm_pt_index = ($kgm_vaddr >> 21) & 0x1ffULL
        set $kgm_pframe_offset = $kgm_vaddr & 0x1fffffULL
        if $kgm_pt_verbose >= 2
            printf "pdt (index %d):\n", $kgm_pt_index
        end
        _pt_step
    end
    if $kgm_pt_valid && !$kgm_pt_large
        # Look up bits 20:21 of the linear address in PT
        set $kgm_pt_index = ($kgm_vaddr >> 12) & 0x1ffULL
        set $kgm_pframe_offset = $kgm_vaddr & 0xfffULL
        if $kgm_pt_verbose >= 2
            printf "pt (index %d):\n", $kgm_pt_index
        end
        _pt_step
    end

    if $kgm_pt_valid
        set $kgm_paddr = $kgm_pt_paddr + $kgm_pframe_offset
        set $kgm_paddr_isvalid = 1
    else
        set $kgm_paddr = 0
        set $kgm_paddr_isvalid = 0
    end

    if $kgm_pt_verbose >= 1
        if $kgm_paddr_isvalid
            readphysint $kgm_paddr 32 $kgm_lcpu_self
            set $kgm_value = $kgm_readphysint_result
            printf "phys 0x%016llx: 0x%08x\n", $kgm_paddr, $kgm_value
        else
            printf "(no translation)\n"
        end
    end
end

define _pmap_walk_x86
    set $kgm_pmap = (pmap_t) $arg0
    _pml4_walk $kgm_pmap->pm_cr3 $arg1
end

define _pmap_walk_arm_level1_section
    set $kgm_tte_p = $arg0
    set $kgm_tte = *$kgm_tte_p
    set $kgm_vaddr = $arg1

	# Supersection or just section?
    if (($kgm_tte & 0x00040000) == 0x00040000)
        set $kgm_paddr = ($kgm_tte & 0xFF000000) | ($kgm_vaddr & 0x00FFFFFF)
        set $kgm_paddr_isvalid = 1
    else
        set $kgm_paddr = ($kgm_tte & 0xFFF00000) | ($kgm_vaddr & 0x000FFFFF)
        set $kgm_paddr_isvalid = 1
    end

    if $kgm_pt_verbose >= 2
        printf "0x%08x\n\t0x%08x\n\t", (unsigned long)$kgm_tte_p, $kgm_tte

        # bit [1:0] evaluated in _pmap_walk_arm

        # B bit 2
        set $kgm_b_bit = (($kgm_tte & 0x00000004) >> 2)

        # C bit 3
        set $kgm_c_bit = (($kgm_tte & 0x00000008) >> 3)

        # XN bit 4
        if ($kgm_tte & 0x00000010)
            printf "no-execute" 
        else
            printf "execute" 
        end

        # Domain bit [8:5] if not supersection
        if (($kgm_tte & 0x00040000) == 0x00000000)
            printf " domain(%d)", (($kgm_tte & 0x000001e0) >> 5)
        end

        # IMP bit 9
        printf " imp(%d)", (($kgm_tte & 0x00000200) >> 9) 

        # AP bit 15 and [11:10], merged to a single 3-bit value
        set $kgm_access = (($kgm_tte & 0x00000c00) >> 10) | (($kgm_tte & 0x00008000) >> 13)
        if ($kgm_access == 0x0)
            printf " noaccess"
        end
        if ($kgm_access == 0x1)
            printf " supervisor(readwrite) user(noaccess)"
        end
        if ($kgm_access == 0x2)
            printf " supervisor(readwrite) user(readonly)"
        end
        if ($kgm_access == 0x3)
            printf " supervisor(readwrite) user(readwrite)"
        end
        if ($kgm_access == 0x4)
            printf " noaccess(reserved)"
        end
        if ($kgm_access == 0x5)
            printf " supervisor(readonly) user(noaccess)"
        end
        if ($kgm_access == 0x6)
            printf " supervisor(readonly) user(readonly)"
        end
        if ($kgm_access == 0x7)
            printf " supervisor(readonly) user(readonly)"
        end

        # TEX bit [14:12]
        set $kgm_tex_bits = (($kgm_tte & 0x00007000) >> 12)

        # Print TEX, C, B all together
        printf " TEX:C:B(%d%d%d:%d:%d)", ($kgm_tex_bits & 0x4 ? 1 : 0), ($kgm_tex_bits & 0x2 ? 1 : 0), ($kgm_tex_bits & 0x1 ? 1 : 0), $kgm_c_bit, $kgm_b_bit

        # S bit 16
        if ($kgm_tte & 0x00010000)
            printf " shareable" 
        else
            printf " not-shareable" 
        end

        # nG bit 17
        if ($kgm_tte & 0x00020000)
            printf " not-global"
        else
            printf " global" 
        end

        # Supersection bit 18
        if ($kgm_tte & 0x00040000)
            printf " supersection"
        else
            printf " section" 
        end

        # NS bit 19
        if ($kgm_tte & 0x00080000)
            printf " no-secure"
        else
            printf " secure" 
        end

        printf "\n"
    end
end

define _pmap_walk_arm_level2
    set $kgm_tte_p = $arg0
    set $kgm_tte = *$kgm_tte_p
    set $kgm_vaddr = $arg1

    set $kgm_pte_pbase = (($kgm_tte & 0xFFFFFC00) - gPhysBase + gVirtBase)
    set $kgm_pte_index = ($kgm_vaddr >> 12) & 0x000000FF
    set $kgm_pte_p = &((pt_entry_t *)$kgm_pte_pbase)[$kgm_pte_index]
    set $kgm_pte = *$kgm_pte_p

    # Print first level symbolically
    if $kgm_pt_verbose >= 2
        printf "0x%08x\n\t0x%08x\n\t", (unsigned long)$kgm_tte_p, $kgm_tte

        # bit [1:0] evaluated in _pmap_walk_arm

        # NS bit 3
        if ($kgm_tte & 0x00000008)
            printf "no-secure"
        else
            printf "secure" 
        end

        # Domain bit [8:5]
        printf " domain(%d)", (($kgm_tte & 0x000001e0) >> 5)

        # IMP bit 9
        printf " imp(%d)", (($kgm_tte & 0x00000200) >> 9) 

        printf "\n"
    end

    if $kgm_pt_verbose >= 2
        printf "second-level table (index %d):\n", $kgm_pte_index
    end
    if $kgm_pt_verbose >= 3
        set $kgm_pte_loop = 0
        while $kgm_pte_loop < 256
            set $kgm_pte_p_tmp = &((pt_entry_t *)$kgm_pte_pbase)[$kgm_pte_loop]
            printf "0x%08x:\t0x%08x\n", (unsigned long)$kgm_pte_p_tmp, *$kgm_pte_p_tmp
            set $kgm_pte_loop = $kgm_pte_loop + 1
        end
    end

    if ($kgm_pte & 0x00000003)
        set $kgm_pve_p = (pv_entry_t *)($kgm_pte_pbase + 0x100*sizeof(pt_entry_t) + $kgm_pte_index*sizeof(pv_entry_t))
        if ($kgm_pve_p->shadow != 0)
            set $kgm_spte = $kgm_pve_p->shadow ^ ($kgm_vaddr & ~0xFFF)
            set $kgm_paddr = ($kgm_spte & 0xFFFFF000) | ($kgm_vaddr & 0xFFF)
            set $kgm_paddr_isvalid = 1
        else
            set $kgm_paddr = (*$kgm_pte_p & 0xFFFFF000) | ($kgm_vaddr & 0xFFF)
            set $kgm_paddr_isvalid = 1
        end
    else
        set $kgm_paddr = 0
        set $kgm_paddr_isvalid = 0
    end

    if $kgm_pt_verbose >= 2
        printf "0x%08x\n\t0x%08x\n\t", (unsigned long)$kgm_pte_p, $kgm_pte
        if (($kgm_pte & 0x00000003) == 0x00000000)
            printf "invalid" 
        else
            if (($kgm_pte & 0x00000003) == 0x00000001)
                printf "large"

                # XN bit 15
                if ($kgm_pte & 0x00008000) == 0x00008000
                    printf " no-execute"
                else
                    printf " execute"
                end
            else
                printf "small"

                # XN bit 0
                if ($kgm_pte & 0x00000001) == 0x00000001
                    printf " no-execute"
                else
                    printf " execute"
                end
            end

            # B bit 2
            set $kgm_b_bit = (($kgm_pte & 0x00000004) >> 2)

            # C bit 3
            set $kgm_c_bit = (($kgm_pte & 0x00000008) >> 3)

            # AP bit 9 and [5:4], merged to a single 3-bit value
            set $kgm_access = (($kgm_pte & 0x00000030) >> 4) | (($kgm_pte & 0x00000200) >> 7)
            if ($kgm_access == 0x0)
                printf " noaccess"
            end
            if ($kgm_access == 0x1)
                printf " supervisor(readwrite) user(noaccess)"
            end
            if ($kgm_access == 0x2)
                printf " supervisor(readwrite) user(readonly)"
            end
            if ($kgm_access == 0x3)
                printf " supervisor(readwrite) user(readwrite)"
            end
            if ($kgm_access == 0x4)
                printf " noaccess(reserved)"
            end
            if ($kgm_access == 0x5)
                printf " supervisor(readonly) user(noaccess)"
            end
            if ($kgm_access == 0x6)
                printf " supervisor(readonly) user(readonly)"
            end
            if ($kgm_access == 0x7)
                printf " supervisor(readonly) user(readonly)"
            end

            # TEX bit [14:12] for large, [8:6] for small
            if (($kgm_pte & 0x00000003) == 0x00000001)
                set $kgm_tex_bits = (($kgm_pte & 0x00007000) >> 12)
            else
                set $kgm_tex_bits = (($kgm_pte & 0x000001c0) >> 6)
            end

            # Print TEX, C, B all together
            printf " TEX:C:B(%d%d%d:%d:%d)", ($kgm_tex_bits & 0x4 ? 1 : 0), ($kgm_tex_bits & 0x2 ? 1 : 0), ($kgm_tex_bits & 0x1 ? 1 : 0), $kgm_c_bit, $kgm_b_bit

            # S bit 10
            if ($kgm_pte & 0x00000400)
                printf " shareable" 
            else
                printf " not-shareable" 
            end

            # nG bit 11
            if ($kgm_pte & 0x00000800)
                printf " not-global"
            else
                printf " global" 
            end

        end
        printf "\n"
    end
end

# See ARM ARM Section B3.3
define _pmap_walk_arm
    set $kgm_pmap = (pmap_t) $arg0
    set $kgm_vaddr = $arg1
    set $kgm_paddr = 0
    set $kgm_paddr_isvalid = 0

    # Shift by TTESHIFT (20) to get tte index
    set $kgm_tte_index = (($kgm_vaddr - $kgm_pmap->min) >> 20)
    set $kgm_tte_p = &$kgm_pmap->tte[$kgm_tte_index]
    set $kgm_tte = *$kgm_tte_p
    if $kgm_pt_verbose >= 2
        printf "first-level table (index %d):\n", $kgm_tte_index
    end
    if $kgm_pt_verbose >= 3
        set $kgm_tte_loop = 0
        while $kgm_tte_loop < 4096
            set $kgm_tte_p_tmp = &$kgm_pmap->tte[$kgm_tte_loop]
            printf "0x%08x:\t0x%08x\n", (unsigned long)$kgm_tte_p_tmp, *$kgm_tte_p_tmp
            set $kgm_tte_loop = $kgm_tte_loop + 1
        end
    end

    if (($kgm_tte & 0x00000003) == 0x00000001)
        _pmap_walk_arm_level2 $kgm_tte_p $kgm_vaddr
    else
        if (($kgm_tte & 0x00000003) == 0x00000002)
            _pmap_walk_arm_level1_section $kgm_tte_p $kgm_vaddr
        else
            set $kgm_paddr = 0
            set $kgm_paddr_isvalid = 0
            if $kgm_pt_verbose >= 2
                printf "Invalid First-Level Translation Table Entry: 0x%08x\n", $kgm_tte
            end
        end
    end

    if $kgm_pt_verbose >= 1
        if $kgm_paddr_isvalid
            readphysint $kgm_paddr 32 $kgm_lcpu_self
            set $kgm_value = $kgm_readphysint_result
            printf "phys 0x%016llx: 0x%08x\n", $kgm_paddr, $kgm_value
        else
            printf "(no translation)\n"
        end
    end
end

define pmap_walk
    if $argc != 2
        printf "pmap_walk <pmap> <vaddr>\n"
    else
        if !$kgm_pt_verbose
            set $kgm_pt_verbose = 2
        else
            if $kgm_pt_verbose > 3
                set $kgm_pt_verbose = 2
            end
        end
        if (($kgm_mtype & $kgm_mtype_x86_mask) == $kgm_mtype_x86_any)
            _pmap_walk_x86 $arg0 $arg1
        else
            if ($kgm_mtype == $kgm_mtype_arm)
                _pmap_walk_arm $arg0 $arg1
            else
                printf "Not available for current architecture.\n"
            end
        end
    end
end

document pmap_walk
Syntax: (gdb) pmap_walk <pmap> <virtual_address>
| Perform a page-table walk in <pmap> for <virtual_address>.
| Set:
|     $kgm_pt_verbose=0 for no output, $kgm_paddr will be set
|                       if $kgm_paddr_isvalid is 1
|     $kgm_pt_verbose=1 for final physical address
|     $kgm_pt_verbose=2 for dump of page table entry.
|     $kgm_pt_verbose=3 for full hex dump of page tables.
end

define pmap_vtop
    if $argc != 2
        printf "pmap_vtop <pamp> <vaddr>\n"
    else
        set $kgm_pt_verbose = 1
        if (($kgm_mtype & $kgm_mtype_x86_mask) == $kgm_mtype_x86_any)
            _pmap_walk_x86 $arg0 $arg1
        else
            if ($kgm_mtype == $kgm_mtype_arm)
                _pmap_walk_arm $arg0 $arg1
            else
                printf "Not available for current architecture.\n"
            end
        end
    end
end

document pmap_vtop
Syntax: (gdb) pmap_vtop <pmap> <virtual_address>
| For page-tables in <pmap> translate <virtual_address> to physical address.
end

define zstack
	set $index = $arg0

	if (log_records == 0)
		set $count = 0
		printf "Zone logging not enabled.  Add 'zlog=<zone name>' to boot-args.\n"
	else 
		if ($argc == 2)
			set $count = $arg1
		else
			set $count = 1
		end
	end

	while ($count)
		printf "\n--------------- "

		if (zrecords[$index].z_opcode == 1)
			printf "ALLOC  "
		else
			printf "FREE  "
		end
		showptr zrecords[$index].z_element
		printf " : index %d  :  ztime %d -------------\n", $index, zrecords[$index].z_time

		set $frame = 0

		while ($frame < 15)
			set $frame_pc = zrecords[$index].z_pc[$frame]

			if ($frame_pc == 0)
				loop_break
			end

			x/i $frame_pc
			set $frame = $frame + 1
		end

		set $index = $index + 1
		set $count = $count - 1
	end
end

document zstack
Syntax: (gdb) zstack <index> [<count>]
| Zone leak debugging: print the stack trace of log element at <index>.
| If a <count> is supplied, it prints <count> log elements starting at <index>.
|
| The suggested usage is to look at indexes below zcurrent and look for common stack traces.
| The stack trace that occurs the most is probably the cause of the leak.  Find the pc of the
| function calling into zalloc and use the countpcs kgmacro to find out how often that pc occurs in the log.
| The pc occuring in a high percentage of records is most likely the source of the leak.
|
| The findoldest kgmacro is also useful for leak debugging since it identifies the oldest record
| in the log, which may indicate the leaker.
end

define findoldest
	set $index = 0
	set $count = log_records
	set $cur_min = 2000000000
	set $cur_index = 0

	if (log_records == 0)
		printf "Zone logging not enabled.  Add 'zlog=<zone name>' to boot-args.\n"
	else

		while ($count)
			if (zrecords[$index].z_element && zrecords[$index].z_time < $cur_min)
				set $cur_index = $index
				set $cur_min = zrecords[$index].z_time
			end
	
			set $count = $count - 1
			set $index = $index + 1
		end
	
		printf "oldest record is at log index %d:\n", $cur_index
		zstack $cur_index
	end
end

document findoldest
Syntax: (gdb) findoldest
| Zone leak debugging: find and print the oldest record in the log.  Note that this command
| can take several minutes to run since it uses linear search.
|
| Once it prints a stack trace, find the pc of the caller above all the zalloc, kalloc and
| IOKit layers.  Then use the countpcs kgmacro to see how often this caller has allocated
| memory.  A caller with a high percentage of records in the log is probably the leaker.
end

define countpcs
	set $target_pc = $arg0
	set $index = 0
	set $count = log_records
	set $found = 0

	if (log_records == 0)
		printf "Zone logging not enabled.  Add 'zlog=<zone name>' to boot-args.\n"
	else

		while ($count)
			set $frame = 0
	
			if (zrecords[$index].z_element != 0)
				while ($frame < 15)
					if (zrecords[$index].z_pc[$frame] == $target_pc)
						set $found = $found + 1
						set $frame = 15
					end
		
					set $frame = $frame + 1
				end
			end
	
			set $index = $index + 1
			set $count = $count - 1
		end
	
		printf "occurred %d times in log (%d%c of records)\n", $found, ($found * 100) / zrecorded, '%'
	end
end

document countpcs
Syntax: (gdb) countpcs <pc>
| Zone leak debugging: search the log and print a count of all log entries that contain the given <pc>
| in the stack trace.  This is useful for verifying a suspected <pc> as being the source of
| the leak.  If a high percentage of the log entries contain the given <pc>, then it's most
| likely the source of the leak.  Note that this command can take several minutes to run.
end

define findelem
	set $fe_index = zcurrent
	set $fe_count = log_records
	set $fe_elem = $arg0
	set $fe_prev_op = -1

	if (log_records == 0)
		printf "Zone logging not enabled.  Add 'zlog=<zone name>' to boot-args.\n"
	end

	while ($fe_count)
		if (zrecords[$fe_index].z_element == $fe_elem)
			zstack $fe_index

			if (zrecords[$fe_index].z_opcode == $fe_prev_op)
				printf "***************   DOUBLE OP!   *********************\n"
			end

			set $fe_prev_op = zrecords[$fe_index].z_opcode
		end

		set $fe_count = $fe_count - 1
		set $fe_index = $fe_index + 1

		if ($fe_index >= log_records)
			set $fe_index = 0
		end
	end
end

document findelem
Syntax: (gdb) findelem <elem addr>
| Zone corruption debugging: search the log and print out the stack traces for all log entries that
| refer to the given zone element.  When the kernel panics due to a corrupted zone element, get the
| element address and use this macro.  This will show you the stack traces of all logged zalloc and
| zfree operations which tells you who touched the element in the recent past.  This also makes
| double-frees readily apparent.
end


# This implements a shadowing scheme in kgmacros. If the
# current user data can be accessed by simply changing kdp_pmap,
# that is used. Otherwise, we copy data into a temporary buffer
# in the kernel's address space and use that instead. Don't rely on
# kdp_pmap between invocations of map/unmap. Since the shadow
# codepath uses a manual KDP packet, request no more than 128 bytes.
# Uses $kgm_lp64 for kernel address space size, and
# $kgm_readphys_use_kdp/$kgm_readphys_force_physmap to override
# how the user pages are accessed ($kgm_readphys_force_physmap
# implies walking the user task's pagetables to get a physical
# address and then shadowing data from there using the
# physical mapping of memory).
define _map_user_data_from_task
    set $kgm_map_user_taskp = (task_t)$arg0
    set $kgm_map_user_map = $kgm_map_user_taskp->map
    set $kgm_map_user_pmap = $kgm_map_user_map->pmap
    set $kgm_map_user_task_64 = ( $kgm_map_user_taskp->taskFeatures[0] & 0x80000000)
    set $kgm_map_user_window = 0
    set $kgm_map_switch_map = 0
    
    if ($kgm_readphys_force_kdp != 0)
        set $kgm_readphys_use_kdp = 1
    else
        if ($kgm_readphys_force_physmap)
            set $kgm_readphys_use_kdp = 0
        else
            set $kgm_readphys_use_kdp = ( kdp->is_conn > 0 )
        end
    end

    if ($kgm_readphys_use_kdp)

        if $kgm_lp64
            set $kgm_map_switch_map = 1
        else
            if !$kgm_map_user_task_64
                set $kgm_map_switch_map = 1
            end
        end
    
        if ($kgm_map_switch_map)
            # switch the map safely
            set $kgm_map_user_window = $arg1
            set kdp_pmap = $kgm_map_user_pmap
        else
            # requires shadowing/copying

            # set up the manual KDP packet
            set manual_pkt.input = 0
            set manual_pkt.len = sizeof(kdp_readmem64_req_t)
            set $kgm_pkt = (kdp_readmem64_req_t *)&manual_pkt.data
            set $kgm_pkt->hdr.request = KDP_READMEM64
            set $kgm_pkt->hdr.len = sizeof(kdp_readmem64_req_t)
            set $kgm_pkt->hdr.is_reply = 0
            set $kgm_pkt->hdr.seq = 0
            set $kgm_pkt->hdr.key = 0
            set $kgm_pkt->address = (uint64_t)$arg1
            set $kgm_pkt->nbytes = (uint32_t)$arg2

            set kdp_pmap = $kgm_map_user_pmap
            set manual_pkt.input = 1
            # dummy to make sure manual packet is executed
            set $kgm_dummy = &_mh_execute_header
            # Go back to kernel map so that we can access buffer directly
            set kdp_pmap = 0

            set $kgm_pkt = (kdp_readmem64_reply_t *)&manual_pkt.data
            if ($kgm_pkt->error == 0)
                set $kgm_map_user_window = $kgm_pkt->data
            else
                set $kgm_map_user_window = 0
            end
        end

    else
        # without the benefit of a KDP stub on the target, try to
        # find the user task's physical mapping and memcpy the data.
        # If it straddles a page boundary, copy in two passes
        set $kgm_vaddr_range1_start = (unsigned long long)$arg1
        set $kgm_vaddr_range1_count = (unsigned long long)$arg2
        if (($kgm_vaddr_range1_start + $kgm_vaddr_range1_count) & 0xFFF) < $kgm_vaddr_range1_count
            set $kgm_vaddr_range2_start = ($kgm_vaddr_range1_start + $kgm_vaddr_range1_count) & ~((unsigned long long)0xFFF)
            set $kgm_vaddr_range2_count = $kgm_vaddr_range1_start + $kgm_vaddr_range1_count - $kgm_vaddr_range2_start
            set $kgm_vaddr_range1_count = $kgm_vaddr_range2_start - $kgm_vaddr_range1_start
        else
            set $kgm_vaddr_range2_start = 0
            set $kgm_vaddr_range2_count = 0
        end
        set $kgm_paddr_range1_in_kva = 0
        set $kgm_paddr_range2_in_kva = 0

        if ($kgm_mtype == $kgm_mtype_x86_64)
            set $kgm_pt_verbose = 0
            _pmap_walk_x86 $kgm_map_user_pmap $kgm_vaddr_range1_start
            if $kgm_paddr_isvalid
                set $kgm_paddr_range1_in_kva = $kgm_paddr + physmap_base
            end
            if $kgm_vaddr_range2_start
                _pmap_walk_x86 $kgm_map_user_pmap $kgm_vaddr_range2_start
                if $kgm_paddr_isvalid
                    set $kgm_paddr_range2_in_kva = $kgm_paddr + physmap_base
                end
            end
        else
            if ($kgm_mtype == $kgm_mtype_arm)
                set $kgm_pt_verbose = 0
                _pmap_walk_arm $kgm_map_user_pmap $kgm_vaddr_range1_start
                if $kgm_paddr_isvalid
                   set $kgm_paddr_range1_in_kva = $kgm_paddr - gPhysBase + gVirtBase
                end
                if $kgm_vaddr_range2_start
                    _pmap_walk_arm $kgm_map_user_pmap $kgm_vaddr_range2_start
                    if $kgm_paddr_isvalid
                        set $kgm_paddr_range2_in_kva = $kgm_paddr - gPhysBase + gVirtBase
                    end
                end
            else
                printf "Not available for current architecture.\n"
                set $kgm_paddr_isvalid = 0
            end
        end
        if $kgm_paddr_range1_in_kva
            set $kgm_pkt = (kdp_readmem64_reply_t *)&manual_pkt.data
            memcpy $kgm_pkt->data $kgm_paddr_range1_in_kva $kgm_vaddr_range1_count
            if $kgm_paddr_range2_in_kva
                memcpy &$kgm_pkt->data[$kgm_vaddr_range1_count] $kgm_paddr_range2_in_kva $kgm_vaddr_range2_count
            end
            set $kgm_map_user_window  = $kgm_pkt->data
        else
            set $kgm_map_user_window  = 0
        end
    end
end

define _unmap_user_data_from_task
    set kdp_pmap = 0
end

# uses $kgm_taskp. Maps 32 bytes at a time and prints it
define _print_path_for_image
    set $kgm_print_path_address = (unsigned long long)$arg0
    set $kgm_path_str_notdone = 1

    if ($kgm_print_path_address == 0)
       set $kgm_path_str_notdone = 0
    end
    
    while $kgm_path_str_notdone
        _map_user_data_from_task $kgm_taskp $kgm_print_path_address 32

        set $kgm_print_path_ptr = (char *)$kgm_map_user_window
        set $kgm_path_i = 0
        while ($kgm_path_i < 32 && $kgm_print_path_ptr[$kgm_path_i] != '\0')
            set $kgm_path_i = $kgm_path_i + 1
        end
        printf "%.32s", $kgm_print_path_ptr
        
        _unmap_user_data_from_task $kgm_taskp
        
        # break out if we terminated on NUL
        if $kgm_path_i < 32
            set $kgm_path_str_notdone = 0
        else
            set $kgm_print_path_address = $kgm_print_path_address + 32
        end
    end
end

# uses $kgm_taskp and $kgm_task_64. May modify $kgm_dyld_load_path
define _print_image_info
    set $kgm_mh_image_address = (unsigned long long)$arg0
    set $kgm_mh_path_address = (unsigned long long)$arg1

    # 32 bytes enough for mach_header/mach_header_64
    _map_user_data_from_task $kgm_taskp $kgm_mh_image_address 32

    set $kgm_mh_ptr = (unsigned int*)$kgm_map_user_window
    set $kgm_mh_magic = $kgm_mh_ptr[0]
    set $kgm_mh_cputype = $kgm_mh_ptr[1]
    set $kgm_mh_cpusubtype = $kgm_mh_ptr[2]
    set $kgm_mh_filetype = $kgm_mh_ptr[3]
    set $kgm_mh_ncmds = $kgm_mh_ptr[4]
    set $kgm_mh_sizeofcmds = $kgm_mh_ptr[5]
    set $kgm_mh_flags = $kgm_mh_ptr[6]

    _unmap_user_data_from_task $kgm_taskp

    if $kgm_mh_magic == 0xfeedfacf
        set $kgm_mh_64 = 1
        set $kgm_lc_address = $kgm_mh_image_address + 32
    else
        set $kgm_mh_64 = 0
        set $kgm_lc_address = $kgm_mh_image_address + 28
    end
    
    set $kgm_lc_idx = 0
    set $kgm_uuid_data = 0
    while $kgm_lc_idx < $kgm_mh_ncmds
        
        # 24 bytes is size of uuid_command
        _map_user_data_from_task $kgm_taskp $kgm_lc_address 24
    
        set $kgm_lc_ptr = (unsigned int *)$kgm_map_user_window
        set $kgm_lc_cmd = $kgm_lc_ptr[0]
        set $kgm_lc_cmd_size = $kgm_lc_ptr[1]
        set $kgm_lc_data = (unsigned char *)$kgm_lc_ptr + 8

        if $kgm_lc_cmd == 0x1b
            set $kgm_uuid_data = $kgm_lc_data
            if $kgm_mh_64
                printf "0x%016llx  ", $kgm_mh_image_address
            else
                printf "0x%08x  ", $kgm_mh_image_address				
            end
            
            set $kgm_printed_type = 0
            if $kgm_mh_filetype == 0x2
                printf "MH_EXECUTE   "
                set $kgm_printed_type = 1
            end
            if $kgm_mh_filetype == 0x6
                printf "MH_DYLIB     "
                set $kgm_printed_type = 1
            end
            if $kgm_mh_filetype == 0x7
                printf "MH_DYLINKER  "
                set $kgm_printed_type = 1
            end
            if $kgm_mh_filetype == 0x8
                printf "MH_BUNDLE    "
                set $kgm_printed_type = 1
            end
            if !$kgm_printed_type
                printf "UNKNOWN      "            
            end
            printf "%02.2X%02.2X%02.2X%02.2X-", $kgm_uuid_data[0], $kgm_uuid_data[1], $kgm_uuid_data[2], $kgm_uuid_data[3]
            printf "%02.2X%02.2X-", $kgm_uuid_data[4], $kgm_uuid_data[5]
            printf "%02.2X%02.2X-", $kgm_uuid_data[6], $kgm_uuid_data[7]
            printf "%02.2X%02.2X-", $kgm_uuid_data[8], $kgm_uuid_data[9]
            printf "%02.2X%02.2X%02.2X%02.2X%02.2X%02.2X", $kgm_uuid_data[10], $kgm_uuid_data[11], $kgm_uuid_data[12], $kgm_uuid_data[13], $kgm_uuid_data[14], $kgm_uuid_data[15]

            _unmap_user_data_from_task $kgm_taskp

            printf "  "
            _print_path_for_image $kgm_mh_path_address
            printf "\n"

            loop_break
        else
            if $kgm_lc_cmd == 0xe
                set $kgm_load_dylinker_data = $kgm_lc_data
                set $kgm_dyld_load_path = $kgm_lc_address + *((unsigned int *)$kgm_load_dylinker_data)
            end
            _unmap_user_data_from_task $kgm_taskp
        end

        set $kgm_lc_address = $kgm_lc_address + $kgm_lc_cmd_size
        set $kgm_lc_idx = $kgm_lc_idx + 1
    end
    
    if (!$kgm_uuid_data)
            # didn't find LC_UUID, for a dylib, just print out basic info
            if $kgm_mh_64
                printf "0x%016llx  ", $kgm_mh_image_address
            else
                printf "0x%08x  ", $kgm_mh_image_address                          
            end
            set $kgm_printed_type = 0
            if $kgm_mh_filetype == 0x2
                printf "MH_EXECUTE   "
                set $kgm_printed_type = 1
            end
            if $kgm_mh_filetype == 0x6
                printf "MH_DYLIB     "
                set $kgm_printed_type = 1
            end
            if $kgm_mh_filetype == 0x7
                printf "MH_DYLINKER  "
                set $kgm_printed_type = 1
            end
            if $kgm_mh_filetype == 0x8
                printf "MH_BUNDLE    "
                set $kgm_printed_type = 1
            end
            if !$kgm_printed_type
                printf "UNKNOWN      "            
            end
        printf "                                    ",

        printf "  "
        _print_path_for_image $kgm_mh_path_address
        printf "\n"

    end
    
end

define _print_images_for_dyld_image_info
    set $kgm_taskp = $arg0
    set $kgm_task_64 = $arg1
    set $kgm_dyld_all_image_infos_address = (unsigned long long)$arg2

    _map_user_data_from_task $kgm_taskp $kgm_dyld_all_image_infos_address 112

    set $kgm_dyld_all_image_infos = (unsigned int *)$kgm_map_user_window    
    set $kgm_dyld_all_image_infos_version = $kgm_dyld_all_image_infos[0]
    if ($kgm_dyld_all_image_infos_version > 12)
        printf "Unknown dyld all_image_infos version number %d\n", $kgm_dyld_all_image_infos_version
    end
    set $kgm_image_info_count = $kgm_dyld_all_image_infos[1]

    set $kgm_dyld_load_path = 0    
    if $kgm_task_64
        set $kgm_image_info_size = 24
        set $kgm_image_info_array_address = ((unsigned long long *)$kgm_dyld_all_image_infos)[1]
        set $kgm_dyld_load_address = ((unsigned long long *)$kgm_dyld_all_image_infos)[4]
        set $kgm_dyld_all_image_infos_address_from_struct = ((unsigned long long *)$kgm_dyld_all_image_infos)[13]
    else
        set $kgm_image_info_size = 12
        set $kgm_image_info_array_address = ((unsigned int *)$kgm_dyld_all_image_infos)[2]
        set $kgm_dyld_load_address = ((unsigned int *)$kgm_dyld_all_image_infos)[5]
        set $kgm_dyld_all_image_infos_address_from_struct = ((unsigned int *)$kgm_dyld_all_image_infos)[14]
    end

    _unmap_user_data_from_task $kgm_taskp

    # Account for ASLR slide before dyld can fix the structure
    set $kgm_dyld_load_address = $kgm_dyld_load_address + ($kgm_dyld_all_image_infos_address - $kgm_dyld_all_image_infos_address_from_struct)

    set $kgm_image_info_i = 0
    while $kgm_image_info_i < $kgm_image_info_count

        set $kgm_image_info_address = $kgm_image_info_array_address + $kgm_image_info_size*$kgm_image_info_i

        _map_user_data_from_task $kgm_taskp $kgm_image_info_address $kgm_image_info_size
        if $kgm_task_64
            set $kgm_image_info_addr = ((unsigned long long *)$kgm_map_user_window)[0]
            set $kgm_image_info_path = ((unsigned long long *)$kgm_map_user_window)[1]
        else
            set $kgm_image_info_addr = ((unsigned int *)$kgm_map_user_window)[0]
            set $kgm_image_info_path = ((unsigned int *)$kgm_map_user_window)[1]
        end
        _unmap_user_data_from_task $kgm_taskp
 
        # printf "[%d] = image address %llx path address %llx\n", $kgm_image_info_i, $kgm_image_info_addr, $kgm_image_info_path
        _print_image_info $kgm_image_info_addr $kgm_image_info_path

        set $kgm_image_info_i = $kgm_image_info_i + 1
    end

    # $kgm_dyld_load_path may get set when the main executable is processed
    # printf "[dyld] = image address %llx path address %llx\n", $kgm_dyld_load_address, $kgm_dyld_load_path
    _print_image_info $kgm_dyld_load_address $kgm_dyld_load_path

end

define showuserlibraries
	set $kgm_taskp = (task_t)$arg0
	set $kgm_dyld_image_info = $kgm_taskp->all_image_info_addr

	set $kgm_map = $kgm_taskp->map
	set $kgm_task_64 = ( $kgm_taskp->taskFeatures[0] & 0x80000000)

	if ($kgm_dyld_image_info != 0)
		printf "address   "
		if $kgm_task_64
			printf "        "
		end
		printf "  type       "
		printf "  uuid                                  "
		printf "path\n"

		_print_images_for_dyld_image_info $kgm_taskp $kgm_task_64 $kgm_dyld_image_info
	else
		printf "No dyld shared library information available for task\n"
	end
end
document showuserlibraries
Syntax: (gdb) showuserlibraries <task_t>
| For a given user task, inspect the dyld shared library state and print 
| information about all Mach-O images.
end

define showuserdyldinfo
	set $kgm_taskp = (task_t)$arg0
	set $kgm_dyld_all_image_infos_address = (unsigned long long)$kgm_taskp->all_image_info_addr

	set $kgm_map = $kgm_taskp->map
	set $kgm_task_64 = ( $kgm_taskp->taskFeatures[0] & 0x80000000)

	if ($kgm_dyld_all_image_infos_address != 0)

	   _map_user_data_from_task $kgm_taskp $kgm_dyld_all_image_infos_address 112

	   set $kgm_dyld_all_image_infos = (unsigned char *)$kgm_map_user_window
	   set $kgm_dyld_all_image_infos_version = ((unsigned int *)$kgm_dyld_all_image_infos)[0]
	   if ($kgm_dyld_all_image_infos_version > 12)
		  printf "Unknown dyld all_image_infos version number %d\n", $kgm_dyld_all_image_infos_version
	   end

	   # Find fields by byte offset. We assume at least version 9 is supported
	   if $kgm_task_64
		  set $kgm_dyld_all_image_infos_infoArrayCount = *(unsigned int *)(&$kgm_dyld_all_image_infos[4])
		  set $kgm_dyld_all_image_infos_infoArray = *(unsigned long long *)(&$kgm_dyld_all_image_infos[8])
		  set $kgm_dyld_all_image_infos_notification = *(unsigned long long *)(&$kgm_dyld_all_image_infos[16])
		  set $kgm_dyld_all_image_infos_processDetachedFromSharedRegion = *(unsigned char *)(&$kgm_dyld_all_image_infos[24])
		  set $kgm_dyld_all_image_infos_libSystemInitialized = *(unsigned char *)(&$kgm_dyld_all_image_infos[25])
		  set $kgm_dyld_all_image_infos_dyldImageLoadAddress = *(unsigned long long *)(&$kgm_dyld_all_image_infos[32])
		  set $kgm_dyld_all_image_infos_jitInfo = *(unsigned long long *)(&$kgm_dyld_all_image_infos[40])
		  set $kgm_dyld_all_image_infos_dyldVersion = *(unsigned long long *)(&$kgm_dyld_all_image_infos[48])
		  set $kgm_dyld_all_image_infos_errorMessage = *(unsigned long long *)(&$kgm_dyld_all_image_infos[56])
		  set $kgm_dyld_all_image_infos_terminationFlags = *(unsigned long long *)(&$kgm_dyld_all_image_infos[64])
		  set $kgm_dyld_all_image_infos_coreSymbolicationShmPage = *(unsigned long long *)(&$kgm_dyld_all_image_infos[72])
		  set $kgm_dyld_all_image_infos_systemOrderFlag = *(unsigned long long *)(&$kgm_dyld_all_image_infos[80])
		  set $kgm_dyld_all_image_infos_uuidArrayCount = *(unsigned long long *)(&$kgm_dyld_all_image_infos[88])
		  set $kgm_dyld_all_image_infos_uuidArray = *(unsigned long long *)(&$kgm_dyld_all_image_infos[96])
		  set $kgm_dyld_all_image_infos_dyldAllImageInfosAddress = *(unsigned long long *)(&$kgm_dyld_all_image_infos[104])
	   else
		  set $kgm_dyld_all_image_infos_infoArrayCount = *(unsigned int *)(&$kgm_dyld_all_image_infos[4])
		  set $kgm_dyld_all_image_infos_infoArray = *(unsigned int *)(&$kgm_dyld_all_image_infos[8])
		  set $kgm_dyld_all_image_infos_notification = *(unsigned int *)(&$kgm_dyld_all_image_infos[12])
		  set $kgm_dyld_all_image_infos_processDetachedFromSharedRegion = *(unsigned char *)(&$kgm_dyld_all_image_infos[16])
		  set $kgm_dyld_all_image_infos_libSystemInitialized = *(unsigned char *)(&$kgm_dyld_all_image_infos[17])
		  set $kgm_dyld_all_image_infos_dyldImageLoadAddress = *(unsigned int *)(&$kgm_dyld_all_image_infos[20])
		  set $kgm_dyld_all_image_infos_jitInfo = *(unsigned int *)(&$kgm_dyld_all_image_infos[24])
		  set $kgm_dyld_all_image_infos_dyldVersion = *(unsigned int *)(&$kgm_dyld_all_image_infos[28])
		  set $kgm_dyld_all_image_infos_errorMessage = *(unsigned int *)(&$kgm_dyld_all_image_infos[32])
		  set $kgm_dyld_all_image_infos_terminationFlags = *(unsigned int *)(&$kgm_dyld_all_image_infos[36])
		  set $kgm_dyld_all_image_infos_coreSymbolicationShmPage = *(unsigned int *)(&$kgm_dyld_all_image_infos[40])
		  set $kgm_dyld_all_image_infos_systemOrderFlag = *(unsigned int *)(&$kgm_dyld_all_image_infos[44])
		  set $kgm_dyld_all_image_infos_uuidArrayCount = *(unsigned int *)(&$kgm_dyld_all_image_infos[48])
		  set $kgm_dyld_all_image_infos_uuidArray = *(unsigned int *)(&$kgm_dyld_all_image_infos[52])
		  set $kgm_dyld_all_image_infos_dyldAllImageInfosAddress = *(unsigned int *)(&$kgm_dyld_all_image_infos[56])
	   end

	   _unmap_user_data_from_task $kgm_taskp

	   set $kgm_dyld_all_imfo_infos_slide = ( $kgm_dyld_all_image_infos_address - $kgm_dyld_all_image_infos_dyldAllImageInfosAddress )
	   set $kgm_dyld_all_image_infos_dyldVersion_postslide = ( $kgm_dyld_all_image_infos_dyldVersion + $kgm_dyld_all_imfo_infos_slide )

	   printf "                        version %u\n", $kgm_dyld_all_image_infos_version
	   printf "                 infoArrayCount %u\n", $kgm_dyld_all_image_infos_infoArrayCount
	   printf "                      infoArray "
	   showuserptr $kgm_dyld_all_image_infos_infoArray
	   printf "\n"
	   printf "                   notification "
	   showuserptr $kgm_dyld_all_image_infos_notification
	   printf "\n"
	   printf "processDetachedFromSharedRegion %d\n", $kgm_dyld_all_image_infos_processDetachedFromSharedRegion
	   printf "           libSystemInitialized %d\n", $kgm_dyld_all_image_infos_libSystemInitialized
	   printf "           dyldImageLoadAddress "
	   showuserptr $kgm_dyld_all_image_infos_dyldImageLoadAddress
	   printf "\n"
	   printf "                        jitInfo "
	   showuserptr $kgm_dyld_all_image_infos_jitInfo
	   printf "\n"
	   printf "                    dyldVersion "
	   showuserptr $kgm_dyld_all_image_infos_dyldVersion
	   printf "\n"
	   printf "                                "
	   _print_path_for_image $kgm_dyld_all_image_infos_dyldVersion_postslide
	   if ($kgm_dyld_all_imfo_infos_slide != 0)
		  printf " (currently "
		  showuserptr $kgm_dyld_all_image_infos_dyldVersion_postslide
		  printf ")"
	   end
	   printf "\n"

	   printf "                   errorMessage "
	   showuserptr $kgm_dyld_all_image_infos_errorMessage
	   printf "\n"
	   if $kgm_dyld_all_image_infos_errorMessage != 0
		  printf "                                "
		  _print_path_for_image $kgm_dyld_all_image_infos_errorMessage
		  printf "\n"
	   end

	   printf "               terminationFlags "
	   showuserptr $kgm_dyld_all_image_infos_terminationFlags
	   printf "\n"
	   printf "       coreSymbolicationShmPage "
	   showuserptr $kgm_dyld_all_image_infos_coreSymbolicationShmPage
	   printf "\n"
	   printf "                systemOrderFlag "
	   showuserptr $kgm_dyld_all_image_infos_systemOrderFlag
	   printf "\n"
	   printf "                 uuidArrayCount "
	   showuserptr $kgm_dyld_all_image_infos_uuidArrayCount
	   printf "\n"
	   printf "                      uuidArray "
	   showuserptr $kgm_dyld_all_image_infos_uuidArray
	   printf "\n"
	   printf "       dyldAllImageInfosAddress "
	   showuserptr $kgm_dyld_all_image_infos_dyldAllImageInfosAddress
	   printf "\n"
	   printf "                                (currently "
	   showuserptr $kgm_dyld_all_image_infos_address
	   printf ")\n"

	   if $kgm_task_64
		  set $kgm_dyld_all_image_infos_address = $kgm_dyld_all_image_infos_address + 112
		  _map_user_data_from_task $kgm_taskp $kgm_dyld_all_image_infos_address 64
		  set $kgm_dyld_all_image_infos_v10 = (unsigned char *)$kgm_map_user_window
		  set $kgm_dyld_all_image_infos_initialImageCount = *(unsigned long long *)(&$kgm_dyld_all_image_infos_v10[112-112])
		  set $kgm_dyld_all_image_infos_errorKind = *(unsigned long long *)(&$kgm_dyld_all_image_infos_v10[120-112])
		  set $kgm_dyld_all_image_infos_errorClientOfDylibPath = *(unsigned long long *)(&$kgm_dyld_all_image_infos_v10[128-112])
		  set $kgm_dyld_all_image_infos_errorTargetDylibPath = *(unsigned long long *)(&$kgm_dyld_all_image_infos_v10[136-112])
		  set $kgm_dyld_all_image_infos_errorSymbol = *(unsigned long long *)(&$kgm_dyld_all_image_infos_v10[144-112])
		  set $kgm_dyld_all_image_infos_sharedCacheSlide = *(unsigned long long *)(&$kgm_dyld_all_image_infos_v10[152-112])

		  _unmap_user_data_from_task $kgm_taskp
	   else
		  set $kgm_dyld_all_image_infos_address = $kgm_dyld_all_image_infos_address + 60
		  _map_user_data_from_task $kgm_taskp $kgm_dyld_all_image_infos_address 64
		  set $kgm_dyld_all_image_infos_v10 = (unsigned char *)$kgm_map_user_window
		  set $kgm_dyld_all_image_infos_initialImageCount = *(unsigned int *)(&$kgm_dyld_all_image_infos_v10[60-60])
		  set $kgm_dyld_all_image_infos_errorKind = *(unsigned int *)(&$kgm_dyld_all_image_infos_v10[64-60])
		  set $kgm_dyld_all_image_infos_errorClientOfDylibPath = *(unsigned int *)(&$kgm_dyld_all_image_infos_v10[68-60])
		  set $kgm_dyld_all_image_infos_errorTargetDylibPath = *(unsigned int *)(&$kgm_dyld_all_image_infos_v10[72-60])
		  set $kgm_dyld_all_image_infos_errorSymbol = *(unsigned int *)(&$kgm_dyld_all_image_infos_v10[76-60])
		  set $kgm_dyld_all_image_infos_sharedCacheSlide = *(unsigned int *)(&$kgm_dyld_all_image_infos_v10[80-60])
		  _unmap_user_data_from_task $kgm_taskp
	   end

	   if $kgm_dyld_all_image_infos_version >= 10
		  printf "              initialImageCount "
		  showuserptr $kgm_dyld_all_image_infos_initialImageCount
		  printf "\n"
	   end

	   if $kgm_dyld_all_image_infos_version >= 11
		  printf "                      errorKind "
		  showuserptr $kgm_dyld_all_image_infos_errorKind
		  printf "\n"
		  printf "         errorClientOfDylibPath "
		  showuserptr $kgm_dyld_all_image_infos_errorClientOfDylibPath
		  printf "\n"
		  if $kgm_dyld_all_image_infos_errorClientOfDylibPath != 0
			 printf "                                "
			 _print_path_for_image $kgm_dyld_all_image_infos_errorClientOfDylibPath
			 printf "\n"
		  end
		  printf "           errorTargetDylibPath "
		  showuserptr $kgm_dyld_all_image_infos_errorTargetDylibPath
		  printf "\n"
		  if $kgm_dyld_all_image_infos_errorTargetDylibPath != 0
			 printf "                                "
			 _print_path_for_image $kgm_dyld_all_image_infos_errorTargetDylibPath
			 printf "\n"
		  end
		  printf "                    errorSymbol "
		  showuserptr $kgm_dyld_all_image_infos_errorSymbol
		  printf "\n"
		  if $kgm_dyld_all_image_infos_errorSymbol != 0
			 printf "                                "
			 _print_path_for_image $kgm_dyld_all_image_infos_errorSymbol
			 printf "\n"
		  end
	   end

	   if $kgm_dyld_all_image_infos_version >= 12
		  printf "               sharedCacheSlide "
		  showuserptr $kgm_dyld_all_image_infos_sharedCacheSlide
		  printf "\n"
	   end

	else
		printf "No dyld information available for task\n"
	end
end
document showuserdyldinfo
Syntax: (gdb) showuserdyldinfo <task_t>
| For a given user task, inspect the dyld global info and print
| out all fields, including error messages.
end

define showkerneldebugheader
	printf "kd_buf     "
	showptrhdrpad
	printf "CPU  Thread     "
	showptrhdrpad
	printf "Timestamp         S/E Class Sub   Code   Code Specific Info\n"
end

define _printevflags
	if $arg0 & 1
		printf "EV_RE "
	end
	if $arg0 & 2
		printf "EV_WR "
	end
	if $arg0 & 4
		printf "EV_EX "
	end
	if $arg0 & 8
		printf "EV_RM "
	end

	if $arg0 & 0x00100
		printf "EV_RBYTES "
	end
	if $arg0 & 0x00200
		printf "EV_WBYTES "
	end
	if $arg0 & 0x00400
		printf "EV_RCLOSED "
	end
	if $arg0 & 0x00800
		printf "EV_RCONN "
	end
	if $arg0 & 0x01000
		printf "EV_WCLOSED "
	end
	if $arg0 & 0x02000
		printf "EV_WCONN "
	end
	if $arg0 & 0x04000
		printf "EV_OOB "
	end
	if $arg0 & 0x08000
		printf "EV_FIN "
	end
	if $arg0 & 0x10000
		printf "EV_RESET "
	end
	if $arg0 & 0x20000
		printf "EV_TIMEOUT "
	end
end

define showkerneldebugbufferentry
	set $kgm_kdebug_entry = (kd_buf *) $arg0
	
	set $kgm_debugid     = $kgm_kdebug_entry->debugid
	set $kgm_kdebug_arg1 = $kgm_kdebug_entry->arg1
	set $kgm_kdebug_arg2 = $kgm_kdebug_entry->arg2
	set $kgm_kdebug_arg3 = $kgm_kdebug_entry->arg3
	set $kgm_kdebug_arg4 = $kgm_kdebug_entry->arg4
	
	if $kgm_lp64
		set $kgm_kdebug_cpu	 = $kgm_kdebug_entry->cpuid
		set $kgm_ts_hi	     = ($kgm_kdebug_entry->timestamp >> 32) & 0xFFFFFFFF
		set $kgm_ts_lo	     = $kgm_kdebug_entry->timestamp & 0xFFFFFFFF
	else
		set $kgm_kdebug_cpu	 = ($kgm_kdebug_entry->timestamp >> 56)
		set $kgm_ts_hi	     = ($kgm_kdebug_entry->timestamp >> 32) & 0x00FFFFFF
		set $kgm_ts_lo	     = $kgm_kdebug_entry->timestamp & 0xFFFFFFFF
	end
	
	set $kgm_kdebug_class    = ($kgm_debugid >> 24) & 0x000FF
	set $kgm_kdebug_subclass = ($kgm_debugid >> 16) & 0x000FF
	set $kgm_kdebug_code     = ($kgm_debugid >>  2) & 0x03FFF
	set $kgm_kdebug_qual     = ($kgm_debugid      ) & 0x00003
	
	if $kgm_kdebug_qual == 0
		set $kgm_kdebug_qual = '-'
	else
		if $kgm_kdebug_qual == 1
			set $kgm_kdebug_qual = 'S'
		else
			if $kgm_kdebug_qual == 2
				set $kgm_kdebug_qual = 'E'
			else
				if $kgm_kdebug_qual == 3
					set $kgm_kdebug_qual = '?'
				end
			end
		end
	end

	# preamble and qual
	
	showptr $kgm_kdebug_entry
	printf "  %d   ", $kgm_kdebug_cpu
	showptr $kgm_kdebug_entry->arg5
	printf " 0x%08X%08X %c  ", $kgm_ts_hi, $kgm_ts_lo, $kgm_kdebug_qual
	
	# class
	
	if $kgm_kdebug_class == 1
		printf "MACH"
	else
	if $kgm_kdebug_class == 2
		printf "NET "
	else
	if $kgm_kdebug_class == 3
		printf "FS  "
	else
	if $kgm_kdebug_class == 4
		printf "BSD "
	else
	if $kgm_kdebug_class == 5
		printf "IOK "
	else
	if $kgm_kdebug_class == 6
		printf "DRVR"
	else
	if $kgm_kdebug_class == 7
		printf "TRAC"
	else
	if $kgm_kdebug_class == 8
		printf "DLIL"
	else
	if $kgm_kdebug_class == 8
		printf "SEC "
	else
	if $kgm_kdebug_class == 20
		printf "MISC"
	else
	if $kgm_kdebug_class == 31
		printf "DYLD"
	else
	if $kgm_kdebug_class == 32
		printf "QT  "
	else
	if $kgm_kdebug_class == 33
		printf "APPS"
	else
	if $kgm_kdebug_class == 255
		printf "MIG "
	else
		printf "0x%02X", $kgm_kdebug_class
	end
	end
	end
	end
	end
	end
	end
	end
	end
	end
	end
	end
	end
	end
	
	# subclass and code
	
	printf "  0x%02X %5d   ", $kgm_kdebug_subclass, $kgm_kdebug_code

	# space for debugid-specific processing
	
	# EVPROC from bsd/kern/sys_generic.c
	
	# MISCDBG_CODE(DBG_EVENT,DBG_WAIT)
	if $kgm_debugid == 0x14100048
		printf "waitevent "
		if $kgm_kdebug_arg1 == 1
			printf "before sleep"
		else
		if $kgm_kdebug_arg1 == 2
			printf "after  sleep"
		else
			printf "????????????"
		end
		end
		printf " chan=0x%08X ", $kgm_kdebug_arg2
	else
	# MISCDBG_CODE(DBG_EVENT,DBG_WAIT|DBG_FUNC_START)
	if $kgm_debugid == 0x14100049
		printf "waitevent "
	else
	# MISCDBG_CODE(DBG_EVENT,DBG_WAIT|DBG_FUNC_END)
	if $kgm_debugid == 0x1410004a
		printf "waitevent error=%d ", $kgm_kdebug_arg1
		printf "eqp=0x%08X ", $kgm_kdebug_arg4
		_printevflags $kgm_kdebug_arg3
		printf "er_handle=%d ", $kgm_kdebug_arg2
	else
	# MISCDBG_CODE(DBG_EVENT,DBG_DEQUEUE|DBG_FUNC_START)
	if $kgm_debugid == 0x14100059
		printf "evprocdeque proc=0x%08X ", $kgm_kdebug_arg1
		if $kgm_kdebug_arg2 == 0
			printf "remove first "
		else
			printf "remove 0x%08X ", $kgm_kdebug_arg2
		end
	else
	# MISCDBG_CODE(DBG_EVENT,DBG_DEQUEUE|DBG_FUNC_END)
	if $kgm_debugid == 0x1410005a
		printf "evprocdeque "
		if $kgm_kdebug_arg1 == 0
			printf "result=NULL "
		else
			printf "result=0x%08X ", $kgm_kdebug_arg1
		end
	else
	# MISCDBG_CODE(DBG_EVENT,DBG_POST|DBG_FUNC_START)
	if $kgm_debugid == 0x14100041
		printf "postevent "
		_printevflags $kgm_kdebug_arg1
	else
	# MISCDBG_CODE(DBG_EVENT,DBG_POST)
	if $kgm_debugid == 0x14100040
		printf "postevent "
		printf "evq=0x%08X ", $kgm_kdebug_arg1
		printf "er_eventbits="
		_printevflags $kgm_kdebug_arg2
		printf "mask="
		_printevflags $kgm_kdebug_arg3
	else
	# MISCDBG_CODE(DBG_EVENT,DBG_POST|DBG_FUNC_END)
	if $kgm_debugid == 0x14100042
		printf "postevent "
	else
	# MISCDBG_CODE(DBG_EVENT,DBG_ENQUEUE|DBG_FUNC_START)
	if $kgm_debugid == 0x14100055
		printf "evprocenque eqp=0x%08d ", $kgm_kdebug_arg1
		if $kgm_kdebug_arg2 & 1
			printf "EV_QUEUED "
		end
		_printevflags $kgm_kdebug_arg3
	else
	
	# MISCDBG_CODE(DBG_EVENT,DBG_EWAKEUP)
	if $kgm_debugid == 0x14100050
		printf "evprocenque before wakeup eqp=0x%08d ", $kgm_kdebug_arg4
	else
	# MISCDBG_CODE(DBG_EVENT,DBG_ENQUEUE|DBG_FUNC_END)
	if $kgm_debugid == 0x14100056
		printf "evprocenque "
	else
	# MISCDBG_CODE(DBG_EVENT,DBG_MOD|DBG_FUNC_START)
	if $kgm_debugid == 0x1410004d
		printf "modwatch "
	else
	# MISCDBG_CODE(DBG_EVENT,DBG_MOD)
	if $kgm_debugid == 0x1410004c
		printf "modwatch er_handle=%d ", $kgm_kdebug_arg1
		_printevflags $kgm_kdebug_arg2
		printf "evq=0x%08X ", $kgm_kdebug_arg3
	else
	# MISCDBG_CODE(DBG_EVENT,DBG_MOD|DBG_FUNC_END)
	if $kgm_debugid == 0x1410004e
		printf "modwatch er_handle=%d ", $kgm_kdebug_arg1
		printf "ee_eventmask="
		_printevflags $kgm_kdebug_arg2
		printf "sp=0x%08X ", $kgm_kdebug_arg3
		printf "flag="
		_printevflags $kgm_kdebug_arg4
	else
		printf "arg1=0x%08X ", $kgm_kdebug_arg1
		printf "arg2=0x%08X ", $kgm_kdebug_arg2
		printf "arg3=0x%08X ", $kgm_kdebug_arg3
		printf "arg4=0x%08X ", $kgm_kdebug_arg4
	end
	end
	end
	end
	end
	end
	end
	end
	end
	end
	end
	end
	end
	end
	
	# finish up
	
	printf "\n"
end

define showkerneldebugbuffercpu
	set $kgm_cpu_number = (int) $arg0
	set $kgm_entry_count = (int) $arg1
	set $kgm_debugentriesfound = 0
	# 0x80000000 == KDBG_BFINIT
	if (kd_ctrl_page.kdebug_flags & 0x80000000)	
		showkerneldebugheader
		
		if $kgm_entry_count == 0
			printf "<count> is 0, dumping 50 entries\n"
			set $kgm_entry_count = 50
		end
	
		if $kgm_cpu_number >= kd_cpus
			printf "cpu number too big\n"
		else
			set $kgm_kdbp = &kdbip[$kgm_cpu_number]
			set $kgm_kdsp = $kgm_kdbp->kd_list_head
			while (($kgm_kdsp.raw != 0) && ($kgm_entry_count > 0))
				set $kgm_kdsp_actual = &kd_bufs[$kgm_kdsp.buffer_index].kdsb_addr[$kgm_kdsp.offset]
				if $kgm_kdsp_actual->kds_readlast != $kgm_kdsp_actual->kds_bufindx
					set $kgm_kds_bufptr = &$kgm_kdsp_actual->kds_records[$kgm_kdsp_actual->kds_bufindx]
					while (($kgm_kds_bufptr > &$kgm_kdsp_actual->kds_records[$kgm_kdsp_actual->kds_readlast]) && ($kgm_entry_count > 0))
						set $kgm_kds_bufptr = $kgm_kds_bufptr - 1
						set $kgm_entry_count = $kgm_entry_count - 1
						showkerneldebugbufferentry $kgm_kds_bufptr
					end
				end
				set $kgm_kdsp = $kgm_kdsp_actual->kds_next
			end
		end
	else
		printf "Trace buffer not enabled\n"
	end
end

document showkerneldebugbuffercpu
Syntax:  showkerneldebugbuffercpu <cpu> <count>
| Prints the last N entries in the kernel debug buffer for CPU x.
end

define showkerneldebugbuffer
	# 0x80000000 == KDBG_BFINIT
	if (kd_ctrl_page.kdebug_flags & 0x80000000)	
	
		set $kgm_entrycount = (int) $arg0
	
		if $kgm_entrycount == 0
			printf "<count> is 0, dumping 50 entries per cpu\n"
			set $kgm_entrycount = 50
		end
	
		set $kgm_cpu = (int) 0
	
		while $kgm_cpu < kd_cpus
			showkerneldebugbuffercpu $kgm_cpu $kgm_entrycount
			set $kgm_cpu = $kgm_cpu + 1
		end
	else
		printf "Trace buffer not enabled\n"
	end
end

document showkerneldebugbuffer
Syntax: showkerneldebugbuffer <count>
| Prints the last N entries in the kernel debug buffer per cpu. i.e. showkerneldebugbuffer 50 will
| display the last 50 entries in each CPU's debug buffer.
end

define showallvmstats
  printf "     pid           command    #ents           wired           vsize   rsize       max rsize\n"
  printf "                                            (pages)         (pages)   (pages)         (pages)\n"
  set $kgm_head_taskp = &tasks
  set $kgm_taskp = (struct task *)($kgm_head_taskp->next)
  while $kgm_taskp != $kgm_head_taskp
    set $kgm_procp = (struct proc *)($kgm_taskp->bsd_info)
    set $kgm_mapp = (struct _vm_map *)($kgm_taskp->map)
    printf "%8d %17s %8d %15d %15d %15d %15d\n", $kgm_procp->p_pid, $kgm_procp->p_comm, $kgm_mapp->hdr.nentries, $kgm_mapp->pmap->stats.wired_count, $kgm_mapp->size >> 12, $kgm_mapp->pmap->stats.resident_count, $kgm_mapp->pmap->stats.resident_max
    set $kgm_taskp = (struct task *)($kgm_taskp->tasks.next)
  end
end

document showallvmstats
Syntax: showallvmstats
| prints a summary of vm statistics in a table format
end

define memstats
	if ($kgm_mtype == $kgm_mtype_arm)
		printf "kern_memorystatus_level:  %8d\n", kern_memorystatus_level
	end	
	printf "vm_page_throttled_count:  %8d\n", vm_page_throttled_count 
	printf "vm_page_active_count:     %8d\n", vm_page_active_count
	printf "vm_page_inactive_count:   %8d\n", vm_page_inactive_count
	printf "vm_page_wire_count:       %8d\n", vm_page_wire_count
	printf "vm_page_free_count:       %8d\n", vm_page_free_count
	printf "vm_page_purgeable_count:  %8d\n", vm_page_purgeable_count
	printf "vm_page_inactive_target:  %8d\n", vm_page_inactive_target
	printf "vm_page_free_target:      %8d\n", vm_page_free_target
	printf "inuse_ptepages_count:     %8d\n", inuse_ptepages_count
	printf "vm_page_free_reserved:    %8d\n", vm_page_free_reserved
end

document memstats
Syntax: (gdb) memstats 
| Prints out a summary of various memory statistics. In particular vm_page_wire_count should
| be greater than 2K or you are under memory pressure.
end

define show_user_registers
       showuserregisters $arg0
end

document show_user_registers
Syntax: show_user_registers <thread_address>
| Display user registers associated with a kernel thread
| properly displays the 32 bit or 64 bit registers for intel architecture
end

define _cmp
       set $cmp0 = $arg0
       set $cmp1 = $arg1

       # check for end of string. cmp0 can be longer than cmp1. it
       # can't be shorter.
       if $cmp1 == '\0'
       	  set $kgm_strcmp_result = 0
	  set $kgm_strcmp_done   = 1
       end

       if !$kgm_strcmp_done && $cmp0 == '\0'
       	  set $kgm_strcmp_result = -1
       	  set $kgm_strcmp_done   =  1
       end

       # do they match?
       if !$kgm_strcmp_done 
       	  set $kgm_strcmp_result = (uint8_t) $cmp0 - (uint8_t) $cmp1
       	  if $kgm_strcmp_result != 0
       	     set $kgm_strcmp_done = 1
	  end
       end
end

define _cmp_arg64
       set $cmp = $arg1
       set $masked = $cmp & 0xFF
       _cmp $arg0[0] $masked

       if !$kgm_strcmp_done
       	  set $cmp = $cmp >> 8
	  set $masked  = $cmp & 0xFF
	  _cmp $arg0[1] $masked
       end
       if !$kgm_strcmp_done
       	  set $cmp = $cmp >> 8
	  set $masked  = $cmp & 0xFF
	  _cmp $arg0[2] $masked
       end
       if !$kgm_strcmp_done
       	  set $cmp = $cmp >> 8
	  set $masked  = $cmp & 0xFF
	  _cmp $arg0[3] $masked
       end
       if !$kgm_strcmp_done
       	  set $cmp = $cmp >> 8
	  set $masked  = $cmp & 0xFF
	  _cmp $arg0[4] $masked
       end
       if !$kgm_strcmp_done
       	  set $cmp = $cmp >> 8
	  set $masked  = $cmp & 0xFF
	  _cmp $arg0[5] $masked
       end
       if !$kgm_strcmp_done
       	  set $cmp = $cmp >> 8
	  set $masked  = $cmp & 0xFF
	  _cmp $arg0[6] $masked
       end
       if !$kgm_strcmp_done
       	  set $cmp = $cmp >> 8
	  set $masked  = $cmp & 0xFF
	  _cmp $arg0[7] $masked
       end
end

define strcmp_arg_pack64
       set $kgm_strcmp_arg = ((((((((((((((uint64_t) $arg7 << 8) | $arg6) << 8) | $arg5) << 8) | $arg4) << 8) | $arg3) << 8) | $arg2) << 8) | $arg1) << 8) | $arg0
end

document strcmp_arg_pack64
Syntax: strcmp_arg_pack64 <a> <b> <c> <d> <e <f> <g> <h>
| Packs a string given as 8 character arguments into a 64-bit int stored in 
| $kgm_strcmp_arg. Use 0 or '\0' for unused arguments. The encoded string
| is suitable for use by strcmp_nomalloc and setfindregistrystr.
| e.g., strcmp_arg_pack64 'H' 'e' 'l' 'l' 'o' 0 0 0 
|       packs "Hello" into $kgm_strcmp_arg.
| 
end

define strcmp_nomalloc
       set $str   = $arg0
       set $count = $argc - 1

       set $kgm_strcmp_result = 0
       set $kgm_strcmp_done   = 0

       if $count > 0 
       	  _cmp_arg64 $str $arg1
       end
       if !$kgm_strcmp_done && $count > 1
          set $str = $str + 8
       	  _cmp_arg64 $str $arg2
       end
       if !$kgm_strcmp_done && $count > 2
          set $str = $str + 8
       	  _cmp_arg64 $str $arg3
       end
       if !$kgm_strcmp_done && $count > 3
          set $str = $str + 8
       	  _cmp_arg64 $str $arg4
       end
       if !$kgm_strcmp_done && $count > 4
          set $str = $str + 8
       	  _cmp_arg64 $str $arg5
       end
       if !$kgm_strcmp_done && $count > 5
          set $str = $str + 8
       	  _cmp_arg64 $str $arg6
       end
       if !$kgm_strcmp_done && $count > 6
          set $str = $str + 8
       	  _cmp_arg64 $str $arg7
       end
       if !$kgm_strcmp_done && $count > 7
          set $str = $str + 8
       	  _cmp_arg64 $str $arg8
       end
       if !$kgm_strcmp_done && $count > 8
          set $str = $str + 8
       	  _cmp_arg64 $str $arg9
       end
end

document strcmp_nomalloc
Syntax: strcmp_nomalloc <string> <a> [b] [c] [d] [e] [f] [g] [h] [i]
| Given a pre-allocated <string>, perform a string compare with the 
| encoded string stored in arguments a - i. The result is stored in
| $kgm_strcmp_result.
|
| For example, the following will result in $kgm_strcmp_result == 0:
| strcmp_arg_pack64 'D' 'a' 'r' 'w' 'i' 'n' ' ' 'K' 
| strcmp_nomalloc version $kgm_strcmp_arg
end

define memcpy
    set $kgm_dst = (unsigned char *)$arg0
    set $kgm_src = (unsigned char *)$arg1
    set $kgm_count = $arg2

    # printf "src %p dst %p len %d\n", $kgm_src, $kgm_dst, $kgm_count

    while ($kgm_count >= 8)
        set *(unsigned long long *)$kgm_dst = *(unsigned long long *)$kgm_src

        set $kgm_dst = $kgm_dst + 8
        set $kgm_src = $kgm_src + 8
        set $kgm_count = $kgm_count - 8
    end
    while ($kgm_count > 0)
        set *$kgm_dst = *$kgm_src

        set $kgm_dst = $kgm_dst + 1
        set $kgm_src = $kgm_src + 1
        set $kgm_count = $kgm_count - 1
    end
end

document memcpy
Syntax: memcpy <dst> <src> <n>
| Given two addresses that are accessible by the debugger, perform
| a memory copy of <n> bytes from <src> to <dst>
end

# _pci_cfg_addr_value $addr $size
define _pci_cfg_addr_value
   readphysint $arg0 $arg1 $kgm_lcpu_self
   set $kgm_pci_cfg_value = $kgm_readphysint_result
end


set $kgm_pci_cfg_init = 0
define _pci_cfg_init
       # get this from the registry if it exists there
       if $kgm_pci_cfg_init == 0
       	  strcmp_arg_pack64 'A' 'p' 'p' 'l' 'e' 'A' 'C' 'P'
       	  set $AppleACP = $kgm_strcmp_arg
       	  strcmp_arg_pack64 'I' 'P' 'l' 'a' 't' 'f' 'o' 'r'
      	  set $IPlatfor = $kgm_strcmp_arg
       	  strcmp_arg_pack64 'm' 'E' 'x' 'p' 'e' 'r' 't' 0
       	  set $mExpert = $kgm_strcmp_arg
	  setfindregistrystr $AppleACP $IPlatfor $mExpert

	  set $olddepth = $kgm_reg_depth_max
	  set $kgm_reg_depth_max = 2
	  _findregistryentry 
	  set $kgm_reg_depth_max = $olddepth

	  if $kgm_registry_entry
	     strcmp_arg_pack64 'a' 'c' 'p' 'i' '-' 'm' 'm' 'c' 
	     set $acpi_mmc = $kgm_strcmp_arg
	     strcmp_arg_pack64 'f' 'g' '-' 's' 'e' 'g' '0' 0
	     set $fg_seg0 = $kgm_strcmp_arg
	     setfindregistrystr $acpi_mmc $fg_seg0

	     _findregistryprop $kgm_registry_entry
	     if $kgm_registry_value
	     	set $kgm_pci_cfg_base = ((OSNumber *) $kgm_registry_value)->value
		set $kgm_pci_cfg_init = 1
	     end
	  end
       end

       # search for 0:0:0 in likely places if the above fails
       if $kgm_pci_cfg_init == 0
       	  set $kgm_pci_cfg_base = 0xF0000000
	  while $kgm_pci_cfg_init == 0 && $kgm_pci_cfg_base > 0xA0000000
	      _pci_cfg_addr_value $kgm_pci_cfg_base 8
	      if $kgm_pci_cfg_value > 0x0 && $kgm_pci_cfg_value < 0xFF
	      	 set $kgm_pci_cfg_init = 1
	      else
	      	 set $kgm_pci_cfg_base = $kgm_pci_cfg_base - 0x10000000
	      end
	  end
       end
end

# _pci_cfg_addr $bus $dev $fcn $off
define _pci_cfg_addr
       set $bus = $arg0
       set $dev = $arg1
       set $fcn = $arg2
       set $off = $arg3

       _pci_cfg_init
       set $kgm_pci_cfg_addr = $kgm_pci_cfg_base | ($bus << 20) | ($dev << 15) | ($fcn << 12) | $off
end

define _pci_cfg_value
       _pci_cfg_addr $arg0 $arg1 $arg2 $arg3 
       _pci_cfg_addr_value $kgm_pci_cfg_addr $arg4
end

define pci_cfg_read8
       _pci_cfg_value $arg0 $arg1 $arg2 $arg3 8
       printf "%08X: %02X\n", $kgm_pci_cfg_addr, $kgm_pci_cfg_value
end

define pci_cfg_read16
       _pci_cfg_value $arg0 $arg1 $arg2 $arg3 16
       printf "%08X: %04X\n", $kgm_pci_cfg_addr, $kgm_pci_cfg_value
end

define pci_cfg_read32
       _pci_cfg_value $arg0 $arg1 $arg2 $arg3 32
       printf "%08X: %08X\n", $kgm_pci_cfg_addr, $kgm_pci_cfg_value
end

document pci_cfg_read8
Syntax: (gdb) pci_cfg_read8 <bus> <dev> <fcn> <off>
| read 8 bits for the given <off> of the pci device located at
| <bus>:<dev>:<fcn>. 
end

document pci_cfg_read16
Syntax: (gdb) pci_cfg_read <bus> <dev> <fcn> <off>
| read 16 bits for the given <off> of the pci device located at
| <bus>:<dev>:<fcn>.
end

document pci_cfg_read32
Syntax: (gdb) pci_cfg_read <bus> <dev> <fcn> <off>
| read 32 bits for the given <off> of the pci device located at
| <bus>:<dev>:<fcn>.
end

define pci_cfg_write8
       _pci_cfg_addr $arg0 $arg1 $arg2 $arg3 
       writephysint $kgm_pci_cfg_addr 8 $arg4 $kgm_lcpu_self
end

define pci_cfg_write16
       _pci_cfg_addr $arg0 $arg1 $arg2 $arg3 
       writephysint $kgm_pci_cfg_addr 16 $arg4 $kgm_lcpu_self
end

define pci_cfg_write32
       _pci_cfg_addr $arg0 $arg1 $arg2 $arg3 
       writephysint $kgm_pci_cfg_addr 32 $arg4 $kgm_lcpu_self
end

document pci_cfg_write8
Syntax: (gdb) pci_cfg_write8 <bus> <dev> <fcn> <off> <value>
| write an 8-bit <value> into the given <off> of the pci device located at
| <bus>:<dev>:<fcn>. 
end

document pci_cfg_write16
Syntax: (gdb) pci_cfg_write16 <bus> <dev> <fcn> <off> <value>
| write a 16-bit <value> into the given <off> of the pci device located at
| <bus>:<dev>:<fcn>. 
end

document pci_cfg_write32
Syntax: (gdb) pci_cfg_write32 <bus> <dev> <fcn> <off> <value>
| write a 32-bit <value> into the given <off> of the pci device located at
| <bus>:<dev>:<fcn>.
end


define pci_cfg_dump
       set $bus  = $arg0
       set $dev  = $arg1
       set $fcn  = $arg2
       set $off  = 0

       # check for a valid pci device
       _pci_cfg_value $bus $dev $fcn $off 8
       if $kgm_pci_cfg_value > 0x0 && $kgm_pci_cfg_value < 0xff
              printf " address: 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F\n"
              printf "---------------------------------------------------------"

              while $off < 256
       	          _pci_cfg_value $bus $dev $fcn $off 32
		  if ($off & 0xF) == 0
		     printf "\n%08X: ", $kgm_pci_cfg_addr
		  end
		  printf "%02X %02X %02X %02X ", $kgm_pci_cfg_value & 0xFF, ($kgm_pci_cfg_value >> 8) & 0xFF, ($kgm_pci_cfg_value >> 16) & 0xFF, ($kgm_pci_cfg_value >> 24) & 0xFF
	     	  set $off = $off + 4
	      end
	      printf "\n"

	      # check for pcie extended capability config space
	      _pci_cfg_value $bus $dev $fcn $off 8
	      if $kgm_pci_cfg_value < 0xff
	      	 while $off < 4096
       	      	       _pci_cfg_value $bus $dev $fcn $off 32
		       if ($off & 0xF) == 0
		       	  printf "\n%08X: ", $kgm_pci_cfg_addr
		       end
		       printf "%02X %02X %02X %02X ", $kgm_pci_cfg_value & 0xFF, ($kgm_pci_cfg_value >> 8) & 0xFF, ($kgm_pci_cfg_value >> 16) & 0xFF, ($kgm_pci_cfg_value >> 24) & 0xFF
	     	       set $off = $off + 4
	         end
	         printf "\n"
             end
       end      
end

document pci_cfg_dump
Syntax: (gdb) pci_cfg_dump <bus> <dev> <fcn> 
| dump config space for the pci device located at <bus>:<dev>:<fcn>
| if you specify an invalid/inaccessible pci device, nothing will be 
| printed out.
end

set $kgm_pci_cfg_bus_start    = 0
set $kgm_pci_cfg_bus_max      = 8
set $kgm_pci_cfg_device_max   = 32
set $kgm_pci_cfg_function_max = 8
define _pci_cfg_scan
       set $dump = $arg0

       set $bus = $kgm_pci_cfg_bus_start
       while $bus < $kgm_pci_cfg_bus_max
  	     # check for bus:0:0 to see if we should
	     # probe this bus further
	     _pci_cfg_value $bus 0x0 0x0 0x0 32
	     if $kgm_pci_cfg_value > 0 && $kgm_pci_cfg_value < 0xFFFFFFFF

	     	set $dev = 0
		while $dev < $kgm_pci_cfg_device_max

	     	   set $fcn = 0
	     	   while $fcn < $kgm_pci_cfg_function_max
		   	 _pci_cfg_value $bus $dev $fcn 0x0 32
			 if $kgm_pci_cfg_value > 0 && $kgm_pci_cfg_value < 0xFFFFFFFF
			    if $dump == 0
			       printf "%03X:%03X:%03X: %02X%02X   %02X%02X", $bus, $dev, $fcn, ($kgm_pci_cfg_value >> 8) & 0xFF, $kgm_pci_cfg_value & 0xFF, ($kgm_pci_cfg_value >> 24) & 0xFF, ($kgm_pci_cfg_value >> 16) & 0xFF 
			       _pci_cfg_value $bus $dev $fcn 0x8 32
			       printf "    %02X | %02X%02X%02X\n", $kgm_pci_cfg_value & 0xFF, ($kgm_pci_cfg_value >> 24) & 0xFF, ($kgm_pci_cfg_value >> 16) & 0xFF, ($kgm_pci_cfg_value >> 8) & 0xFF
			    else
			       printf "  device: %03X:%03X:%03X\n", $bus, $dev, $fcn			       
			       pci_cfg_dump $bus $dev $fcn	
			       printf "\n"
      			    end
			 end
			 set $fcn = $fcn + 1
		   end
		   set $dev = $dev + 1
	     	end
	     end
	     set $bus = $bus + 1
       end
end

define pci_cfg_dump_all
       _pci_cfg_scan 1
end

document pci_cfg_dump_all
Syntax: (gdb) pci_cfg_dump_all
| dump config spaces for scanned pci devices. the number of busses to scan 
| is stored in $kgm_pci_cfg_bus_max. the default for that is 8. you can also 
| specify the starting bus with $kgm_pci_cfg_bus_start. 
end

define pci_cfg_scan
       printf "bus:dev:fcn: vendor device rev | class\n"
       printf "---------------------------------------\n"
       _pci_cfg_scan 0
end

document pci_cfg_scan
Syntax: (gdb) pci_cfg_scan
| scan for pci devices. the number of busses to scan is stored in
| $kgm_pci_cfg_bus_max. the default for that is 8. you can also specify the
| starting bus with $kgm_pci_cfg_bus_start. 
end

define readioportint
       set $kgm_readioportint_result = 0xBAD10AD
       # set up the manual KDP packet
       set manual_pkt.input = 0
       set manual_pkt.len = sizeof(kdp_readioport_req_t)
       set $kgm_pkt = (kdp_readioport_req_t *)&manual_pkt.data
       set $kgm_pkt->hdr.request  = KDP_READIOPORT
       set $kgm_pkt->hdr.len      = sizeof(kdp_readioport_req_t)
       set $kgm_pkt->hdr.is_reply = 0
       set $kgm_pkt->hdr.seq      = 0
       set $kgm_pkt->hdr.key      = 0
       set $kgm_pkt->address      = (uint16_t)$arg0
       set $kgm_pkt->nbytes       = $arg1 >> 3
       set $kgm_pkt->lcpu         = (uint16_t)$arg2
       set manual_pkt.input       = 1
       # dummy to make sure manual packet is executed
       set $kgm_dummy = &_mh_execute_header
       set $kgm_pkt = (kdp_readioport_reply_t *)&manual_pkt.data
       if ($kgm_pkt->error == 0)
       	  if $arg1 == 8
	     set $kgm_readioportint_result = *((uint8_t *) $kgm_pkt->data)
	  end
       	  if $arg1 == 16
	     set $kgm_readioportint_result = *((uint16_t *) $kgm_pkt->data)
	  end
       	  if $arg1 == 32
	     set $kgm_readioportint_result = *((uint32_t *) $kgm_pkt->data)
	  end
       end
end

define readioport8
       set $lcpu = $kgm_lcpu_self
       if $argc > 1
       	  set $lcpu = $arg1
       end
       readioportint $arg0 8 $lcpu
       output /a $arg0
       printf ":\t0x%02hhx\n", $kgm_readioportint_result
end

define readioport16
       set $lcpu = $kgm_lcpu_self
       if $argc > 1
       	  set $lcpu = $arg1
       end
       readioportint $arg0 16 $lcpu
       output /a $arg0
       printf ":\t0x%04hx\n", $kgm_readioportint_result
end

define readioport32
       set $lcpu = $kgm_lcpu_self
       if $argc > 1
       	  set $lcpu = $arg1
       end
       readioportint $arg0 32 $lcpu
       output /a $arg0
       printf ":\t0x%08x\n", $kgm_readioportint_result
end

document readioport8
| See readioport32.
end

document readioport16
| See readioport32.
end

document readioport32
Syntax: (gdb) readioport32 <port> [lcpu (kernel's numbering convention)]
| Read value stored in the specified IO port. The CPU can be optionally
| specified as well.
end

define writeioportint
       # set up the manual KDP packet
       set manual_pkt.input = 0
       set manual_pkt.len = sizeof(kdp_writeioport_req_t)
       set $kgm_pkt = (kdp_writeioport_req_t *)&manual_pkt.data
       set $kgm_pkt->hdr.request  = KDP_WRITEIOPORT
       set $kgm_pkt->hdr.len      = sizeof(kdp_writeioport_req_t)
       set $kgm_pkt->hdr.is_reply = 0
       set $kgm_pkt->hdr.seq      = 0
       set $kgm_pkt->hdr.key      = 0
       set $kgm_pkt->address      = (uint16_t)$arg0
       set $kgm_pkt->nbytes       = $arg1 >> 3
       set $kgm_pkt->lcpu         = (uint16_t)$arg3
       if $arg1 == 8
       	  set *(uint8_t *)$kgm_pkt->data = (uint8_t)$arg2
       end
       if $arg1 == 16
       	  set *(uint16_t *)$kgm_pkt->data = (uint16_t)$arg2
       end
       if $arg1 == 32
       	  set *(uint32_t *)$kgm_pkt->data = (uint32_t)$arg2
       end
       set manual_pkt.input = 1
       # dummy to make sure manual packet is executed
       set $kgm_dummy = &_mh_execute_header
       set $kgm_pkt = (kdp_writeioport_reply_t *)&manual_pkt.data
       set $kgm_writeioportint_result = $kgm_pkt->error
end

define writeioport8
       set $lcpu = $kgm_lcpu_self
       if $argc > 2
       	  set $lcpu = $arg2
       end
       writeioportint $arg0 8 $arg1 $lcpu
end

define writeioport16
       set $lcpu = $kgm_lcpu_self
       if $argc > 2
       	  set $lcpu = $arg2
       end
       writeioportint $arg0 16 $arg1 $lcpu
end

define writeioport32
       set $lcpu = $kgm_lcpu_self
       if $argc > 2
       	  set $lcpu = $arg2
       end
       writeioportint $arg0 32 $arg1 $lcpu
end

document writeioport8
| See writeioport32.
end

document writeioport16
| See writeioport32.
end

document writeioport32
Syntax: (gdb) writeioport32 <port> <value> [lcpu (kernel's numbering convention)]
| Write the value to the specified IO port. The size of the value is
| determined by the name of the command. The CPU used can be optionally
| specified.
end

define readmsr64int
       set $kgm_readmsr64int_result = 0xBAD10AD
       # set up the manual KDP packet
       set manual_pkt.input = 0
       set manual_pkt.len = sizeof(kdp_readmsr64_req_t)
       set $kgm_pkt = (kdp_readmsr64_req_t *)&manual_pkt.data
       set $kgm_pkt->hdr.request  = KDP_READMSR64
       set $kgm_pkt->hdr.len      = sizeof(kdp_readmsr64_req_t)
       set $kgm_pkt->hdr.is_reply = 0
       set $kgm_pkt->hdr.seq      = 0
       set $kgm_pkt->hdr.key      = 0
       set $kgm_pkt->address      = (uint32_t)$arg0
       set $kgm_pkt->lcpu         = (uint16_t)$arg1
       set manual_pkt.input       = 1
       # dummy to make sure manual packet is executed
       set $kgm_dummy = &_mh_execute_header
       set $kgm_pkt = (kdp_readmsr64_reply_t *)&manual_pkt.data
       if ($kgm_pkt->error == 0)
       	   set $kgm_readmsr64int_result = *((uint64_t *) $kgm_pkt->data)
       end
end

define readmsr64
       set $lcpu = $kgm_lcpu_self
       if $argc > 1
       	  set $lcpu = $arg1
       end
       readmsr64int $arg0 $lcpu
       output /a $arg0
       printf ":\t0x%016llx\n", $kgm_readmsr64int_result
end

define writemsr64int
       # set up the manual KDP packet
       set manual_pkt.input = 0
       set manual_pkt.len = sizeof(kdp_writemsr64_req_t)
       set $kgm_pkt = (kdp_writemsr64_req_t *)&manual_pkt.data
       set $kgm_pkt->hdr.request       = KDP_WRITEMSR64
       set $kgm_pkt->hdr.len           = sizeof(kdp_writemsr64_req_t)
       set $kgm_pkt->hdr.is_reply      = 0
       set $kgm_pkt->hdr.seq           = 0
       set $kgm_pkt->hdr.key           = 0
       set $kgm_pkt->address           = (uint32_t)$arg0
       set $kgm_pkt->lcpu              = (uint16_t)$arg2
       set *(uint64_t *)$kgm_pkt->data = (uint64_t)$arg1
       set manual_pkt.input            = 1
       # dummy to make sure manual packet is executed
       set $kgm_dummy = &_mh_execute_header
       set $kgm_pkt = (kdp_writemsr64_reply_t *)&manual_pkt.data
       set $kgm_writemsr64int_result = $kgm_pkt->error
end

define writemsr64
       set $lcpu = $kgm_lcpu_self
       if $argc > 2
       	  set $lcpu = $arg2
       end
       writemsr64int $arg0 $arg1 $lcpu
end

document writemsr64
Syntax: (gdb) writemsr64 <msr> <value> [lcpu (kernel's numbering convention)]
| Write <value> to the specified MSR. The CPU can be optionally specified.
end

document readmsr64
Syntax: (gdb) readmsr64 <msr> [lcpu (kernel's numbering convention)]
| Read the specified MSR. The CPU can be optionally specified.
end

# default if we can't find a registry entry
set $kgm_ioapic_addr           = 0xFEC00000
set $kgm_ioapic_init           = 0

set $_ioapic_index_off         = 0x00
set $_ioapic_data_off          = 0x10
set $_ioapic_eoi_off           = 0x40

set $_ioapic_index_id          = 0x00
set $_ioapic_index_ver         = 0x01
set $_ioapic_index_redir_base  = 0x10

set $_apic_vector_mask         = 0xFF
set $_apic_timer_tsc_deadline  = 0x40000
set $_apic_timer_periodic      = 0x20000
set $_apic_masked              = 0x10000
set $_apic_trigger_level       = 0x08000
set $_apic_polarity_high       = 0x02000
set $_apic_pending             = 0x01000

define _ioapic_init
       if $kgm_ioapic_init == 0
       	  strcmp_arg_pack64 'i' 'o' '-' 'a' 'p' 'i' 'c' 0
	  setfindregistrystr $kgm_strcmp_arg

	  set $olddepth = $kgm_reg_depth_max
	  set $kgm_reg_depth_max = 3
	  _findregistryentry 
	  set $kgm_reg_depth_max = $olddepth

	  if $kgm_registry_entry
	     strcmp_arg_pack64 'P' 'h' 'y' 's' 'i' 'c' 'a' 'l'
	     set $Physical = $kgm_strcmp_arg
	     strcmp_arg_pack64 ' ' 'A' 'd' 'd' 'r' 'e' 's' 's'
	     set $_Address = $kgm_strcmp_arg
	     setfindregistrystr $Physical $_Address

	     _findregistryprop $kgm_registry_entry 
	     if $kgm_registry_value
	     	set $kgm_ioapic_addr = ((OSNumber *) $kgm_registry_value)->value
	     end
	  end
	  set $kgm_ioapic_index_addr = $kgm_ioapic_addr + $_ioapic_index_off
	  set $kgm_ioapic_data_addr  = $kgm_ioapic_addr + $_ioapic_data_off
	  set $kgm_ioapic_init  = 1
       end
end

define _ioapic_addr_value
       _ioapic_init
       writephysint $kgm_ioapic_index_addr 8 $arg0 $kgm_lcpu_self
       if $argc > 1
       	  writephysint $kgm_ioapic_data_addr 32 $arg1 $kgm_lcpu_self
       else
	  readphysint $kgm_ioapic_data_addr 32 $kgm_lcpu_self
	  set $kgm_ioapic_value = $kgm_readphysint_result
       end
end

define _apic_print
       set $value = $arg0

       printf "[VEC=%3d", $value & $_apic_vector_mask
       if $value & $_apic_masked
	  printf " MASK=yes"
       else
	  printf " MASK=no "
       end       

       if $value & $_apic_trigger_level
       	  printf " TRIG=level"
       else
	  printf " TRIG=edge "
       end

       if $value & $_apic_polarity_high
       	  printf " POL=high"
       else
	  printf " POL=low "
       end

       if $value & $_apic_pending
       	  printf " PEND=yes"
       else
	  printf " PEND=no "
       end

       if $value & $_apic_timer_periodic
	  printf " PERIODIC"
       end
       if $value & $_apic_timer_tsc_deadline
	  printf " TSC_DEADLINE"
       end

       printf "]\n"
end

define ioapic_read32
   if (($kgm_mtype & $kgm_mtype_x86_mask) != $kgm_mtype_x86_any)
       printf "ioapic_read32 not supported on this architecture.\n"
   else
       _ioapic_addr_value $arg0       
       printf "IOAPIC[0x%02X]: 0x%08X\n", $arg0, $kgm_ioapic_value
   end
end

document ioapic_read32
Syntax: (gdb) ioapic_read <offset>
| Read the IOAPIC register at the offset specified. 
end

define ioapic_write32
   if (($kgm_mtype & $kgm_mtype_x86_mask) != $kgm_mtype_x86_any)
       printf "ioapic_write32 not supported on this architecture.\n"
   else
       _ioapic_addr_value $arg0 $arg1
   end
end

document ioapic_write32
Syntax: (gdb) ioapic_write32 <offset> <value>
| Write the IOAPIC register at the offset specified. 
end

define ioapic_dump
   if (($kgm_mtype & $kgm_mtype_x86_mask) != $kgm_mtype_x86_any)
       printf "ioapic_dump not supported on this architecture.\n"
   else
       # id
       _ioapic_addr_value $_ioapic_index_id
       printf "IOAPIC[0x%02X] ID:        0x%08X\n", $_ioapic_index_id, $kgm_ioapic_value

       # version
       _ioapic_addr_value $_ioapic_index_ver
       set $maxredir = (($kgm_ioapic_value & 0xFF0000) >> 16) + 1

       printf "IOAPIC[0x%02X] VERSION:   0x%08X         [", $_ioapic_index_ver, $kgm_ioapic_value
       printf "MAXREDIR=%02d PRQ=%d VERSION=0x%02X]\n", $maxredir, ($kgm_ioapic_value >> 15) & 0x1, $kgm_ioapic_value & 0xFF
       
       # all the redir entries
       set $i = 0
       while $i < $maxredir
       	     set $addr0 = $_ioapic_index_redir_base + ($i << 1)
       	     set $addr1 = $addr0 + 1
             _ioapic_addr_value $addr1
	     printf "IOAPIC[0x%02X] IOREDIR%02d: 0x%08X", $addr0, $i, $kgm_ioapic_value

	     _ioapic_addr_value $addr0
	     printf "%08X ", $kgm_ioapic_value
	     _apic_print $kgm_ioapic_value
	     set $i = $i + 1
       end
   end
end

document ioapic_dump
Syntax: (gdb) ioapic_dump
| Dump all the IOAPIC entries.
end


set $_lapic_base_addr         = 0xFEE00000
set $_lapic_id                = 0x20
set $_lapic_version           = 0x30
set $_lapic_tpr               = 0x80
set $_lapic_apr               = 0x90
set $_lapic_ppr               = 0xA0
set $_lapic_eoi               = 0xB0
set $_lapic_ldr               = 0xD0
set $_lapic_dfr               = 0xE0
set $_lapic_sivr              = 0xF0

set $_lapic_isr_size          = 0x10
set $_lapic_isr_num           = 8
set $_lapic_isr0              = 0x100
set $_lapic_tmr0              = 0x180
set $_lapic_irr0              = 0x200

set $_lapic_esr               = 0x280
set $_lapic_esr_register      = 0x80
set $_lapic_esr_recv_vect     = 0x40
set $_lapic_esr_send_vect     = 0x20

set $_lapic_icr0              = 0x300
set $_lapic_icr1              = 0x310

set $_lapic_lvt_timer         = 0x320
set $_lapic_lvt_thermal       = 0x330
set $_lapic_lvt_pmcr          = 0x340
set $_lapic_lvt_lint0         = 0x350
set $_lapic_lvt_lint1         = 0x360
set $_lapic_lvt_error         = 0x370

set $_lapic_icr               = 0x380
set $_lapic_ccr               = 0x390
set $_lapic_dcr               = 0x3E0

set $_apic_cfg_msr          = 0x1B
set $_apic_cfg_msr_x2EN     = 0x00000C00
set $_x2apic_enabled         = -1

# _lapic_addr $offset returns the actual address to use
define _lapic_addr
       if $_x2apic_enabled < 0
       	  readmsr64int $_apic_cfg_msr $kgm_lcpu_self
	  if ($kgm_readmsr64int_result & $_apic_cfg_msr_x2EN) == $_apic_cfg_msr_x2EN
	     set $_x2apic_enabled = 1
	  else
	     set $_x2apic_enabled = 0
	  end
       end

       if $_x2apic_enabled 
       	  # x2APIC addresses are MSRs that use xAPIC offsets that
	  # are 4-bit shifted
       	  set $kgm_lapic_addr = $arg0 >> 4
       else
       	  set $kgm_lapic_addr = $_lapic_base_addr + $arg0
       end
end

# _lapic_addr_value $offset $lcpu
define _lapic_addr_value
       _lapic_addr $arg0
       if $_x2apic_enabled
       	  readmsr64int $kgm_lapic_addr $arg1
	  set $kgm_lapic_value = $kgm_readmsr64int_result       	  
       else
       	  readphysint $kgm_lapic_addr 32 $arg1
	  set $kgm_lapic_value = $kgm_readphysint_result
       end
end

# lapic_read32 $offset [$lcpu]
define lapic_read32
   if (($kgm_mtype & $kgm_mtype_x86_mask) != $kgm_mtype_x86_any)
       printf "lapic_read32 not supported on this architecture.\n"
   else
       set $lcpu = $kgm_lcpu_self
       if $argc > 1
       	  set $lcpu = $arg1
       end
       _lapic_addr_value $arg0 $lcpu
       printf "LAPIC[0x%03X]: 0x%08X\n", $arg0, $kgm_lapic_value
   end
end

document lapic_read32
Syntax: (gdb) apic_read32_cpu <offset> [lcpu (kernel's numbering convention)]
| Read the LAPIC register at the offset specified. The CPU can be optionally
| specified.
end

# lapic_write32 $offset $value [$lcpu]
define lapic_write32
   if (($kgm_mtype & $kgm_mtype_x86_mask) != $kgm_mtype_x86_any)
       printf "lapic_write32_cpu not supported on this architecture.\n"
   else
       set $lcpu = $kgm_lcpu_self
       if $argc > 2
       	  set $lcpu = $arg2
       end

       _lapic_addr $arg0
       if $_x2apic_enabled
       	  writemsr64int $kgm_lapic_addr $arg1 $lcpu
       else
       	  writephysint $kgm_lapic_addr 32 $arg1 $lcpu
       end
   end
end

document lapic_write32
Syntax: (gdb) lapic_write32 <offset> <value> [lcpu (kernel's numbering convention)]
| Write the LAPIC register at the offset specified. The CPU can be optionally
| specified.
end

# lapic_dump [lcpu]
define lapic_dump
   if (($kgm_mtype & $kgm_mtype_x86_mask) != $kgm_mtype_x86_any)
       printf "lapic_dump not supported on this architecture.\n"
   else
       set $lcpu = $kgm_lcpu_self
       if $argc > 0
       	  set $lcpu = $arg0
       end

       _lapic_addr_value $_lapic_id $lcpu

       # the above also figures out if we're using an xAPIC or an x2APIC
       printf "LAPIC operating mode: "
       if $_x2apic_enabled
       	  printf "           x2APIC\n"
       else
       	  printf "           xAPIC\n"
       end

       printf "LAPIC[0x%03X] ID:                 0x%08X\n", $_lapic_id, $kgm_lapic_value

       _lapic_addr_value $_lapic_version $lcpu
       set $lvt_num = ($kgm_lapic_value >> 16) + 1
       printf "LAPIC[0x%03X] VERSION:            0x%08X [VERSION=%d MaxLVT=%d]\n", $_lapic_version, $kgm_lapic_value, $kgm_lapic_value & 0xFF, $lvt_num
       
       _lapic_addr_value $_lapic_tpr $lcpu
       printf "LAPIC[0x%03X] TASK PRIORITY:      0x%08X\n", $_lapic_tpr, $kgm_lapic_value

       _lapic_addr_value $_lapic_ppr $lcpu
       printf "LAPIC[0x%03X] PROCESSOR PRIORITY: 0x%08X\n", $_lapic_ppr, $kgm_lapic_value

       _lapic_addr_value $_lapic_ldr $lcpu
       printf "LAPIC[0x%03X] LOGICAL DEST:       0x%08X\n", $_lapic_ldr, $kgm_lapic_value

       _lapic_addr_value $_lapic_dfr $lcpu
       printf "LAPIC[0x%03X] DEST FORMAT:        0x%08X\n", $_lapic_dfr, $kgm_lapic_value

       _lapic_addr_value $_lapic_sivr $lcpu
       printf "LAPIC[0x%03X] SPURIOUS VECTOR:    0x%08X [VEC=%3d ENABLED=%d]\n", $_lapic_sivr, $kgm_lapic_value, $kgm_lapic_value & $_apic_vector_mask, ($kgm_lapic_value & 0x100) >> 8, 

       set $i = 0
       while $i < $_lapic_isr_num
       	     set $addr = $_lapic_isr0 + $i * $_lapic_isr_size
             _lapic_addr_value $addr $lcpu
             printf "LAPIC[0x%03X] ISR[%03d:%03d]:       0x%08X\n", $addr, 32*($i + 1) - 1,  32*$i, $kgm_lapic_value
	     set $i = $i + 1
       end

       set $i = 0
       while $i < $_lapic_isr_num
       	     set $addr = $_lapic_tmr0 + $i * $_lapic_isr_size
       	     _lapic_addr_value $addr $lcpu
             printf "LAPIC[0x%03X] TMR[%03d:%03d]:       0x%08X\n", $addr, 32*($i + 1) - 1,  32*$i, $kgm_lapic_value
	     set $i = $i + 1
       end

       set $i = 0
       while $i < $_lapic_isr_num
       	     set $addr = $_lapic_irr0 + $i * $_lapic_isr_size
       	     _lapic_addr_value $addr $lcpu
             printf "LAPIC[0x%03X] IRR[%03d:%03d]:       0x%08X\n", $addr, 32*($i + 1) - 1,  32*$i, $kgm_lapic_value
	     set $i = $i + 1
       end

       _lapic_addr_value $_lapic_esr $lcpu
       printf "LAPIC[0x%03X] ERROR STATUS:       0x%08X ", $_lapic_esr, $kgm_lapic_value
       if $kgm_lapic_value
       	  printf "["
       end
       if $kgm_lapic_value & $_lapic_esr_register
       	  printf "Register  "
       end
       if $kgm_lapic_value & $_lapic_esr_recv_vect
       	  printf "Received Vector  "
       end
       if $kgm_lapic_value & $_lapic_esr_send_vect
       	  printf "Send Vector"
       end
       if $kgm_lapic_value
       	  printf "]"
       end
       printf "\n"

       _lapic_addr_value $_lapic_icr1 $lcpu
       printf "LAPIC[0x%03X] Interrupt Command:  0x%08X [DEST=%d]\n", $_lapic_icr0, $kgm_lapic_value, $kgm_lapic_value >> 24
       _lapic_addr_value $_lapic_icr0 $lcpu
       printf "                                 0x%08X ", $kgm_lapic_value
       _apic_print $kgm_lapic_value

       if $lvt_num > 0
       	  _lapic_addr_value $_lapic_lvt_timer $lcpu
	  printf "LAPIC[0x%03X] LVT Timer:          0x%08X ", $_lapic_lvt_timer, $kgm_lapic_value
	  _apic_print $kgm_lapic_value
       end

       if $lvt_num > 1
       	  _lapic_addr_value $_lapic_lvt_lint0 $lcpu
	  printf "LAPIC[0x%03X] LVT LINT0:          0x%08X ", $_lapic_lvt_lint0, $kgm_lapic_value
	  _apic_print $kgm_lapic_value
       end

       if $lvt_num > 2
       	  _lapic_addr_value $_lapic_lvt_lint1 $lcpu
	  printf "LAPIC[0x%03X] LVT LINT1:          0x%08X ", $_lapic_lvt_lint1, $kgm_lapic_value
	  _apic_print $kgm_lapic_value
       end

       if $lvt_num > 3
       	  _lapic_addr_value $_lapic_lvt_error $lcpu
	  printf "LAPIC[0x%03X] LVT Error:          0x%08X ", $_lapic_lvt_error, $kgm_lapic_value
	  _apic_print $kgm_lapic_value
       end

       if $lvt_num > 4
       	  _lapic_addr_value $_lapic_lvt_pmcr $lcpu
	  printf "LAPIC[0x%03X] LVT PerfMon:        0x%08X ", $_lapic_lvt_pmcr, $kgm_lapic_value
	  _apic_print $kgm_lapic_value
       end

       if $lvt_num > 5
       	  _lapic_addr_value $_lapic_lvt_thermal $lcpu
	  printf "LAPIC[0x%03X] LVT Thermal:        0x%08X ", $_lapic_lvt_thermal, $kgm_lapic_value
	  _apic_print $kgm_lapic_value
       end

       _lapic_addr_value $_lapic_dcr $lcpu
       printf "LAPIC[0x%03X] Timer Divide:       0x%08X [Divide by ", $_lapic_dcr, $kgm_lapic_value
       set $kgm_lapic_value = ($kgm_lapic_value & 0x8) >> 1 | $kgm_lapic_value & 0x3
       if $kgm_lapic_value == 0x7
       	  printf "1]\n"
       else
       	  printf "%d]\n", 2 << $kgm_lapic_value
       end

       _lapic_addr_value $_lapic_icr $lcpu
       printf "LAPIC[0x%03X] Timer Init Count:   0x%08X\n", $_lapic_icr, $kgm_lapic_value

       _lapic_addr_value $_lapic_ccr $lcpu
       printf "LAPIC[0x%03X] Timer Cur Count:    0x%08X\n", $_lapic_ccr, $kgm_lapic_value
   end
end

document lapic_dump
Syntax: (gdb) lapic_dump [lcpu (kernel's numbering convention)]
| Dump all the LAPIC entries. The CPU can be optionally specified. 
end
 
define showknoteheader
   printf "            knote       filter           ident  kn_ptr      status\n"
end

define showknoteint
    set $kgm_knotep = ((struct knote *) $arg0)
    printf "            "
    showptr $kgm_knotep
    printf "  "
    set $kgm_filt = -$kgm_knotep->kn_kevent.filter
    if ($kgm_filt == 1)
    	printf "EVFILT_READ    "
    end
    if ($kgm_filt == 2)
        printf "EVFILT_WRITE   "
    end
    if ($kgm_filt == 3)
        printf "EVFILT_AIO     "
    end
    if ($kgm_filt == 4)
        printf "EVFILT_VNODE   "
    end
    if ($kgm_filt == 5)
        printf "EVFILT_PROC    "
    end
    if ($kgm_filt == 6)
        printf "EVFILT_SIGNAL  "
    end
    if ($kgm_filt == 7)
        printf "EVFILT_TIMER   "
    end
    if ($kgm_filt == 8)
        printf "EVFILT_MACHPORT"
    end
    if ($kgm_filt == 9)
        printf "EVFILT_FS      "
    end
    if ($kgm_filt == 10)
        printf "EVFILT_USER    "
    end
    if ($kgm_filt == 11)
        printf "EVFILT_SESSION "
    end
    printf "%7d  ", $kgm_knotep->kn_kevent.ident
    showptr $kgm_knotep->kn_ptr.p_fp
    printf "  "
    if ($kgm_knotep->kn_status == 0)
        printf "-"
    else
        if ($kgm_knotep->kn_status & 0x01)
	    printf "A"
	end
        if ($kgm_knotep->kn_status & 0x02)
	    printf "Q"
	end
        if ($kgm_knotep->kn_status & 0x04)
	    printf "Dis"
	end
        if ($kgm_knotep->kn_status & 0x08)
	    printf "Dr"
	end
        if ($kgm_knotep->kn_status & 0x10)
	    printf "Uw"
	end
        if ($kgm_knotep->kn_status & 0x20)
	    printf "Att"
	end
        if ($kgm_knotep->kn_status & 0x40)
	    printf "Stq"
	end
    end
    printf "\n"
end

define showprocknotes
    showknoteheader
    set $kgm_fdp = ((proc_t)$arg0)->p_fd
    set $kgm_knlist = $kgm_fdp->fd_knlist
    set $i = 0
    while (($i < $kgm_fdp->fd_knlistsize) && ($kgm_knlist != 0))
        set $kgm_kn = ((struct knote *)$kgm_knlist[$i].slh_first)
	while ($kgm_kn != 0)
	    showknoteint $kgm_kn
	    set $kgm_kn = ((struct knote *)$kgm_kn->kn_link.sle_next)
	end
        set $i = $i + 1
    end
    set $kgm_knhash = $kgm_fdp->fd_knhash
    set $i = 0
    while (($i < $kgm_fdp->fd_knhashmask + 1) && ($kgm_knhash != 0))
        set $kgm_kn = ((struct knote *)$kgm_knhash[$i].slh_first)
	while ($kgm_kn != 0)
	    showknoteint $kgm_kn
	    set $kgm_kn = ((struct knote *)$kgm_kn->kn_link.sle_next)
	end
        set $i = $i + 1
    end
end

define showallknotes
    set $kgm_head_taskp = &tasks
    set $kgm_taskp = (struct task *)($kgm_head_taskp->next)
    while $kgm_taskp != $kgm_head_taskp
        showtaskheader
	showtaskint $kgm_taskp
	showprocknotes $kgm_taskp->bsd_info
    	set $kgm_taskp = (struct task *)($kgm_taskp->tasks.next)
    end
end
document showprocknotes 
Syntax: showprocknotes <proc>
| Displays filter and status information for every kevent registered for
| the process.
end

#
# Device node related debug macros
#

define _showtty
	set $kgm_tty = (struct tty *) $arg0
	printf "tty struct at "
	showptr $kgm_tty
	printf "\n"
	printf "-last input to raw queue:\n"
	p $kgm_tty->t_rawq->c_cs
	printf "-last input to canonical queue:\n"
	p $kgm_tty->t_canq->c_cs
	printf "-last output data:\n"
	p $kgm_tty->t_outq->c_cs
	printf "state:\n"
	if ($kgm_tty->t_state & 0x00000001)
		printf "    TS_SO_OLOWAT (Wake up when output <= low water)\n"
	end
	if ($kgm_tty->t_state & 0x00000002)
		printf "    TS_ASYNC (async I/O mode)\n"
	else
		printf "    - (synchronous I/O mode)\n"
	end
	if ($kgm_tty->t_state & 0x00000004)
		printf "    TS_BUSY (Draining output)\n"
	end
	if ($kgm_tty->t_state & 0x00000008)
		printf "    TS_CARR_ON (Carrier is present)\n"
	else
		printf "    - (Carrier is NOT present)\n"
	end
	if ($kgm_tty->t_state & 0x00000010)
		printf "    TS_FLUSH (Outq has been flushed during DMA)\n"
	end
	if ($kgm_tty->t_state & 0x00000020)
		printf "    TS_ISOPEN (Open has completed)\n"
	else
		printf "    - (Open has NOT completed)\n"
	end
	if ($kgm_tty->t_state & 0x00000040)
		printf "    TS_TBLOCK (Further input blocked)\n"
	end
	if ($kgm_tty->t_state & 0x00000080)
		printf "    TS_TIMEOUT (Wait for output char processing)\n"
	end
	if ($kgm_tty->t_state & 0x00000100)
		printf "    TS_TTSTOP (Output paused)\n"
	end
	if ($kgm_tty->t_state & 0x00000200)
		printf "    TS_WOPEN (Open in progress)\n"
	end
	if ($kgm_tty->t_state & 0x00000400)
		printf "    TS_XCLUDE (Tty requires exclusivity)\n"
	end
	if ($kgm_tty->t_state & 0x00000800)
		printf "    TS_BKSL (State for lowercase \\ work)\n"
	end
	if ($kgm_tty->t_state & 0x00001000)
		printf "    TS_CNTTB (Counting tab width, ignore FLUSHO)\n"
	end
	if ($kgm_tty->t_state & 0x00002000)
		printf "    TS_ERASE (Within a \\.../ for PRTRUB)\n"
	end
	if ($kgm_tty->t_state & 0x00004000)
		printf "    TS_LNCH (Next character is literal)\n"
	end
	if ($kgm_tty->t_state & 0x00008000)
		printf "    TS_TYPEN (Retyping suspended input (PENDIN))\n"
	end
	if ($kgm_tty->t_state & 0x00010000)
		printf "    TS_CAN_BYPASS_L_RINT (Device in "raw" mode)\n"
	end
	if ($kgm_tty->t_state & 0x00020000)
		printf "    TS_CONNECTED (Connection open)\n"
	else
		printf "    - (Connection NOT open)\n"
	end
	if ($kgm_tty->t_state & 0x00040000)
		printf "    TS_SNOOP (Device is being snooped on)\n"
	end
	if ($kgm_tty->t_state & 0x80000)
		printf "    TS_SO_OCOMPLETE (Wake up when output completes)\n"
	end
	if ($kgm_tty->t_state & 0x00100000)
		printf "    TS_ZOMBIE (Connection lost)\n"
	end
	if ($kgm_tty->t_state & 0x00200000)
		printf "    TS_CAR_OFLOW (For MDMBUF - handle in driver)\n"
	end
	if ($kgm_tty->t_state & 0x00400000)
		printf "    TS_CTS_OFLOW (For CCTS_OFLOW - handle in driver)\n"
	end
	if ($kgm_tty->t_state & 0x00800000)
		printf "    TS_DSR_OFLOW (For CDSR_OFLOW - handle in driver)\n"
	end
	# xxx todo: do we care about decoding flags?
	printf "flags:                    0x%08x\n", $kgm_tty->t_flags
	printf "foreground process group: "
	showptr $kgm_tty->t_pgrp
	printf "\n"
	printf "enclosing session:        "
	showptr $kgm_tty->t_session
	printf "\n"
	printf "Termios:\n"
	# XXX todo: decode these flags, someday
	printf "    Input flags:   0x%08x\n", $kgm_tty->t_termios.c_iflag
	printf "    Output flags:  0x%08x\n", $kgm_tty->t_termios.c_oflag
	printf "    Control flags: 0x%08x\n", $kgm_tty->t_termios.c_cflag
	printf "    Local flags:   0x%08x\n", $kgm_tty->t_termios.c_lflag
	printf "    Input speed:   %d\n",  $kgm_tty->t_termios.c_ispeed
	printf "    Output speed:  %d\n",  $kgm_tty->t_termios.c_ospeed
	# XXX todo: useful to decode t_winsize? t_iokit? c_cc? anything else?
	printf "high watermark: %d bytes\n", $kgm_tty->t_hiwat
	printf "low watermark: %d bytes\n", $kgm_tty->t_lowat
end

define _showwhohas
	# _showwhohas <major> <minor>
	printf "fd     "
	printf "fileglob    "
showptrhdrpad
	printf "vnode       "
showptrhdrpad
	printf "process     "
showptrhdrpad
	printf "name\n"

	set $kgm_swh_devnode_dev = (((int) $arg0) << 24) | (int) $arg1
	# iterate all tasks to iterate all processes to iterate all
	# open files in each process to see who has a given major/minor
	# device open
	set $kgm_taskp = (struct task *)($kgm_head_taskp->next)
	while $kgm_taskp != $kgm_head_taskp
		set $kgm_procp = (proc_t) $kgm_taskp->bsd_info
		set $kgm_spf_filedesc = $kgm_procp->p_fd
		set $kgm_spf_last = $kgm_spf_filedesc->fd_lastfile
		set $kgm_spf_ofiles = $kgm_spf_filedesc->fd_ofiles
		set $kgm_spf_count = 0
		while (($kgm_spf_ofiles != 0) && ($kgm_spf_count <= $kgm_spf_last))
		    # only files currently open
		    if ($kgm_spf_ofiles[$kgm_spf_count] != 0)
			set $kgm_spf_fg = $kgm_spf_ofiles[$kgm_spf_count].f_fglob
			if ($kgm_spf_fg->fg_type == 1)
			    # display fd #, fileglob & vnode address, proc name
			    set $kgm_swh_m_vnode = (vnode_t) $kgm_spf_fg->fg_data
			    set $kgm_swh_m_vtype = (enum vtype) $kgm_swh_m_vnode->v_type
			    if (($kgm_swh_m_vtype == VBLK) || ($kgm_swh_m_vtype == VCHR)) && ((((devnode_t *)$kgm_swh_m_vnode->v_data)->dn_typeinfo.dev) == $kgm_swh_devnode_dev)
			    	printf "%-5d  ", $kgm_spf_count
				showptr  $kgm_spf_fg
				printf "  "
				showptr $kgm_swh_m_vnode
				printf "  "
				showptr $kgm_procp
				printf "  %s\n", $kgm_procp->p_comm
			    end
			end
		    end
		    set $kgm_spf_count = $kgm_spf_count + 1
		end

		set $kgm_taskp = (struct task *)($kgm_taskp->tasks.next)
	end
end

define _showvnodedev_cpty
	set $kgm_ptmx_major = (int) $arg0
	set $kgm_ptmx_minor = (int) $arg1
	set $kgm_ptmx_ioctl = _state.pis_ioctl_list[$kgm_ptmx_minor]
	set $kgm_ptmx_ioctl = _state.pis_ioctl_list[$kgm_ptmx_minor]
	printf "    ptmx_ioctl struct at "
	showptr $kgm_ptmx_ioctl
	printf "\n"
	printf "    flags:\n"
	if ($kgm_ptmx_ioctl->pt_flags & 0x0008)
		printf "        PF_PKT (packet mode)\n"
	end
	if ($kgm_ptmx_ioctl->pt_flags & 0x0010)
		printf "        PF_STOPPED (user told stopped)\n"
	end
	if ($kgm_ptmx_ioctl->pt_flags & 0x0020)
		printf "        PF_REMOTE (remote and flow controlled input)\n"
	end
	if ($kgm_ptmx_ioctl->pt_flags & 0x0040)
		printf "        PF_NOSTOP"
	end
	if ($kgm_ptmx_ioctl->pt_flags & 0x0080)
		printf "        PF_UCNTL (user control mode)\n"
	end
	if ($kgm_ptmx_ioctl->pt_flags & 0x0100)
		printf "        PF_UNLOCKED (slave unlock - master open resets)\n"
	end
	if ($kgm_ptmx_ioctl->pt_flags & 0x0200)
		printf "        PF_OPEN_M (master is open)\n"
		# XXX we should search for who has the master open, but
		# XXX each master gets the same minor, even though it
		# XXX gets a different vnode.  we chold probably change
		# XXX this, but to do it we would need some way of
		# XXX expressing the information in the vnode structure
		# XXX somewhere.  If we *did* change it, it would buy us
		# XXX the ability to determine who has the corresponding
		# XXX master end of the pty open
	else
		printf "        PF_OPEN_M (master is closed)\n"
	end
	if ($kgm_ptmx_ioctl->pt_flags & 0x0400)
		printf "        PF_OPEN_S (slave is open)\n"
		printf "---vvvvv--- fds open on this device ---vvvvv---\n"
		_showwhohas  ($kgm_ptmx_major) ($kgm_ptmx_minor)
		printf "---^^^^^--- fds open on this device ---^^^^^---\n"
	else
		printf "        - (slave is closed)\n"
	end
	printf "TTY Specific Information\n"
	_showtty $kgm_ptmx_ioctl->pt_tty
end

define showvnodedev
    if ($argc == 1)
	set $kgm_vnode = (vnode_t) $arg0
	set $kgm_vtype = (enum vtype) $kgm_vnode->v_type
	if (($kgm_vtype == VBLK) || ($kgm_vtype == VCHR))
		set $kgm_devnode = (devnode_t *) $kgm_vnode->v_data
		set $kgm_devnode_dev = $kgm_devnode->dn_typeinfo.dev
		set $kgm_devnode_major = ($kgm_devnode_dev >> 24) & 0xff
		set $kgm_devnode_minor = $kgm_devnode_dev & 0x00ffffff

		# boilerplate device information for a vnode 
		printf "Device Info:\n"
		printf "    vnode:        "
		showptr $kgm_vnode
		printf "\n"
		printf "    type:         "
		if ($kgm_vtype == VBLK)
			printf "VBLK "
		end
		if ($kgm_vtype == VCHR)
			printf "VCHR"
		end
		printf "\n"
		printf "    name:         %s\n", $kgm_vnode->v_name
		printf "    major, minor: %d, %d\n", $kgm_devnode_major, $kgm_devnode_minor
		printf "    mode          0%o\n", $kgm_devnode->dn_mode
		printf "    owner (u,g):  %d %d", $kgm_devnode->dn_uid, $kgm_devnode->dn_gid
		printf "\n"

		# decode device specific data
		printf "Device Specific Information:  "
		if ($kgm_vtype == VBLK)
			printf "    Sorry, I do not know how to decode block devices yet!\n"
			printf "    Maybe you can write me!"
		end
		if ($kgm_vtype == VCHR)
			# Device information; this is scanty
			# range check
			if ($kgm_devnode_major > 42) || ($kgm_devnode_major < 0)
				printf "Invalid major #\n"
			else
			# static assignments in conf
			if ($kgm_devnode_major == 0)
				printf "Console mux device\n"
			else
			if ($kgm_devnode_major == 2)
				printf "Current tty alias\n"
			else
			if ($kgm_devnode_major == 3)
				printf "NULL device\n"
			else
			if ($kgm_devnode_major == 4)
				printf "Old pty slave\n"
			else
			if ($kgm_devnode_major == 5)
				printf "Old pty master\n"
			else
			if ($kgm_devnode_major == 6)
				printf "Kernel log\n"
			else
			if ($kgm_devnode_major == 12)
				printf "Memory devices\n"
			else
			# Statically linked dynamic assignments
			if cdevsw[$kgm_devnode_major].d_open == ptmx_open
				printf "Cloning pty master\n"
				_showvnodedev_cpty ($kgm_devnode_major) ($kgm_devnode_minor)
			else
			if cdevsw[$kgm_devnode_major].d_open == ptsd_open
				printf "Cloning pty slave\n"
				_showvnodedev_cpty ($kgm_devnode_major) ($kgm_devnode_minor)
			else
				printf "RESERVED SLOT\n"
			end
			end
			end
			end
			end
			end
			end
			end
			end
			end
		end
	else
		showptr $kgm_vnode
		printf " is not a device\n"
	end
    else
    	printf "| Usage:\n|\n"
	help showvnodedev
    end
end
document showvnodedev
Syntax: (gdb) showvnodedev <vnode>
|     showvnodedev       Display information about a device vnode
end

define showtty
    if ($argc == 1)
	_showtty $arg0
    else
    	printf "| Usage:\n|\n"
	help showtty
    end
end
document showtty
Syntax: (gdb) showtty <tty struct>
|     showtty            Display information about a struct tty
end

define showeventsourceobject
    set $kgm_vt = *((void **) $arg1)
    if $kgm_lp64
        set $kgm_vt = $kgm_vt - 16
    end
    pcprint $kgm_vt
end
document showeventsourceobject
Syntax: (gdb) showeventsourceobject <prefix> <object>
| Routine to display information about an IOEventSource subclass.
end

define showworkloopallocator
	set $kgm_workloop = (struct IOWorkLoop*)$arg0
	set $kgm_bt = (void**)$kgm_workloop->reserved->allocationBacktrace
	set $kgm_bt_count = 0
	while $kgm_bt_count != (sizeof(IOWorkLoop::ExpansionData.allocationBacktrace) / sizeof(IOWorkLoop::ExpansionData.allocationBacktrace[0]))
		set $kgm_frame_address = (void*)$kgm_bt[$kgm_bt_count]
		if $kgm_frame_address != 0
			if (((unsigned long) $kgm_frame_address < (unsigned long) &_mh_execute_header || \
			     (unsigned long) $kgm_frame_address >= (unsigned long) &last_kernel_symbol ) \
			    && ($kgm_show_kmod_syms == 0))
				showkmodaddr $kgm_frame_address
			else
				output /a $kgm_frame_address
			end
			printf "\n"
		end
		set $kgm_bt_count = $kgm_bt_count + 1
	end
end
document showworkloopallocator
Syntax: (gdb) showworkloopallocator <workloop>
| Routine to display the backtrace of the thread which allocated the workloop in question. Only
| valid on DEBUG kernels.
end

define showworkloopeventsources
	set $kgm_eventsource = (struct IOEventSource*)$arg0
    while $kgm_eventsource != 0
    	printf "     "
    	printf "EventSource:\t"
    	showptr $kgm_eventsource
    	printf " Description: "
    	showeventsourceobject _ $kgm_eventsource
    	printf "\n"
    	if $kgm_eventsource->action != 0
	    	printf "          "
			printf "Action: \t"
    		pcprint $kgm_eventsource->action
    		printf "\n"
    	end
    	if $kgm_eventsource->owner != 0
	    	printf "          "
			printf "Owner: \t"
			showptr	$kgm_eventsource->owner
			printf " Description: "
			showeventsourceobject _ $kgm_eventsource->owner
    		printf "\n"
    	end
    	set $kgm_eventsource = $kgm_eventsource->eventChainNext
    	printf "\n"
    end
end
document showworkloopeventsources
Syntax: (gdb) showworkloopeventsources
| Routine to walk an IOEventSource chain associated with an IOWorkLoop and print information
| about each event source in the chain.
end

define showworkloopheader
    printf "thread    "
    showptrhdrpad
    printf "  workloop "
    showptrhdrpad
    printf "    pri state\tLockGroupName\n"
end
document showworkloopheader
Syntax: (gdb) showworkloopheader
| Routine to print out header info about an IOKit workloop.
end

define showworkloop
	set $kgm_workloopthread = (struct thread*)$arg0
	set $kgm_workloop = (struct IOWorkLoop*)$arg1
    showptr $kgm_workloopthread
	printf "  "
	showptr $kgm_workloop
	printf "   %3d ", $kgm_workloopthread.sched_pri
	set $kgm_state = $kgm_workloopthread.state
	if $kgm_state & 0x80
	    printf "I" 
	end
	if $kgm_state & 0x40
	    printf "P" 
	end
	if $kgm_state & 0x20
	    printf "A" 
	end
	if $kgm_state & 0x10
	    printf "H" 
	end
	if $kgm_state & 0x08
	    printf "U" 
	end
	if $kgm_state & 0x04
	    printf "R" 
	end
	if $kgm_state & 0x02
	    printf "S" 
	end
   	if $kgm_state & 0x01
	    printf "W"
	end
	printf "\t\t"
	set $kgm_gateLock = ( struct _IORecursiveLock *)$kgm_workloop->gateLock
	if $kgm_gateLock != 0
		set $kgm_lockGroup = (struct _lck_grp_*)($kgm_gateLock->group)
		printf "%s", $kgm_lockGroup->lck_grp_name
	else
		printf "No WorkLoop Lock found"
	end
	printf "\n\n"
	
	#Allocation backtrace is only valid on DEBUG kernels.
	#printf "Allocation path:\n\n"
	#showworkloopallocator $kgm_workloop
	#printf "\n\n"
	
	if $kgm_workloop->eventChain != 0
		printf "Active event sources:\n\n"
		showworkloopeventsources $kgm_workloop->eventChain
	end
	if $kgm_workloop->reserved->passiveEventChain != 0
		printf "Passive event sources:\n"
		showworkloopeventsources $kgm_workloop->reserved->passiveEventChain
	end
end
document showworkloop
Syntax: (gdb) showworkloop <thread> <workloop>
| Routine to print out info about an IOKit workloop.
end

define showallworkloopthreads
    set $kgm_head_taskp = &tasks
    set $kgm_taskp = (struct task *)($kgm_head_taskp->next)
	set $kgm_head_actp = &($kgm_taskp->threads)
	set $kgm_actp = (struct thread *)($kgm_taskp->threads.next)
	while $kgm_actp != $kgm_head_actp
		if ($kgm_actp->continuation == _ZN10IOWorkLoop10threadMainEv)
			showworkloopheader
			showworkloop $kgm_actp $kgm_actp->parameter
		else
			if ($kgm_actp->kernel_stack != 0)
				if ($kgm_mtype == $kgm_mtype_x86_64)
					#Warning: Grokking stack looking for hopeful workloops until we squirrel some info in thread_t.
					set $kgm_workloop = *((struct IOWorkLoop **)($kgm_actp->kernel_stack + kernel_stack_size - 0xB8))
				else
					if ($kgm_mtype == $kgm_mtype_i386)
						set $kgm_workloop = *((struct IOWorkLoop **)($kgm_actp->kernel_stack + kernel_stack_size - 0x3C))
					end
				end
				if ($kgm_workloop != 0)
					set $kgm_vt = *((void **) $kgm_workloop)
					if $kgm_lp64
						set $kgm_vt = $kgm_vt - 16
					end
					if ($kgm_vt == &_ZTV10IOWorkLoop)
						showworkloopheader
						showworkloop $kgm_actp $kgm_workloop
					end
				end
			end
		end
		set $kgm_actp = (struct thread *)($kgm_actp->task_threads.next)
	end
	printf "\n"
end
document showallworkloopthreads
Syntax: (gdb) showallworkloopthreads
| Routine to print out info about all IOKit workloop threads in the system. This macro will find
| all IOWorkLoop threads blocked in continuations and on i386 and x86_64 systems will make a
| best-effort guess to find any workloops that are actually not blocked in a continuation. For a
| complete list, it is best to compare the output of this macro against the output of 'showallstacks'.
end

define showthreadfortid
	set $kgm_id_found = 0
	
	set $kgm_head_taskp = &tasks
	set $kgm_taskp = (struct task *)($kgm_head_taskp->next)
	while $kgm_taskp != $kgm_head_taskp
		set $kgm_head_actp = &($kgm_taskp->threads)
		set $kgm_actp = (struct thread *)($kgm_taskp->threads.next)
		while $kgm_actp != $kgm_head_actp
			set $kgm_thread = *(struct thread *)$kgm_actp
			set $kgm_thread_id = $kgm_thread.thread_id
			if ($kgm_thread_id == $arg0)
				showptr $kgm_actp
				printf "\n"
				set $kgm_id_found = 1
				loop_break
			end
			set $kgm_actp = (struct thread *)($kgm_actp->task_threads.next)
		end
		if ($kgm_id_found == 1)
			loop_break
		end
		set $kgm_taskp = (struct task *)($kgm_taskp->tasks.next)
	end
	if ($kgm_id_found == 0)
		printf  "Not a valid thread_id\n"
	end
end

document showthreadfortid
Syntax:  showthreadfortid  <thread_id>
|The thread structure contains a unique thread_id value for each thread.
|This command is used to retrieve the address of the thread structure(thread_t) 
|corresponding to a given thread_id.
end

define showtaskbusyportsint
    set $kgm_isp = ((task_t)$arg0)->itk_space
	set $kgm_iindex = 0
	while ( $kgm_iindex < $kgm_isp->is_table_size )
		set $kgm_iep = &($kgm_isp->is_table[$kgm_iindex])
		if $kgm_iep->ie_bits & 0x00020000
			set $kgm_port = ((ipc_port_t)$kgm_iep->ie_object)
			if $kgm_port->ip_messages.data.port.msgcount > 0
				showport $kgm_port
			end
		end
		set $kgm_iindex = $kgm_iindex + 1
	end
end

define showtaskbusyports
    showtaskbusyportsint $arg0
end

document showtaskbusyports
Syntax:  showtaskbusyports <task>
|Routine to print information about receive rights belonging to this task that
|have enqueued messages. This is often a sign of a blocked or hung process.
end

define showallbusyports
    set $kgm_head_taskp = &tasks
    set $kgm_cur_taskp = (struct task *)($kgm_head_taskp->next)
    while $kgm_cur_taskp != $kgm_head_taskp
		showtaskbusyportsint $kgm_cur_taskp
    	set $kgm_cur_taskp = (struct task *)($kgm_cur_taskp->tasks.next)
    end
end

document showallbusyports
Syntax:  showallbusyports
|Routine to print information about all receive rights on the system that
|have enqueued messages.
end

define showallproviders
    set $kgm_providerp = dtrace_provider
    while $kgm_providerp
        p *(dtrace_provider_t *)$kgm_providerp
        printf "\n"
        set $kgm_providerp = (dtrace_provider_t *)($kgm_providerp->dtpv_next)
    end
end

document showallproviders
Syntax: showallproviders
| Display summary listing of all dtrace_providers
end

define showmodctlheader
    printf   "modctl    "
    showptrhdrpad
    printf "  stale     "
    showptrhdrpad
    printf "  symbols   "
    showptrhdrpad
    printf "  address   "
    showptrhdrpad
    printf "  size      "
    showptrhdrpad
    printf "  loadid    loaded  nenabled  flags      name\n"
end

define showmodctlint
    set $kgm_modctlp = (struct modctl *)$arg0
    showptr $kgm_modctlp
    printf "  "
    showptr $kgm_modctlp->mod_stale
    printf "  "
    showptr $kgm_modctlp->mod_user_symbols
    printf "  "
    showptr $kgm_modctlp->mod_address
    printf "  "
    showptr $kgm_modctlp->mod_size
    printf "  "
    printf "%6d  ", $kgm_modctlp->mod_loadcnt
    printf "%6d  ", $kgm_modctlp->mod_loaded
    printf "%6d  ", $kgm_modctlp->mod_nenabled
    printf "    0x%x  ", $kgm_modctlp->mod_flags
    printf "%s\n", $kgm_modctlp->mod_modname
end

define showmodctl
    showmodctlheader
    showmodctlint $arg0
end
document showmodctl
Syntax: (gdb) showmodctl <addr>
| Display info about a dtrace modctl
end

define showallmodctls
    showmodctlheader
    set $kgm_modctlp = (struct modctl *)dtrace_modctl_list
    while $kgm_modctlp
        showmodctlint $kgm_modctlp
        set $kgm_modctlp = $kgm_modctlp->mod_next
    end
end
document showallmodctls
Syntax: (gdb) showallmodctls
| Display summary listing of all dtrace modctls
end

define showfbtprobe
  printf "Be very patient, this traverses a large list \n"
  set $kgm_indx = 0
  set $kgm_found = 0
  set $kgm_depth = 0
  while $kgm_indx < fbt_probetab_size && !$kgm_found
    set $kgm_fbt_probep = (struct fbt_probe *)fbt_probetab[$kgm_indx]
    set $kgm_depth = 0
    if $kgm_fbt_probep
      set $kgm_probeid = (struct fbt_probe *)$kgm_fbt_probep->fbtp_id
      if $kgm_probeid == $arg0
        set $kgm_found = 1
        loop_break
      else
	set $kgm_fbt_probep = $kgm_fbt_probep->fbtp_hashnext
	while $kgm_fbt_probep
	  set $kgm_depth++
	  set $kgm_probeid = (struct fbt_probe *)$kgm_fbt_probep->fbtp_id
	  if $kgm_probeid == $arg0
	    set $kgm_found = 1
	    loop_break
	  else
	    set $kgm_fbt_probep = $kgm_fbt_probep->fbtp_hashnext
	  end
        end
      end
    end
    if !$kgm_found
      set $kgm_indx++
    else
      printf "fbt_probetab[index=%d], depth=%d, 0x%x\n", $kgm_indx, $kgm_depth, $kgm_fbt_probep
      printf "(gdb) p *(struct fbt_probe *)0x%x\n", $kgm_fbt_probep
      p *(struct fbt_probe *)$kgm_fbt_probep
      set $kgm_fbtp_ctl = (struct fbt_probe *)$kgm_fbt_probep->fbtp_ctl
      showmodctl $kgm_fbtp_ctl
      loop_break
    end
  end
end
document showfbtprobe
Syntax: (gdb) showfbtprobe <id>
| Display info about an fbt probe given an id.
| Traverses fbt_probetab and matches <id> with fbtp_id.
| The <id> is found using dtrace -l
end

define showzstacktrace
	set $kgm_trace = (void*)$arg0
	if ($argc == 1)
		set $kgm_trace_size = 15
	end
	if ($argc == 2)
		set $kgm_trace_size = $arg1
	end
	set $kgm_trace_current = 0
	while ($kgm_trace_current < $kgm_trace_size)
		set $kgm_trace_addr = (void**)$kgm_trace + $kgm_trace_current
		set $kgm_trace_value = *((void**)$kgm_trace_addr) 
		#printf "\t\t"
		output /a $kgm_trace_value
		set $kgm_trace_current = $kgm_trace_current + 1
		printf "\n"
	end
end

document showzstacktrace
Syntax:  showzstacktrace <saved stacktrace> [size]
| Routine to print a stacktrace stored by OSBacktrace.
| size is optional, defaults to 15.
end

define showzalloc
	set $kgm_zallocation = zallocations[$arg0]
	print $kgm_zallocation
	showztrace $kgm_zallocation->za_trace_index
end

document showzalloc
Syntax:  showzalloc <index>
| Prints a zallocation from the zallocations array based off its index, 
| and prints the associated symbolicated backtrace.
end

define showztrace
	set $kgm_ztrace = &ztraces[$arg0]
	showztraceaddr $kgm_ztrace
end

document showztrace
Syntax:  showztrace <trace index>
| Prints the backtrace from the ztraces array at index
end

define showztraceaddr
	print *$arg0
	showzstacktrace $arg0->zt_stack ($arg0)->zt_depth
end

document showztraceaddr
Syntax:  showztraceaddr <trace address>
| Prints the struct ztrace passed in
end

#TODO: Iterate through the hash table, or make top_ztrace accurate in the face of deallocations (better idea).
define showtopztrace
	set $kgm_top_ztrace = top_ztrace
	printf "Index: %d\n", (top_ztrace - ztraces)
	showztraceaddr $kgm_top_ztrace
end

document showtopztrace
Syntax:  showtopztrace 
| Shows the ztrace with the biggest size. (according to top_ztrace, not by iterating through the hash table)
end

define showzallocs
	set $kgm_zallocation_current_index = 0
	set $kgm_zallocations_count = 0
	set $kgm_max_zallocation = zleak_alloc_buckets
	printf "INDEX  ADDRESS     "
	if $kgm_lp64
        printf "         "
    end
	printf "TRACE   SIZE\n"
	while ($kgm_zallocation_current_index < $kgm_max_zallocation)
		set $kgm_zallocation_current = zallocations[$kgm_zallocation_current_index]
		if ($kgm_zallocation_current->element != 0)
			printf "%5d  %p   ", $kgm_zallocation_current_index, $kgm_zallocation_current->za_element
			printf "%5d %6lu\n", $kgm_zallocation_current->za_trace_index, $kgm_zallocation_current->za_size
			set $kgm_zallocations_count = $kgm_zallocations_count + 1
		end
		set $kgm_zallocation_current_index = $kgm_zallocation_current_index + 1
	end
	printf "Total allocations: %d\n", $kgm_zallocations_count
end

document showzallocs
Syntax:  showzallocs
| Prints all allocations in the zallocations table
end

define showzallocsfortrace
	set $kgm_zallocation_current_index = 0
	set $kgm_zallocations_count = 0
	set $kgm_max_zallocation = zleak_alloc_buckets
	printf "INDEX  ADDRESS     "
	if $kgm_lp64
        printf "         "
    end
	printf "SIZE\n"
	while ($kgm_zallocation_current_index < $kgm_max_zallocation)
		set $kgm_zallocation_current = zallocations[$kgm_zallocation_current_index]
		if ($kgm_zallocation_current->element != 0 && $kgm_zallocation_current->za_trace_index == $arg0)
			printf "%5d  %p ", $kgm_zallocation_current_index, $kgm_zallocation_current->za_element
			printf "%6lu\n", $kgm_zallocation_current->size
			set $kgm_zallocations_count = $kgm_zallocations_count + 1
		end
		set $kgm_zallocation_current_index = $kgm_zallocation_current_index + 1
	end
	printf "Total allocations: %d\n", $kgm_zallocations_count
end

document showzallocsfortrace
Syntax:  showzallocsfortrace <trace index>
| Prints all allocations pointing to the passed in trace's index into ztraces by looking through zallocations table
end

define showztraces
	showztracesabove 0
end

document showztraces
Syntax:  showztraces
| Prints all traces with size > 0
end

define showztracesabove
	set $kgm_ztrace_current_index = 0
	set $kgm_ztrace_count = 0
	set $kgm_max_ztrace = zleak_trace_buckets
	printf "INDEX    SIZE\n"
	while ($kgm_ztrace_current_index < $kgm_max_ztrace)
		set $kgm_ztrace_current = ztraces[$kgm_ztrace_current_index]
		if ($kgm_ztrace_current->zt_size > $arg0)
			printf "%5d  %6lu\n", $kgm_ztrace_current_index, $kgm_ztrace_current->zt_size
			set $kgm_ztrace_count = $kgm_ztrace_count + 1
		end
		set $kgm_ztrace_current_index = $kgm_ztrace_current_index + 1
	end
	printf "Total traces: %d\n", $kgm_ztrace_count
end

document showztracesabove
Syntax:  showztracesabove <size>
| Prints all traces with size greater than X
end

define showztracehistogram
	set $kgm_ztrace_current_index = 0
	set $kgm_ztrace_count = 0
	set $kgm_max_ztrace = zleak_trace_buckets
	printf "INDEX  HIT_COUNT  COLLISIONS\n"
	while ($kgm_ztrace_current_index < $kgm_max_ztrace)
		set $kgm_ztrace_current = ztraces[$kgm_ztrace_current_index]
		if ($kgm_ztrace_current->zt_hit_count != 0)
			printf "%5d      %5d    %5d\n", $kgm_ztrace_current_index, $kgm_ztrace_current->zt_hit_count, $kgm_ztrace_current->zt_collisions
			set $kgm_ztrace_count = $kgm_ztrace_count + 1
		end
		set $kgm_ztrace_current_index = $kgm_ztrace_current_index + 1
	end
	printf "Total traces: %d\n", $kgm_ztrace_count
end

document showztracehistogram
Syntax:  showztracehistogram
| Prints the histogram of the ztrace table
end

define showzallochistogram
	set $kgm_zallocation_current_index = 0
	set $kgm_zallocations_count = 0
	set $kgm_max_zallocation = zleak_alloc_buckets
	printf "INDEX  HIT_COUNT\n"
	while ($kgm_zallocation_current_index < $kgm_max_zallocation)
		set $kgm_zallocation_current = zallocations[$kgm_zallocation_current_index]
		if ($kgm_zallocation_current->za_hit_count != 0)
			printf "%5d      %5d\n", $kgm_zallocation_current_index, $kgm_zallocation_current->za_hit_count
			set $kgm_zallocations_count = $kgm_zallocations_count + 1
		end
		set $kgm_zallocation_current_index = $kgm_zallocation_current_index + 1
	end
	printf "Total allocations: %d\n", $kgm_zallocations_count
end

document showzallochistogram
Syntax:  showzallochistogram
| Prints the histogram for the zalloc table
end

define showzstats
	printf "z_alloc_collisions: %u, z_trace_collisions: %u\n", z_alloc_collisions, z_trace_collisions
	printf "z_alloc_overwrites: %u, z_trace_overwrites: %u\n", z_alloc_overwrites, z_trace_overwrites
	printf "z_alloc_recorded: %u, z_trace_recorded: %u\n", z_alloc_recorded, z_trace_recorded
end

document showzstats
Syntax:  showzstats
| Prints the zone leak detection stats
end


set $kgm_au_sentry_hash_table_size = 97

define showsession1
  set $p = (struct au_sentry *)$arg0
  showptr $p
  printf "  0x%08x  0x%08x  0x%016x", $p->se_auinfo.ai_asid, $p->se_auinfo.ai_auid, $p->se_auinfo.ai_flags
  printf "  %3ld  %3ld", $p->se_refcnt, $p->se_procnt
  printf "\n"
end

define showsessionhdr
  printf "au_sentry "
  showptrhdrpad
  printf "  ASID        AUID        FLAGS               C    P\n"
end

define showsession
  showsessionhdr
  showsession1 $arg0
end

document showsession
Syntax:  showsession
| Display info about a specified audit session
end

define showallsessions
  showsessionhdr
  set $kgm_au_sentry_hash_table = au_sentry_bucket
  set $i = $kgm_au_sentry_hash_table_size - 1
  while $i >= 0
    set $p = $kgm_au_sentry_hash_table[$i].lh_first
    while $p != 0
      showsession1 $p
      set $p = $p->se_link.le_next
    end
    set $i = $i - 1
  end
end

document showallsessions
Syntax:  showallsessions
| Prints the audit sessions in the global hash table
end

define showauhistorystack
  set $ii = $arg0
  set $pp = (void **)$arg1
  while $ii > 0
    printf "  "
    x/i $pp[$ii-1]
    set $ii = $ii - 1
  end
end

define showauhistory1
  set $p = (struct au_history *)$arg0
  set $stack_depth = $p->stack_depth
  set $stack = $p->stack
  showptr $p->ptr
  if $p->event == 1
    printf "    REF"
  end
  if $p->event == 2
    printf "  UNREF"
  end
  if $p->event == 3
    printf "  BIRTH"
  end
  if $p->event == 4
    printf "  DEATH"
  end
  if $p->event == 5
    printf "  FIND"
  end
  set $p = &$p->se
  printf "  0x%08x  0x%08x  0x%016x", $p->se_auinfo.ai_asid, $p->se_auinfo.ai_auid, $p->se_auinfo.ai_flags
  printf "  %3ld  %3ld", $p->se_refcnt, $p->se_procnt
  printf "\n"
  showauhistorystack $stack_depth $stack
end

define showauhistory
  set $i = (au_history_index-1) % au_history_size
  if au_history_index >= au_history_size
    set $n = au_history_size
  else
    set $n = au_history_index
  end
  while $n > 0
    if au_history[$i].ptr != 0 && (0 == $arg0 || au_history[$i].ptr == $arg0)
      printf "[% 4d]  ", $i
      showauhistory1 &au_history[$i]
    end
    set $n = $n - 1
    set $i = ($i - 1) % au_history_size
  end
end

define showallauhistory
  showauhistory 0
end

define showkwqheader
	printf "        kwq     "
    showptrhdrpad
	printf "    kwqaddr     "
    showptrhdrpad
    printf "  inqueue  fakecount  highseq  lowseq   flags   lastunlock    p_rwwc"
    printf "\n          "
end

define showkwqint
	printf "              "
    	set $kgm_kwq = (ksyn_wait_queue_t)$arg0
	showptr $kgm_kwq
	printf "  "
	showptr $kgm_kwq->kw_addr
	printf "   "
	printf "  %d      ", $kgm_kwq->kw_inqueue
	printf "    %d  ", $kgm_kwq->kw_fakecount
	printf "     0x%x  ", $kgm_kwq->kw_highseq
	printf "  0x%x  ", $kgm_kwq->kw_lowseq
	printf "  0x%x  ", $kgm_kwq->kw_flags
	printf "  0x%x  ", $kgm_kwq->kw_lastunlockseq
	printf "    0x%x  ", $kgm_kwq->kw_pre_rwwc
	printf "\n"
end

define show_kwq
	showkwqheader
	showkwqint $arg0
end

document show_kwq
Syntax: (gdb) show_kwq <kwq>
| Display info about one ksyn_wait_queue
end

# Internal routine used by "showpthread_mutex" to abstract possible loads from
# user space
define _loadfrommutex
        if (kdp_pmap == 0)
                set $kgm_loadval = *(uintptr_t *)$arg0
        else
        if ($kgm_x86_abi == 0xe)
              set $kgm_loadval = *(uint32_t *)$arg0
        else
        if ($kgm_x86_abi == 0xf)
            if ($kgm_mtype == $kgm_mtype_i386)
                    _loadk32m64 $arg0
                    set $kgm_loadval = $kgm_k32read64  
            else
                    set $kgm_loadval = *(uint32_t *)$arg0
            end
        end
        end
end
end

define show_pthreadmutex
	set $newact = (struct thread *) $arg0
	set $ourtask = (struct task *)($newact->task)
    	set $our_user_is64 = ($ourtask->taskFeatures[0] & 0x80000000)
	_kgm_flush_loop
	set $mutex = (void *)$arg1
	set kdp_pmap = $newact->task->map->pmap
	_kgm_flush_loop
	_kgm_update_loop
	set $newiss = (x86_saved_state_t *) ($newact->machine.pcb->iss)
	set $kgm_x86_abi = $newiss.flavor
	if ($our_user_is64 != 0)
		printf "\tUser 64Bit\n "
		printf "\tSignature: "
		set $nextval = $mutex
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
		printf "\tflags: "
		set $nextval = $mutex + 12
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
		printf "\tSeqs: "
		set $nextval = $mutex + 20
		_loadfrommutex $nextval
		printf "0x%x   ",$kgm_loadval
		set $nextval = $mutex + 24
		_loadfrommutex $nextval
		printf "0x%x   ",$kgm_loadval
		set $nextval = $mutex + 28
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
		printf "\ttid[0]: "
		set $nextval = $mutex + 32
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
		printf "\ttid[1]: "
		set $nextval = $mutex + 36
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
	else
		printf "\tUser 32Bit\n "
		printf "\tSignature: "
		set $nextval = $mutex
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
		printf "\tflags: "
		set $nextval = $mutex + 8
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
		printf "\tSeqs: "
		set $nextval = $mutex + 16
		_loadfrommutex $nextval
		printf "0x%x   ",$kgm_loadval
		set $nextval = $mutex + 20
		_loadfrommutex $nextval
		printf "0x%x   ",$kgm_loadval
		set $nextval = $mutex + 24
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
		printf "\ttid[0]: "
		set $nextval = $mutex + 32
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
		printf "\ttid[1]: "
		set $nextval = $mutex + 36
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
	end
	printf "\n"
	resetstacks
end


document show_pthreadmutex
Syntax: (gdb) show_pthreadmutex <thread> <user_mutexaddr>
| Display the mutex contents from userspace.
end


define show_pthreadcondition
	set $newact = (struct thread *) $arg0
	set $ourtask = (struct task *)($newact->task)
    	set $our_user_is64 = ($ourtask->taskFeatures[0] & 0x80000000)
	_kgm_flush_loop
	set $cond = (void *)$arg1
	set kdp_pmap = $newact->task->map->pmap
	_kgm_flush_loop
	_kgm_update_loop
	set $newiss = (x86_saved_state_t *) ($newact->machine.pcb->iss)
	set $kgm_x86_abi = $newiss.flavor
	if ($our_user_is64 != 0)
		printf "\tUser 64Bit\n "
		printf "\tSignature: "
		set $nextval = $cond
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
		printf "\tflags: "
		set $nextval = $cond + 12
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
		printf "\tSeqs: "
		set $nextval = $cond + 24
		_loadfrommutex $nextval
		printf "0x%x   ",$kgm_loadval
		set $nextval = $cond + 28
		_loadfrommutex $nextval
		printf "0x%x   ",$kgm_loadval
		set $nextval = $cond + 32
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
		printf "\tMutex lowaddr: "
		set $nextval = $cond + 16
		_loadfrommutex $nextval
		printf "0x%08x\n",$kgm_loadval
		printf "\tMutex highaddr: "
		set $nextval = $cond + 20
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
	else
		printf "\tUser 32Bit\n "
		printf "\tSignature: "
		set $nextval = $cond
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
		printf "\tflags: "
		set $nextval = $cond + 8
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
		printf "\tSeqs: "
		set $nextval = $cond + 16
		_loadfrommutex $nextval
		printf "0x%x   ",$kgm_loadval
		set $nextval = $cond + 20
		_loadfrommutex $nextval
		printf "0x%x   ",$kgm_loadval
		set $nextval = $cond + 24
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
		printf "\tMutex addr: "
		set $nextval = $cond + 12
		_loadfrommutex $nextval
		printf "0x%x\n",$kgm_loadval
	end
	printf "\n"
	resetstacks
end


document show_pthreadcondition
Syntax: (gdb) show_pthreadcondition <thread> <user_cvaddr>
| Display the condition variable contents from userspace.
end

define processortimers
    set $kgm_p = processor_list
    printf "Processor\t\t\t Last dispatch\t\t Next deadline\t\t difference\n"
    while $kgm_p
        printf "Processor %d: %p\t", $kgm_p->cpu_id, $kgm_p
        printf " 0x%016llx\t", $kgm_p->last_dispatch
        set $kgm_rt_timer = &(cpu_data_ptr[$kgm_p->cpu_id].rtclock_timer)
        printf " 0x%016llx    \t", $kgm_rt_timer->deadline
        set $kgm_rt_diff =  ((long long)$kgm_p->last_dispatch) - ((long long)$kgm_rt_timer->deadline)
        printf " 0x%016llx  ", $kgm_rt_diff
# normally the $kgm_rt_diff will be close to the last dispatch time, or negative 
# When it isn't, mark the result as bad. This is a suggestion, not an absolute
        if ( ($kgm_rt_diff > 0) && ((long long)$kgm_p->last_dispatch) - ($kgm_rt_diff + 1) > 0 )
            printf "probably BAD\n"
        else
            printf "(ok)\n"
        end
        # dump the call entries (Intel only)
        if (($kgm_mtype & $kgm_mtype_x86_mask) == $kgm_mtype_x86_any)
            printf "Next deadline set at: 0x%016llx. Timer call list:", $kgm_rt_timer->when_set
            set $kgm_entry = (queue_t *)$kgm_rt_timer->queue
            if ($kgm_entry == $kgm_rt_timer)
                printf " (empty)\n"
            else
                printf "\n entry:      "
                showptrhdrpad
                printf "deadline           soft_deadline      delta      (*func)(param0,param1)\n"
                while $kgm_entry != $kgm_rt_timer
                    set $kgm_timer_call = (timer_call_t) $kgm_entry
                    set $kgm_call_entry = (struct call_entry *) $kgm_entry
                    printf " "
                    showptr $kgm_entry
                    printf ": 0x%016llx 0x%016llx 0x%08x (%p)(%p,%p)\n", \
                        $kgm_call_entry->deadline, \
                        $kgm_timer_call->soft_deadline, \
                        ($kgm_call_entry->deadline - $kgm_timer_call->soft_deadline), \
                        $kgm_call_entry->func, \
                        $kgm_call_entry->param0, $kgm_call_entry->param1
                    set $kgm_entry = $kgm_entry->next
                end
            end
        end
        set $kgm_p = $kgm_p->processor_list
    end
    printf "\n"
end

document processortimers
Syntax: (gdb) processortimers 
| Print details of processor timers, noting any timer which might be suspicious
end

define maplocalcache
	if ($kgm_mtype == $kgm_mtype_arm)
		mem 0x80000000 0xefffffff cache
		set dcache-linesize-power 9
		printf "GDB memory caching enabled. Be sure to disable by calling flushlocalcache before detaching or connecting to a new device\n"
	end
end

document maplocalcache
Syntax: (gdb) maplocalcache 
| Sets up memory regions for GDB to cache on read. Significantly increases debug speed over KDP
end

define flushlocalcache
	if ($kgm_mtype == $kgm_mtype_arm)
		delete mem
		printf "GDB memory caching disabled.\n"
	end
end

document flushlocalcache
Syntax: (gdb) flushlocalcache 
| Clears all memory regions
end
