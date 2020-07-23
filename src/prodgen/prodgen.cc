class Mod {
public:
  Mod* next;
  virtual bool isCompressor();
  virtual bool other_out(Mod ****out, char * name, int index);
  Mod();
};

typedef Mod *pmod;

pmod modRoot=NULL,modTail;

bool Mod::isCompressor()
{
  return false;
}

bool Mod::other_out(Mod ****out, char * name, int index)
{
  return false;
}

Mod::Mod()
{
  if (modRoot)
  {
    modTail->next=this;
    next=NULL;
    modTail=this;
  }
  else
  {
    modRoot=this;
    modTail=this;
    next=NULL;
  }
  
}

class AndGate : Mod
{
  char sa[32];
  char sb[32];
  char st[32];
  int sa_index;
  int sb_index;
  int st_index;
public:
  AndGate(char *tn,int ti,char* an, int ai, char *bn, int bi); 
}

AndGate::AndGate(char *tn,int ti,char* an, int ai, char *bn, int bi)
{
  sa_index=ai;
  sb_index=bi;
  st_index=ti;
  strcpy(sa,an);
  strcpy(sb,bn);
  strcpy(st,tn);
} 

class FullAdder : Mod
{
  char sa[32];
  char sb[32];
  char sc[32];
  char st[32];
  char stH[32];
  int sa_index;
  int sb_index;
  int sc_index;
  int st_index;
  int stH_index;
public:
  FullAdder(char *tn,int ti,char* an, int ai, char *bn, int bi, char *cn, int ci);
  virtual bool isCompressor();
  virtual bool other_out(Mod ****out, char * name, int index);
}

FullAdder::FullAdder(char *tn,int ti,char* an, int ai, char *bn, int bi, char *cn, int ci)
{
  sa_index=ai;
  sb_index=bi;
  sc_index=ci;
  st_index=ti;
  strcpy(sa,an);
  strcpy(sb,bn);
  strcpy(sc,cn);
  strcpy(st,tn);
} 

bool FullAdder::isCompressor()
{
  return true;
}

bool FullAdder::other_out(Mod **out, char * name, int index)
{
  *out=new AdderOther(this);
  strcpy(stH,name);
  stH_index=index;
  return true;
}

class HalfAdder : Mod
{
  char sa[32];
  char sb[32];
  char st[32];
  char stH[32];
  int sa_index;
  int sb_index;
  int st_index;
  int stH_index;
public:
  HalfAdder(char *tn,int ti,char* an, int ai, char *bn, int bi);
  virtual bool isCompressor();
  virtual bool other_out(Mod ****out, char * name, int index);
}

HalfAdder::HalfAdder(char *tn,int ti,char* an, int ai, char *bn, int bi)
{
  sa_index=ai;
  sb_index=bi;
  st_index=ti;
  strcpy(sa,an);
  strcpy(sb,bn);
  strcpy(st,tn);
} 

bool HalfAdder::isCompressor()
{
  return true;
}

bool HalfAdder::other_out(Mod **out, char * name, int index)
{
  *out=new AdderOther(this);
  strcpy(stH,name);
  stH_index=index;
  return true;
}

bool createLayer(pmod **oldAvail,pmod **newAvail, int layer, int weights, int width,bool isReg)
{//return true if final
  int i,j,w,cnt;
  int col[3],row[3];
  int *wei=new int[weights];
  for(i=0;i<weights;i++)
  for(j=0;j<width;j++)
    newAvail[i][j]=NULL;
  i=0;
  char sa[64],sb[64],sc[64];
  for(w=0;w<weights;w++)
  {
    if (isReg)
    {
      snprintf(sa,32,"r_comL%iW%i",layer-1,w);
      snprintf(sb,32,"comL%iW%i",layer,w);
    }
    else
    {
      snprintf(sa,32,"comL%iW%i",layer-1,w);
      snprintf(sb,32,"comL%iW%i",layer,w);
    }
    for(j=0;j<width1;j++)
    {
      if (oldAvail[w][j]) 
      {
        col[cnt]=j;
        cnt++;
      }
      if (cnt==3)
      {
        newAvail[w][col[1]]=new FullAdder(sb,col[1],sa,col[0],sa,col[1],sa,col[2]);
        //this is the same layer output; next layer one is the method other_out
        
      }
    }
    if (cnt==2)
    {
        newAvail[w][col[1]]=new HalfAdder(sb,col[1],sa,col[0],sa,col[1]);
    }
    else if (cnt==1)
    {
        newAvail[w][col[0]]=new Repeater(sb,col[1],sa,col[0]);
    }
  }

  for(w=0;w<weights;w++)
  {
    for(j=0;j<width1;j++)
    {
      if (newAvail[w][j]->isCompressor())
      {
        int g=j,s=-1;
        while(1) do
        {
          if (g<0 || oldAvail[w+1][g])
          {
            if (g<0)
            {
              fprintf(stderr,"bound chk error\n");
              exit(1);
            }
            g=g+s;
            s=-(s+s/abs(s));
            continue;
          }
          snprintf(sa,32,"comL%iW%i",layer,w+1);
          newAvail[w][j].other_out(&newAvail[w+1][g],sa,g);
                    
        }
      }
    }
  }
  for(w=0;w<weights+1;w++)
  {
    wei[w]=0;
    for(j=0;j<width1;j++)
    {
      if (newAvail[w][j]) wei[w]++;
    }
    if (wei[w]>2)
    {
      delete[] wei;
      return true;
    }
  }

delete [] wei;
return false;
}

pmod **genAnd(int width1, int width2)
{//width1 bigger or equal
  pmod **avail=new (char*)[width1+width2-2];
  int i,j;
  for(i=0;i<width1+width2-1;i++)
  for(j=0;j<width1;j++)
    avail[i][j]=NULL;
  for(i=0;i<width2;i++)
  for(j=0;j<width1;j++)
  {
    snprintf(sa,64,"comL%iW%i",0,w+1);
    pmod mymod=new AndGate(sa,j,"A",j,"B",i);
    avail[i+j][j]=mymod;
  }
  return avail;
}

void usage()
{
  fprintf(stderr,"usage:\nprodgen <num>x<num> <num>{-<num>}\nUp to 7 stages\n");
  fprintf(stderr,"larger dimension first\n");
  exit 1;
}


int main(int argc, char *argv[])
{
  if (argc!=3) usage();
  int wid1,wid2,i,j,k;
  if (sscanf(argv[1],"%ix%i",&wid1,&wid2)!=2) usage();
  int stg[7],stgcnt;
  stgcnt=sscanf(argv[2],"%i-%i-%i-%i-%i-%i-%i",stg,stg+1,stg+2,stg+3,stg+4,stg+5,stg+6);
  pmod **prod[32];
  pmod[0]=genAnd(wid1,wid2);
  pmod[1]=new (pmod *)[wid1+wid2-1];
  for(i=0;i<wid1+wid2;i++)
    for(j=0;j<wid1;j++)
      pmod[1][i][j]=NULL;
  i=0;
  while(!createLayer(pmod[i],pmod[i+1], i+1, wid1+wid2-2+i, wid1))
  {
    i++;
    pmod[i+1]=new (pmod *)[wid1+wid2-1+i];
    for(k=0;k<wid1+wid2+i;k++)
      for(j=0;j<wid1;j++)
        pmod[1][k][j]=NULL;
  }
  k=0;
  for(j=0;j<stgcnt;j++) k+=stg[j];
  if (k!=i+1) 
  {
    fprintf(stderr,"ERROR. total count of layers must be %i\n",i+1);
  }


}



