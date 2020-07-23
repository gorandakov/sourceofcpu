#define IDKIND_DATA 1
#define IDKIND_TYPE 2
#define IDKIND_FUNC 3
#define IDKIND_TEMP 4
#define IDKIND_OPER 5
#define IDKIND_PHI  6
#define IDKIND_ARG  7



int ID_alloc_local(); 

int ID_alloc_global(); 

int ID_alloc_lnum(int upto); 

void ID_cleanup(int id); 

void set_id_data(int id, char * data); 

void set_id_size(int id, long long int size); 

void set_id_type(int id, int type); 

void set_id_linkage(int id, int linkage); 

void set_id_visibility(int id, int vis); 

void set_id_constant(int id);
 
int get_id_kind(int id); 

