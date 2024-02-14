
#define optional

#define pkm_always_switch 0x1
#define pkm_prefer_switch 0x2
#define pkm_return_to_caller 0x4
#define pkm_return_to_continuation 0x8
#define pkm_srv_nest_message 0x100
#define pkm_srv_impersonate_caller 0x200

#define obj_srv_dispatcher 0x10000000
#define obj_vfs_dispatcher 0x20000000
#define obj_mman_dispatcher 0x30000000
#define obj_socket_dispatcher 0x40000000
#define obj_process_thread_dispatcher 0x50000000
#define obj_sysctl_dispatcher 0x60000000

void sysmsg_do_call( int flags, int object, pkmembuf msg, pkmembuf snd_data,
  pkmembuf continuation_data optional, pkmembuf reply_data optional);

typedef (pkmembuf) *sysmsg_callback( unsigned long long flags_object, pkmembuf msg, pkmembuf snd_data,
  pkmembuf continuation_data optional, pkmembuf reply_data optional, pkmembuf old_continuation_data);
//returns server continuation buffer if needed
