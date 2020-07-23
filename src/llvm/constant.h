typedef unsigned __int128 int128;
typedef struct _frag frag;

int parse_int(char *str, int *new_pos, int128 *num); 
long long parse_num(char *str, int *new_pos);
long long parse_initial(char *str,char *new_pos,int type,frag *frag, 
    long long off, long long tsz);

