

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
  int dataLen;
  unsigned long long base;
  Section();
};

class SectionWithData : public Section
{
  public:
  char *data;
  int dataSize;
  SectionWithData();
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
  std::unordered_map<std::string,Label> labels;
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
  long long targetAddr;
  RelocRef(Label *lbl,long long offst,long long tgtAddr);
  virtual bool apply(Executable &executable)=0;
};

class RelocRefShortRelJump : public RelocRef
{
  public:
  virtual bool apply(Executable &executable);
  RelocRefShortRelJump(Label *lbl,long long offst,long long tgtAddr) : RelocRef(lbl,offst,tgtAddr) {}
};

