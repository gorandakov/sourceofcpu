
typedef struct kmembuf_entry {
  int offset;
  int size;
  void *data;
};

typedef struct _kmembuf {
  long int count;
  long int min_est_size;
  struct kmembuf_entry item[];  
} *pkmembuf;
