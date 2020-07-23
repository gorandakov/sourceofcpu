
unsigned char chr_IDFirst[256],chr_IDNext[256],chr_IDNum[256],chr_SPC[256];

int parse_id(char *str, int *new_pos); 

int parse_assign(char *str, int* new_pos); 

int parse_spc(char *str, int* new_pos);

int parse_keyword(char *str, int *new_pos); 

