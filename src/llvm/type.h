#define TYPKIND_ARRAY 1
#define TYPKIND_FUNC 2
#define TYPKIND_STRUCT 3
#define TYPKIND_VEC 4
#define TYPKIND_VOID 5
#define TYPKIND_PTR 6
#define TYPEMASK_INT 0x20000000
#define TYPEMASK_FIXED 0x10000000

#define MAX_INT_BITS 128
#define PTR_CNT_MAX 255
#define PTR_CNT_SHIFT 8

int type_ref(int id); 

int type_unref(int id); 

int type_new_array(long long len, int type); 

int type_new_vector(int len, int type);


void type_inc_ptr(int id,int cnt); 

int type_new_struct(int *types, int cnt, int packed); 

int type_new_fun(int *types, int cnt); 

