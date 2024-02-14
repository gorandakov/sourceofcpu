
#define optional

#define pkm_always_switch 0x1
#define pkm_prefer_switch 0x2
#define pkm_return_to_caller 0x4
#define pkm_return_to_continuation 0x8
#define pkm_srv_nest_message 0x100
#define pkm_srv_impersonate_caller 0x200


void sysmsg_do_call( int flags, int object, pkmembuf msg, pkmembuf snd_data,
  pkmembuf continuation_data optional, pkmembuf reply_data optional);
