#include <cstdlib>
#include <cstring>
#include <map>
#include <string>
#include <cstdio>


struct BigInstr
{
  unsigned int instr[6];
  unsigned long long int constBits;
};

  
enum RegKind {regi8,regi16,regi32,regi64}; 
enum InstrType {instr_simpleInt,instr_condJump,instr_unCondJump,instr_noParam};

class RelocRef;
struct Label;

class Section
{
  public:
  unsigned long long dataLen;
  unsigned long long base;
  Section();
};

class SectionWithData : public Section
{
  public:
  char *data;
  int dataSize;
  SectionWithData();
  void grow(char *data, int len);
};

class CodeSection : public SectionWithData
{
  public:
  BigInstr bigInstr;
  int smallInstrCount;
  int branchCount;
  int constCount;
  RelocRef *relocs;
  RelocRef *lastReloc;
  CodeSection();
  void feedBigInstr();
  void setConstant(unsigned int constant,int instrIndex);
  void AddSimpleRegInt(int code,RegKind regKind,int rA,int rB,int rT);
  void AddSimpleConstInt(int code,RegKind regKind,int rA,int rT,unsigned int constant);
  void AddShortCondJump(int code,Label *l);
  void AddNoParam(int code);
  void AddShortJump(int code,Label *l);
  void finalAlign();
  void appendReloc(RelocRef *reloc);
  void beforeLabel();
};

class DataSection : public SectionWithData
{
};

struct Label 
{
  bool known;
  int section;//-1 for absolute
  int commSize; //>0 for comm symbols
  int allign;
  long long offset;
  Label();
};

class Executable
{
  public:
  Section *sections[3]; //code=0,data=1,bss=2
  std::unordered_map<std::string,Label *> labels;
  std::string lastLabel;
  int currentSection;
  bool nothingAfterLastLabel;
  Executable();
  ~Executable();
  void addUnknownLabel(std::string &str);
  bool defineLabel(std::string &str);
  void commLabel(std::string &str,int commSize,int allign);
  void doRelocsAndLabels();
};

class RelocRef
{
  public:
  RelocRef *next;
  Label *label;
  long long offset;
  long long targetAddr; //this is offset into code section, NOT absolute address!!!
  RelocRef(Label *lbl,long long offst,long long tgtAddr);
  virtual bool apply(Executable &executable)=0;
};

class RelocRefShortRelJump : public RelocRef
{
  public:
  virtual bool apply(Executable &executable);
  RelocRefShortRelJump(Label *lbl,long long offst,long long tgtAddr) : RelocRef(lbl,offst,tgtAddr) {}
};


inline unsigned int extract32(unsigned int val,int leftBit,int count)
{
  return (val>>leftBit) & ((1<<count)-1);
}

inline unsigned long long int extract64(unsigned long long int val,int leftBit,int count)
{
  return (val>>leftBit) & ((1<<count)-1);
}


inline void deposit32(unsigned int &val,int leftBit,int count,unsigned int bits)
{
  unsigned int val1;
  unsigned int mask;

  mask=~(((1<<count)-1)<<leftBit);
  val1= (bits & ((1<<count)-1))<<leftBit;
  val=(val & mask) | val1;
}


inline void deposit64(unsigned long long int &val,int leftBit,int count,unsigned long long int bits)
{
  unsigned long long int val1;
  unsigned long long int mask;

  mask=~(((1<<count)-1)<<leftBit);
  val1=(bits & ((1<<count)-1))<<leftBit;
  val=(val & mask) | val1;
}

inline unsigned int p2allign32(unsigned int num,int algn)
{
  unsigned int add=(1<<algn)-1;
  return (num+add) & ~add;
}

inline unsigned long long p2allign64(unsigned long long num,int algn)
{
  unsigned long long add=(1ull<<algn)-1ull;
  return (num+add) & ~add;
}

Section::Section()
{
  dataLen=0;
  base=0;
}

SectionWithData::SectionWithData()
{
  data=(char *) malloc(4096);
  dataSize=4096;
  memset(data,0,4096);
}

CodeSection::CodeSection()
{
  smallInstrCount=0;
  branchCount=0;
  constCount=0;
  dataLen=32;
  memset(&bigInstr,0,32);
  relocs=NULL;
  lastReloc=NULL;
}


