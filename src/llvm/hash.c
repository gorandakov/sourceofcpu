#include <string.h>
#include <stdlib.h>
#include "id.h"

#define IDMASK_ID 0x4000000
#define IDMASK_GLOBAL 0x20000000


struct _hash_elem {
    char *name;
    char buf[24];
    int id;
};


struct _hash_entry {
    struct _hash_elem items[4];
    struct _hash_entry *next;
} hash_global[1<<20],hash_local[512],hash_keyword[128];

unsigned int hashfn(char * str) {
    int n=0;
    unsigned int h=48019;
    while(str[n]) {
        h=((h<<5) +h)^str[n]; 
    }
    return h;
}

void hash_bucket_free(struct _hash_entry *h1) {
    struct _hash_entry *h2;
    int n;
    int flag=0;
    do {
        for(n=0;n<4;n++)
            if(h1->items[n].name[0]!=0) {
                ID_cleanup(h1->items[n].id);
                if (strlen(h1->items[n].name)>=sizeof h1->items[n].buf) free(h1->items[n].name);
            }
            else {
                break;      
            }
        h2=h1->next;
        if (flag) free(h1);
        flag=1;
        h1=h2;
    } while (h1);
}

void hash_local_cleanup() {
    int n;
    for(n=0;n<512;n++) hash_bucket_free(hash_local+n);
}

int hash_bucket_search(struct _hash_entry *h1, char *str) {
    int n;
    do {
        for(n=0;n<4;n++) 
            if (h1->items[n].name && !strcmp(h1->items[n].name,str)) return h1->items[n].id;
    } while (!h1->items[4].name && h1->next && (h1=h1->next));
    return -1;
}

void hash_bucket_add(struct _hash_entry *h1, char *str, int id) {
   int n=0;
    while(h1->items[0].name) {
        if (!h1->items[1].name) {n=1;break;}
        if (!h1->items[2].name) {n=2;break;}
        if (!h1->items[3].name) {n=3;break;}
        if (h1->next) {
            h1=h1->next;
        } else {
            h1->next=malloc(sizeof *h1);
            memset(h1->next,0,sizeof *h1);
            n=strlen(str);
            h1=h1->next;
            if (n<(sizeof h1->items[0].buf)) h1->items[0].name=h1->items[0].buf;
            else h1->items[0].name=malloc(n+1);
            strcpy(h1->items[0].name,str);   
            n=0;        
        }
    }
    h1->items[n].id=id;
}

int ID_name_to_num(char *str, int global) {
    unsigned int hash=hashfn(str);
    struct _hash_entry *h1;
    int id;
    if (!global) {
        h1=hash_local + (hash&0x1ff);
        if ((id=hash_bucket_search(h1,str))>0)
            return id|IDMASK_ID;
        id=ID_alloc_local();
        hash_bucket_add(h1,str,id);
        return id|IDMASK_ID;
    } else {
        h1=hash_global + (hash &0xfffff);
        if ((id=hash_bucket_search(h1,str))>0)
            return id|IDMASK_ID|IDMASK_GLOBAL;
        id=ID_alloc_global();
        hash_bucket_add(h1,str,id);
        return id|IDMASK_ID|IDMASK_GLOBAL;
    }
}

int find_keyword(char *str) {
    int hash=hashfn(str);
    struct _hash_entry *h1=&hash_keyword[hash&0x7f];
    int n=hash_bucket_search(h1,str);    
    if (n>=0) return n;
    return -1;
}

