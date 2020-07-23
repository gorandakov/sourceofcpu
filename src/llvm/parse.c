#include "parse-type.h"
#include "type.h"
#include "hash.h"
#include "keyword.h"
#include "error.h"
#include "id.h"
#include <stdio.h>

unsigned char chr_IDFirst[256],chr_IDNext[256],chr_IDNum[256],chr_SPC[256];

void parse_spc(char *str, int *new_pos) {
    int n=0;
    while (chr_SPC[str[n++]]) {}
    *new_pos=n;
}

int parse_keyword(char *str, int *new_pos) {
    char buf[64];
    int n=0,b;
    if (!chr_IDFirst[str[n++]]) return ERROR_NOT_PARSED;
    buf[0]=str[0];
    while(n<64 && chr_IDNext[str[n++]] ) buf[n-1]=str[n-1];
    if(str[n]) return ERROR_NOT_PARSED;
    str[n]=0;
    b=find_keyword(str);
    *new_pos=n;
    return b;
}

int parse_id(char *str, int *new_pos) {
    char name[256];
    int pos=0,a,glo;
    if (str[0]!='%' &&str[0]!='@') return ERROR_NOT_PARSED;
    glo=str[0]=='@';
    str++;
    if (!chr_IDFirst[*str]) {
        if (chr_IDNum[*str]) {
            name[pos++]=*(str++);
            while (chr_IDNum[*str]) name[pos++]=*(str++);
            name[pos]=0;
            *new_pos=pos; 
            sscanf(name,"%d",&a);
            if (!glo) ID_alloc_lnum(a);
            return glo ? ERROR_BAD_ID : a;
        } else {
            return ERROR_BAD_ID;
        }
    }
    name[pos++]=*(str++);
    while (chr_IDNext[*str]) name[pos++]=*(str++);
    name[pos]=0;
    *new_pos=pos; 
    return ID_name_to_num(name,glo); //includes IDMASK_ID bit and 
                                     //possibly IDMASK_GLOBAL
}


int parse_assign(char *str, int* new_pos) {
    int pos,pos1;
    int target,kw,typ;
    int linkage=-1,visibility=-1,glo=0;
    int size;
    void *data;
    parse_spc(str,&pos);
    str+=pos;
    target=parse_id(str,&pos1);
    if (target==ERROR_NOT_PARSED) return ERROR_NOT_PARSED;
    if (target<0) return target;
    str+=pos1;
    pos+=pos1;
    parse_spc(str,&pos1);
    str+=pos1;
    pos+=pos1;
    if (str[0]!='=') return ERROR_ILLEGAL_CHARACTER;
    parse_spc(str,&pos1);
    str+=pos1;
    pos+=pos1;
    while ((kw=parse_keyword(str,&pos1))>=0) {
        switch(init_KW[kw].type) {
  case KW_LINKAGE:
            linkage=init_KW[kw].number;
            break;
  case KW_VIS:
            visibility=init_KW[kw].number;
            break;
  case KW_VARTYPE:
            glo=init_KW[kw].number==KW_VAR_GLOBAL;
            if (init_KW[kw].number==KW_VAR_TYPE) goto process_type;
            goto process_var; 
  case KW_OPER:
            break;
  case KW_PHI:
            break;
        }
        str+=pos1;
        pos+=pos1;
        parse_spc(str,&pos1);
        str+=pos1;
        pos+=pos1;
    }
    if (kw!=ERROR_NOT_PARSED) return kw;
    return ERROR_MISSING_KEYWORD;
    process_var:
    str+=pos1;
    pos+=pos1;
    parse_spc(str,&pos1);
    str+=pos1;
    pos+=pos1;
    typ=parse_type(str,&pos1);
    if (typ<0) return typ;
    str+=pos1;
    pos+=pos1;
    size=parse_initial(str,&pos1,typ,&data);
    if (size<0 && size!=ERROR_NOT_PARSED) return size;
    if (size>0) {
        set_id_size(target,size);
        set_id_data(target,data);
    }
    set_id_type(target,typ);
    set_id_linkage(target,linkage);
    set_id_visibility(target,visibility);
    if (!glo) set_id_constant(target);
    str+=pos1;
    pos+=pos1;
    *new_pos=pos;
    return 0;
    return ERROR_INTERNAL;
    process_type:
    return ERROR_INTERNAL;

}