void CodeSection::feedBigInstr()
{
  int i;

  if (dataLen+32>dataSize) 
  {
    data=(char *) realloc(data,2*dataSize);
    memset(data+dataSize,0,dataSize);
    dataSize=dataSize*2;
  }
  for (i=smallInstrCount; i<=5; i++) bigInstr.instr[i]=2; // fill with nop's
  memcpy(data+dataLen-32,&bigInstr,32);
  smallInstrCount=0;
  constCount=0;
  branchCount=0;
  dataLen=dataLen+32;
  memset(&bigInstr,0,32);
}


void CodeSection::setConstant(unsigned int constant,int instrIndex)

{
  switch (constCount)
  {  
    case 0: deposit64(bigInstr.constBits,7,19,constant>>13); break;
    case 1: deposit64(bigInstr.constBits,26,19,constant>>13); break;
    case 2: deposit64(bigInstr.constBits,45,19,constant>>13); break;
  }
  deposit64(bigInstr.constBits,instrIndex,1,1);
  constCount=constCount+1;
}


void CodeSection::AddSimpleRegInt(int code,RegKind regKind,int rA,int rB,int rT)
{
  unsigned int instr;

  if (smallInstrCount>=6) feedBigInstr();
  instr=0;
  deposit32(instr,24,6,code);
  deposit32(instr,9,5,abs(rA));
  deposit32(instr,14,5,abs(rB));
  deposit32(instr,19,5,abs(rT));
  bigInstr.instr[smallInstrCount]=instr;
  smallInstrCount=smallInstrCount+1;
}


void CodeSection::AddSimpleConstInt(int code,RegKind regKind,int rA,int rT,unsigned int constant)
{
  unsigned int instr;

  if (smallInstrCount>=6) feedBigInstr();
  instr=0;
  deposit32(instr,6,3,1);
  deposit32(instr,0,6,code);
  deposit32(instr,9,5,abs(rA));
  deposit32(instr,14,5,abs(rT));
  deposit32(instr,19,13,constant);
  if (extract32(constant,13,19)!=0x7ffff && extract32(constant,13,19)!=0)
    {
      if (constCount>2) feedBigInstr();
      setConstant(constant,smallInstrCount);
    }
  bigInstr.instr[smallInstrCount]=instr;
  smallInstrCount=smallInstrCount+1;
}

void CodeSection::finalAlign()
{
  int newDataLen;

  if (smallInstrCount>0) feedBigInstr();
  newDataLen=p2allign32(dataLen,5);
  if (newDataLen>dataLen) 
  {
    memset(data+dataLen,0,newDataLen-dataLen);
    dataLen=newDataLen;
  }
}

Label::Label()
{
  known=false;
  section=-1;
  offset=0;
}

Executable::Executable()
{
  sections[0]=new CodeSection();
  sections[1]=new DataSection();
  sections[2]=new Section();
  currentSection=0;
}

Executable::~Executable()
{
  delete sections[0];
  delete sections[1];
  delete sections[2];
  currentSection=0;
  nothingAfterLastLabel=false; 
}

void Executable::addUnknownLabel(std::string &str)
{
	if (!labels.count(str)) labels[str] = new Label();;
}

bool Executable::defineLabel(std::string &str)
{
//  if (currentSection==0) ((CodeSection *) sections[0])->beforeLabel();
  if (labels.count(str)) return false;
  Label *L = new Label();
  L->known=true;
  L->section=currentSection;
  L->offset=sections[currentSection]->dataLen;
  if (currentSection==0)
  {
    nothingAfterLastLabel=true;
    if (((CodeSection *) sections[0])->smallInstrCount<6)
    {
      L.offset=L.offset-32+ ((CodeSection *) sections[0])->smallInstrCount*4;
    }
  }
  else nothingAfterLastLabel=false;
 
  labels[str] = L;
  return true;
}


void Executable::commLabel(std::string &str,int commSize,int allign)
{
  if (labels.count(str)!=0) return;
  Label *L = new Label();
  L->section=2;
  if (commSize>L->commSize) L->commSize=commSize;
  if (allign>L->allign) L->allign=allign;
  labels[str] = L;
}

RelocRef::RelocRef(Label *lbl,long long offst,long long tgtAddr)
{
  label=lbl;
  offset=offst;
  targetAddr=tgtAddr;
  next=NULL;
}


