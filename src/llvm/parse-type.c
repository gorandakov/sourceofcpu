#include "constant.h"
#include "parse.h"
#include "error.h"
#include "id.h"
#include "type.h"
#include "hash.h"
#include "keyword.h"
#include <stdlib.h>
int parse_type(char *str, int *new_pos); 

int parse_type_nonfun(char *str, int *new_pos) {
    int pos=0,num,kw,pos1;
    int ptrcnt,id,len,packed=0;
    int stct_buf[256];
    int *stct=stct_buf,stcnt=0,stsz=256;
    if (str[0]=='i' && chr_IDNum[str[1]]) {
        num=str[1]-'0';
        str+=2; 
        pos+=2;
        pos1=0;
        while (chr_IDNum[str[0]]) pos1++,num=num*10+(str++)[0]-'0';
        if (num>MAX_INT_BITS) return ERROR_INT_TOO_BIG;
        str+=pos1;
        pos+=pos1;
        parse_spc(str,&pos1);
        str+=pos1;
        pos+=pos1;
        ptrcnt=0;
        while (str[0]=='*') {
            str++,pos++;
            parse_spc(str,&pos1);
            str+=pos1;
            pos+=pos1;
            ptrcnt++;
        }
        if (ptrcnt>PTR_CNT_MAX) return ERROR_TYPE_TOO_DEEP;
        *new_pos=pos;
        return TYPEMASK_INT | num | (ptrcnt<<PTR_CNT_SHIFT);
    } 
    //not I
    switch(str[0]) {
  case '[':
        str++,pos++;
        parse_spc(str,&pos1);
        str+=pos1;
        pos+=pos1;
        len=parse_num(str++,&pos1);
        if (len==ERROR_NOT_PARSED) return ERROR_CONSTANT_EXPECTED;
        if (len<0) return len;
        str+=pos1;
        pos+=pos1;
        parse_spc(str,&pos1);
        if (!pos1) return ERROR_ILLEGAL_CHARACTER;
        str+=pos1;
        pos+=pos1;
        if (str[0]!='x') return ERROR_X_EXPECTED;
        str++,pos++;
        parse_spc(str,&pos1);
        if (!pos1) return ERROR_ILLEGAL_CHARACTER;
        str+=pos1;
        pos+=pos1;
        id=parse_type(str,&pos1); 
        if (id==ERROR_NOT_PARSED) return ERROR_TYPE_EXPECTED;
        if (id<0) return id;
        str+=pos1;
        pos+=pos1;
        id=type_new_array(len,id);
        parse_spc(str,&pos1);
        str+=pos1;
        pos+=pos1;
        ptrcnt=0;
        while(str[0]=='*') {
            str++,pos++;
            parse_spc(str,&pos1);
            str+=pos1;
            pos+=pos1;
            ptrcnt++;
        }
        if (ptrcnt>PTR_CNT_MAX) return ERROR_TYPE_TOO_DEEP;
        if (ptrcnt) type_inc_ptr(id,ptrcnt);
        return id;
        break;
  case '{':
        goto do_struct;
        break;
  case '<':
        if (str[1]=='{') {
            packed=1;
            str++,pos++;
            goto do_struct;
        }
        str++,pos++;
        parse_spc(str,&pos1);
        str+=pos1;
        pos+=pos1;
        len=parse_num(str++,&pos1);
        if (len==ERROR_NOT_PARSED) return ERROR_CONSTANT_EXPECTED;
        if (len<0) return len;
        str+=pos1;
        pos+=pos1;
        parse_spc(str,&pos1);
        if (!pos1) return ERROR_ILLEGAL_CHARACTER;
        str+=pos1;
        pos+=pos1;
        if (str[0]!='x') return ERROR_X_EXPECTED;
        str++,pos++;
        parse_spc(str,&pos1);
        if (!pos1) return ERROR_ILLEGAL_CHARACTER;
        str+=pos1;
        pos+=pos1;
        id=parse_type(str,&pos1); 
        if (id==ERROR_NOT_PARSED) return ERROR_TYPE_EXPECTED;
        if (id<0) return id;
        str+=pos1;
        pos+=pos1;
        id=type_new_vector(len,id);
        if (id<0) return ERROR_INVALID_VECTOR_TYPE;
        parse_spc(str,&pos1);
        str+=pos1;
        pos+=pos1;
        ptrcnt=0;
        while(str[0]=='*') {
            str++,pos++;
            parse_spc(str,&pos1);
            str+=pos1;
            pos+=pos1;
            ptrcnt++;
        }
        if (ptrcnt>PTR_CNT_MAX) return ERROR_TYPE_TOO_DEEP;
        if (ptrcnt) type_inc_ptr(id,ptrcnt);
        return id;
        break;

        break;
  case '%':
  case '@':
        id=parse_id(str,&pos1);
        if (id<0) return id;
        str+=pos1;
        pos+=pos1;
        if (get_id_kind(id)!=IDKIND_TYPE) return ERROR_NOT_PARSED;
        *new_pos=pos;
        if (!(id&IDMASK_ID)) id|=IDMASK_GLOBAL;
        return id;
        break;
  default: //must be a primitive type keyword
        kw=parse_keyword(str,&pos);
        if (kw<0) return kw;
        str+=pos;
        if (init_KW[kw].type==KW_TYPE) {
            //tp.type=init_KW[kw].number;
            parse_spc(str,&pos1);
            str+=pos1;
            pos+=pos1;
            ptrcnt=0;
            while (str[0]=='*') {
                str++,pos++;
                parse_spc(str,&pos1);
                str+=pos1;
                pos+=pos1;
                ptrcnt++;
            }
            if (ptrcnt>PTR_CNT_MAX) return ERROR_TYPE_TOO_DEEP;
            *new_pos=pos;
            return TYPEMASK_FIXED | init_KW[kw].number | (ptrcnt<<PTR_CNT_SHIFT);
        } else {
            return ERROR_INVALID_TYPE;
        }
        break;
    }
    do_struct:
    str++,pos++;
    parse_spc(str,&pos1);
    str+=pos1;
    pos+=pos1;
    while((id=parse_type(str,&pos1))>=0) {
        if (stcnt>=stsz) {
            if (stsz==256) stct=malloc(512);
            else stct=realloc(stct,2*stsz);
            stsz*=2;
        }
        stct[stcnt++]=id;
        str+=pos1;
        pos+=pos1;
        parse_spc(str,&pos1);
        str+=pos1;
        pos+=pos1;
    } 
    if (id!=ERROR_NOT_PARSED) {
        if (stsz!=256) free(stct);
        return id;
    }
    if (str[0]!='}') {
        if (stsz!=256) free(stct);
        return ERROR_BRACE_NOT_CLOSED;
    }
    str++,pos++;
    *new_pos=pos;
    id=type_new_struct(stct,stcnt,packed);
    if (stsz!=256) free(stct);
    parse_spc(str,&pos1);
    str+=pos1;
    pos+=pos1;
    ptrcnt=0;
    while(str[0]=='*') {
        str++,pos++;
        parse_spc(str,&pos1);
        str+=pos1;
        pos+=pos1;
        ptrcnt++;
    }
    if (ptrcnt>PTR_CNT_MAX) return ERROR_TYPE_TOO_DEEP;
    if (ptrcnt) type_inc_ptr(id,ptrcnt);
    return id;

}
int parse_type(char *str, int *new_pos) {
    int pos=0,pos1;
    int ptrcnt,id,len;
    int stct_buf[256];
    int *stct=stct_buf,stcnt=0,stsz=256;
    id=parse_type_nonfun(str,&pos);
    if (id<0) return id;
    str+=pos;
    parse_spc(str,&pos1);
    str+=pos1;
    pos+=pos1;
    if (str[0]!='(') return id;
    str++,pos++;
    parse_spc(str,&pos1);
    str+=pos1;
    pos+=pos1;
    stct[stcnt++]=id;
    while((id=parse_type(str,&pos1))>=0) {
        if (stcnt>=stsz) {
            if (stsz==256) stct=malloc(512);
            else stct=realloc(stct,2*stsz);
            stsz*=2;
        }
        stct[stcnt++]=id;
        str+=pos1;
        pos+=pos1;
        parse_spc(str,&pos1);
        str+=pos1;
        pos+=pos1;
        if (str[0]!=',') break;
    }
    if (str[0]=='.' && str[1]=='.' && str[2]=='.') {
        if (stcnt>=stsz) {
            if (stsz==256) stct=malloc(512);
            else stct=realloc(stct,2*stsz);
            stsz*=2;
        }
        stct[stcnt++]=TYPEMASK_FIXED | KW_TYP_VARARG;
        str+=3;
        pos+=3;
        parse_spc(str,&pos1);
        str+=pos1;
        pos+=pos1;
        id=ERROR_NOT_PARSED;
    }
    if (id!=ERROR_NOT_PARSED) {
        if (stsz!=256) free(stct);
        return id;
    }
    if (str[0]!=')') {
        if (stsz!=256) free(stct);
        return ERROR_BRACKET_NOT_CLOSED;
    }
    str++,pos++;
    parse_spc(str,&pos1);
    str+=pos1;
    pos+=pos1;
    if (str[0]!='*') {
        if (stsz!=256) free(stct);
        return ERROR_PTR_EXPECTED;
    }
    id=type_new_fun(stct,stcnt);
    parse_spc(str,&pos1);
    str+=pos1;
    pos+=pos1;
    ptrcnt=0;
    while(str[0]=='*') {
        str++,pos++;
        parse_spc(str,&pos1);
        str+=pos1;
        pos+=pos1;
        ptrcnt++;
    }
    if (ptrcnt>PTR_CNT_MAX) return ERROR_TYPE_TOO_DEEP;
    if (ptrcnt) type_inc_ptr(id,ptrcnt);
    if (stsz!=256) free(stct);
    return id;
}

