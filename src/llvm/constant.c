#include "keyword.h"
#include "type.h"
#include "error.h"
#include "parse.h"
#include "id.h"
#include <string.h>
#include <stdlib.h>

typedef unsigned __int128 int128;
typedef struct _frag frag;
int parse_int(char *str, int *new_pos, int128 *num); 
long long parse_num(char *str, int *new_pos) {
    int128 a;
    int id=parse_int(str,new_pos,&a);
    if (id<0) return id;
    if (a<0) return ERROR_NEGATIVE_NUMBER;
    return a;
}
int parse_int(char *str, int *new_pos, int128 *num) {
    int pos1=0;
    int c;
    int128 num1=0;
    int minus=0;
    if (str[0]=='-') { str++; pos1++; minus=1; }
    if (str[0]=='0' && (str[1]=='x' || str[1]=='X')) {
        pos1+=2;
	str+=2;
	while (c=chr_IDHex[*str++]) {
	    num1=num1<<4+(c-1);
	    pos1++;
	}
	*new_pos=pos1;
	*num=minus ? -num1 : num1;
	return 0;
    }
    if (str[0]=='0' && str[1]!='x' && str[1]!='X') {
        pos1++;
	str+=1;
	while (c=chr_IDOct[*str++]) {
	    num1=num1<<3+(c-1);
	    pos1++;
	}
	*new_pos=pos1;
	*num=minus ? -num1 : num1;
	return 0;
    }
    while(chr_IDNum[*str++]) {
        num1=num1*10+str[-1]-'0';
	pos1++;
    }
    *new_pos=pos1;
    *num=minus ? -num1 : num1;
    return 0;
    
}

//return 0 if no extra data
long long parse_initial(char *str,char *new_pos,int type,frag *frag, 
    long long off, long long tsz) {
    int tp=type&0xf0000000;
    int pos1=0,pos2;
    int id,kw;
    long long sz;
  //  char *iddat;
    parse_spc(str,&pos1);
    str+=pos1;
    if (get_type_size(type)==-1) return ERROR_UNSIZED_TYPE;
    if (str[0]=='@') {
        id=parse_id(str,&pos2);
        if (id<0) return id;
        if (get_id_kind(id)!=IDKIND_DATA) return ERROR_INVALID_PTR;
        str+=pos2;
        pos1+=pos2;
        if (get_type_ptrcnt(type)==0) return ERROR_INVALID_PTR;
        add_reloc_ptr(frag,off,id);
        *new_pos=pos1;
        return 0;
    }
    if ((chr_IDNum[str[0]] || str[0]=='-') && tp==TYPEMASK_INT) {
          
        int128 num;
        char *src=(char *) &num;
        id=parse_int(str,&pos2,&num);
        if (id<0) return id;
        if ((type&0xf000ff00)!=TYPEMASK_INT) return ERROR_TYPE_MISMATCH;
        if (big_endian()) src=src+16-get_type_size(type);

        memcpy(data,src,get_type_size(type)); 
            
        *new_pos=pos1+pos2;
        return 0;
    }
    if (chr_IDNum[str[0]] && tp==TYPEMASK_FIXED) {
          
        int128 num;
        id=parse_fp(str,&pos2,&num);
        if (id<0) return id;
        if ((type&0xf000ff00)!=TYPEMASK_FIXED) return ERROR_TYPE_MISMATCH;
        switch(type&0xff) {
        case KW_TYP_FPS:
            if (id==1) store_double_single(num,&data);
            else return ERROR_TYPE_MISMATCH;
            break;
        case KW_TYP_FPD:
            if (id==1) memcpy(data,&num,8);
            else return ERROR_TYPE_MISMATCH;
            break;
        case KW_TYP_FPE:
            if (id==2) memcpy(data,&num,10);
            else return ERROR_TYPE_MISMATCH;
            break;
        }
        *new_pos=pos1+pos2;
        return 0;
    }
    if (str[0]=='{' || (str[0]=='<' && str[1]=='{')) {
    }
    if (str[0]=='<') {
    }
    if (str[0]=='[') {
    }    
    //kw=parse_keyword(str,&pos2);
}