bool RelocRefShortRelJump::apply(Executable &executable)
{
  long long addrDiff;
  unsigned int instr;
  unsigned int smallAddrDiff;
  long long lowBits;
  //label must be in the code section
  if (!label->known || label->section!=0) return false;
  if (offset!=0ll) { fprintf(stderr,"internal error 100\n"); exit(10);} 
  if (targetAddr & 0x3ll) { fprintf(stderr,"internal error 101\n"); exit(10);}  
  if (targetAddr>executable.sections[0]->dataLen) { fprintf(stderr,"internal error 102\n"); exit(10);} 
  lowBits=(label->offset>>2) & 0x7ll;
  addrDiff=(label->offset>>5)-(targetAddr>>5);
  addrDiff=addrDiff<<3 | lowBits;
  if (!((addrDiff & 0xfffffffffff00000ll)==0xfffffffffff00000ll || (addrDiff & 0xfffffffffff00000ll)==0ll)) return false;
  memcpy(&instr,((SectionWithData *)executable.sections[0])->data+targetAddr,4);  
  smallAddrDiff=addrDiff;
  deposit32(instr,11,21,smallAddrDiff);
  memcpy(((SectionWithData *)executable.sections[0])->data+targetAddr,&instr,4);
  return true;  
}

void CodeSection::AddShortCondJump(int code,Label *l)
{
  unsigned int instr;
  RelocRefShortRelJump *reloc;
  long long offset;

  if (smallInstrCount>=6 || branchCount>=2) feedBigInstr();
  instr=0;
  offset=dataLen-32+4*smallInstrCount;
  reloc=new RelocRefShortRelJump(l,0,offset);
  appendReloc(reloc);
  deposit32(instr,9,2,code);
  deposit32(instr,0,2,code>>2);
  deposit32(instr,2,7,1);
  bigInstr.instr[smallInstrCount]=instr;
  smallInstrCount++;
}

void CodeSection::appendReloc(RelocRef *reloc)
{
  if (relocs)
  {
    lastReloc->next=reloc;
    lastReloc=reloc;
  }
  else
  {
    relocs=reloc;
    lastReloc=reloc;
  }
}


void Executable::doRelocsAndLabels()
{
  std::map<std::string,Label>::iterator iter;
  unsigned int bssLen=0;
  RelocRef *rel,*rel1;
  
  for (iter=labels.begin();iter!=labels.end();iter++)
  {
    Label &L=*(*iter).second;
    if (L.known) continue;
    if (L.commSize==0) continue;
    L.section=2;//bss
    bssLen=p2allign32(bssLen,L.allign);
    L.offset=bssLen;
    bssLen+=L.commSize;
    L.known=true;
  }
  sections[2]->dataLen=bssLen;

  sections[0]->base=0;
  ((CodeSection *) sections[0])->finalAlign();
  sections[1]->base=sections[0]->dataLen;
  sections[1]->dataLen=p2allign64(sections[1]->dataLen,5);
  sections[2]->base=sections[1]->base+sections[1]->dataLen;
  sections[2]->dataLen=p2allign64(sections[2]->dataLen,5);
  
  for (rel=((CodeSection *) sections[0])->relocs;rel;)
  {
    rel->apply(*this);
    rel1=rel;
    rel=rel->next;
    delete rel1;
  }
}

void CodeSection::beforeLabel()
{
  //if (smallInstrCount>0) feedBigInstr();
}


void CodeSection::AddNoParam(int code)
{
  unsigned int instr;

  if (smallInstrCount>=6) feedBigInstr();
  instr=0;
  deposit32(instr,0,9,code);
  bigInstr.instr[smallInstrCount]=instr;
  smallInstrCount++;
}


void CodeSection::AddShortJump(int code,Label *l)
{
  unsigned int instr;
  RelocRefShortRelJump *reloc;
  long long offset;

  if (smallInstrCount>=6 || branchCount>=2) feedBigInstr();
  instr=0;
  offset=dataLen-32+4*smallInstrCount;
  reloc=new RelocRefShortRelJump(l,0,offset);
  appendReloc(reloc);
  deposit32(instr,0,11,code);
  bigInstr.instr[smallInstrCount]=instr;
  smallInstrCount++;

}


void SectionWithData::grow(char *newData, int len)
{
	while (dataLen + len > dataSize)
	{
		data = realloc(data, 2 * dataSize);
		dataSize *= 2;
	}
	memcpy(data + dataLen, newData, len);
}