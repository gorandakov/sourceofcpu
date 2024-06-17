
struct __KThread;
struct __KCapability_part_A;
/*
  struct __KBUF
  note if pointer is zero/null and size is not zero, then this is a permission to map in the calling process of that many bytes.
*/
struct __KBUF {
  char *frag;
  unsigned long size;
  __KBUF() {
      frag=0;
      size=0;
  }
  __KBUF(unsigned long val) {
      frag=0;
      size=val;
  }
  __KBUF(void *ptr, unsigned long val) {
      frag=(char *) ptr;
      size=val;
  }
};

struct __KIPCCapability;

/* 
   struct __KCapability; upon reply, the return cap of the server is written in capid[0].
   if pending_messages is not null and not a Sever or Thread IPC capability the results are unpredictable.
   messages in pending_messages are not reordered.
   This can be handled by a memory manager ipc gate object but not a direct call.
   It can be implemented transparently but the memory manager ipc gate would be created and destroyed beofre and after the call.
   The buffer is converted to a array of pointers where the Server writes the _local_ addresses as seend by it, not physical memory pages.
   Note the server might have access to physical map pages if it uses the page cache and it is in kernel and then they will be the same
   as local.
*/
struct __KCapability_part_B {
  unsigned long offset;
  unsigned long offset_internal;
  unsigned long capid[];
};

struct __KCapability_part_A {
  void * pServer;
  struct __KIPCCapability * pending_messages;
  struct __KCapability_part_A *pNextInThreadList;
  struct __KThread *pThreadNullIfNoFixedThreads;  
};

struct __KIPCCapability {
  __KCapability_part_A;
  __KCapability_part_B;
};

typedef __KCapability_part_B __KCapability;

extern "C" {

/*
  KSendMsk:
  flags:1=cap_to_cap
        2=switch_thread
        4=reply_to_call
        8=return/pass cap (if send, it is pass via buffer, if return, it is also pass via buffer if cap_to_cap; if not cap_to_cap, the
        capability is sent back as the return value and is taken from the first 8 bytes of the buffer).
        negative value indicates error;
        if capability is not returned, the zero or more value can return a datum on no error;
        first frag is the "integer" parameters if any. The latter is only a convention and is not enforced by kernel.
        Note the kernel doesn't sanitise the buffers for containing pointers, it is up to the server if it could accidentally access them.
        syscalls are at most 12 bit unsigned integers
*/
long KSendMsk(void *retcap_and_flags __attribute(allign(16)),void *cap_and_flags_and_syscall, parray<struct __KBBUF> buffer, unsigned long arb1);
/*
  KReplyMsk:
      Auto send reply flag; also sends the new values for offset and offset_internal after completing the request.
*/
long KReplyMsk(void *retcap_and_flags __attribute(allign(16)),void *cap_and_flags, parray<struct __KBBUF> buffer,
    long offset, long offset_internal, unsigned long arb1);

long (*__KCallBack)(void *ret_cap_and_flags_and_syscall ,void *cap, parray<struct __KBBUF> buffer,
    long offset, long offset_internal, unsigned long arb1);
/* 
  KReplyMsk
  combined send and return; if used for sending then
*/
long KSendReplyMsk(void *retcap_and_flags __attribute(allign(16)),void *cap_and_flags, parray<struct __KBBUF> buffer,
    long offset, long offset_internal, unsigned long arb1);
/*
  free() as in s standard library. note it can handle multiple heap factories.
*/
void free(void *);

void *mkcap(unsigned int handle,unsigned int flags,unsigned int syscall) {
  unsigned long l;
  l=(flags&0xf)|(handle<<4)|(syscall<<36);
  return (void *) l;
}

/*
  global heap factories in each module (global variables filled by linker, pointers to malloc objects):
  client_object_factory,
  client_undeletable_factory,
  client_page_aligned_factory,
  ipc_object_factory,
  server_cap_object_factory,
  server_object_factory,
  server_undeletable_factory,
  page_aligned_server_factory
  global variables for standard objects:
  vfs_capability
  kloader_capability
  client_loader_capability
  permission_checking_capability
*/
}
