#include <string>
#include <iostream>
#include <fstream>
#include <map>
#include "instr.hpp"
#include "objfile.hpp"


  
struct InstrRec
{
  char name[20];
  int code;
  RegKind regKind;
  InstrType type;
};
  

struct RegRec
{
  char name[8];
  int code;
  RegKind regKind;
};

typedef bool (*DirFunc) (std::string &line,int chrIndex);

struct DirectiveRec
{
  char name[20];
  DirFunc handler;
};
  


InstrRec instr[]=
  {
    {"addq",	0,	regi64,	instr_simpleInt},
    {"addl",	1,	regi32,	instr_simpleInt},
    {"addw",	2, 	regi16,	instr_simpleInt},

    {"subq",	4, 	regi64,	instr_simpleInt},
    {"subl",	5, 	regi32,	instr_simpleInt},
    {"subw",	6, 	regi16,	instr_simpleInt},

    {"andq",	8, 	regi64,	instr_simpleInt},
    {"andl",	9, 	regi32,	instr_simpleInt},
    {"andw",	10, 	regi16,	instr_simpleInt},

    {"orq",	12, 	regi64,	instr_simpleInt},
    {"orl",	13, 	regi32,	instr_simpleInt},
    {"orw",	14, 	regi16,	instr_simpleInt},

    {"xorq",	16, 	regi64,	instr_simpleInt},
    {"xorl",	17, 	regi32,	instr_simpleInt},
    {"xorw",	18, 	regi16,	instr_simpleInt},

    {"movq",	20, 	regi64,	instr_simpleInt},
    {"movl",	21, 	regi32,	instr_simpleInt},
    {"movw",	22, 	regi16,	instr_simpleInt},

    {"ja",	4,	regi64,	instr_condJump},
    {"jae",	6,	regi64,	instr_condJump},
    {"jb",	7,	regi64,	instr_condJump},
    {"jbe",	5,	regi64,	instr_condJump},
    {"jc",	7,	regi64,	instr_condJump},
    {"je",	0,	regi64,	instr_condJump},
    {"jg",	8,	regi64,	instr_condJump},
    {"jge",	10,	regi64,	instr_condJump},
    {"jl",	11,	regi64,	instr_condJump},
    {"jle",	9,	regi64,	instr_condJump},
    {"ja",	4,	regi64,	instr_condJump},
    {"jna",	5,	regi64,	instr_condJump},
    {"jnae",	7,	regi64,	instr_condJump},
    {"jnb",	6,	regi64,	instr_condJump},
    {"jnbe",	4,	regi64,	instr_condJump},
    {"jnc",	6,	regi64,	instr_condJump},
    {"jne",	1,	regi64,	instr_condJump},
    {"jng",	9,	regi64,	instr_condJump},
    {"jnge",	11,	regi64,	instr_condJump},
    {"jnl",	10,	regi64,	instr_condJump},
    {"jnle",	8,	regi64,	instr_condJump},
    {"jno",	13,	regi64,	instr_condJump},
    {"jnp",	15,	regi64,	instr_condJump},
    {"jns",	3,	regi64,	instr_condJump},
    {"jnz",	1,	regi64,	instr_condJump},
    {"jo",	12,	regi64,	instr_condJump},
    {"jp",	14,	regi64,	instr_condJump},
    {"jpe",	14,	regi64,	instr_condJump},
    {"jpo",	15,	regi64,	instr_condJump},
    {"js",	2,	regi64,	instr_condJump},
    {"jz",	0,	regi64,	instr_condJump},
    {"hlt",	511,	regi64,	instr_noParam},
    {"jmp",	3,	regi64,	instr_unCondJump}
    };

RegRec regNames[]=
  {
    {"rax",0,regi64},
    {"rcx",1,regi64},
    {"rdx",2,regi64},
    {"rbx",3,regi64},
    {"rsp",4,regi64},
    {"rbp",5,regi64},
    {"rsi",6,regi64},
    {"rdi",7,regi64},
    {"r8",8,regi64},
    {"r9",9,regi64},
    {"r10",10,regi64},
    {"r11",11,regi64},
    {"r12",12,regi64},
    {"r13",13,regi64},
    {"r14",14,regi64},
    {"r15",15,regi64},
    {"r16",16,regi64},
    {"r17",17,regi64},
    {"r18",18,regi64},
    {"r19",19,regi64},
    {"r20",20,regi64},
    {"r21",21,regi64},
    {"r22",22,regi64},
    {"r23",23,regi64},

    {"eax",0,regi32},
    {"ecx",1,regi32},
    {"edx",2,regi32},
    {"ebx",3,regi32},
    {"esp",4,regi32},
    {"ebp",5,regi32},
    {"esi",6,regi32},
    {"edi",7,regi32},
    {"r8d",8,regi32},
    {"r9d",9,regi32},
    {"r10d",10,regi32},
    {"r11d",11,regi32},
    {"r12d",12,regi32},
    {"r13d",13,regi32},
    {"r14d",14,regi32},
    {"r15d",15,regi32},
    {"r16d",16,regi32},
    {"r17d",17,regi32},
    {"r18d",18,regi32},
    {"r19d",19,regi32},
    {"r20d",20,regi32},
    {"r21d",21,regi32},
    {"r22d",22,regi32},
    {"r23d",23,regi32},

    {"ax",0,regi16},
    {"cx",1,regi16},
    {"dx",2,regi16},
    {"bx",3,regi16},
    {"sp",4,regi16},
    {"bp",5,regi16},
    {"si",6,regi16},
    {"di",7,regi16},
    {"r8w",8,regi16},
    {"r9w",9,regi16},
    {"r10w",10,regi16},
    {"r11w",11,regi16},
    {"r12w",12,regi16},
    {"r13w",13,regi16},
    {"r14w",14,regi16},
    {"r15w",15,regi16},
    {"r16w",16,regi16},
    {"r17w",17,regi16},
    {"r18w",18,regi16},
    {"r19w",19,regi16},
    {"r20w",20,regi16},
    {"r21w",21,regi16},
    {"r22w",22,regi16},
    {"r23w",23, regi16}
  };

DirectiveRec directiveNames[]=
  {
      {".code"},
      {".data"},
      {".comm"},
      {".byte"},
      {".short"},
      {".word"},
      {".int"},
      {".long"},
      {".quad"}
  }; 


Executable executable;

void addlabel(std::string labelname)
{
}

bool skipWhiteSpace(std::string &line,int &chrIndex)
//returns true if there are more characters left after whitespace
{
  while (chrIndex<line.length() && line[chrIndex]==' ') chrIndex=chrIndex+1;
  if (chrIndex>=line.length()) return false;
  if (line[chrIndex]==';') return false;
  return true;
}

inline bool isTokenChar(char c)
{
  return (c>='a' && c<='z') || (c>='A' && c<='Z') || (c>='0' && c<='9') || c=='$' || c=='@' || c=='.';
}

inline bool isTokenFirstChar(char c)
{
  return (c>='a' && c<='z') || (c>='A' && c<='Z') || c=='$' || c=='@' || c=='.';
}


bool readToken(std::string &line,int &chrIndex,int canStartWithDigit,std::string &tkn)
{ 
  int index;

  index=chrIndex;
  if (index>=line.length()) return false;
  tkn="";
  if (canStartWithDigit)
    {
      if (!isTokenChar(line[index])) return false;
      tkn=tkn+line[index];
      index=index+1;
    }
  else
    {
      if (!isTokenFirstChar(line[index])) return false;
      tkn=tkn+line[index];
      index=index+1;
    }
  while (index<line.length() && isTokenChar(line[index]))
    {
      tkn=tkn+line[index];
      index=index+1;
    }
  chrIndex=index;
  return true;
}

inline bool isCharNumAfter0(char c)
{
  return (c>='0' && c<='7') || c=='b' || c=='B' || c=='x' || c=='X';
}

inline bool isHexDigit(char c)
{
  return (c>='0' && c<='9') || (c>='a' && c<='f') || (c>='A' && c<='F');
}

bool readNum(std::string &line,int &chrIndex,long long int &num)
{
  int index;
  bool neg;
  unsigned long long int numU;
  int nibble;

  index=chrIndex;
  neg=false;
  if (index>=line.length()) return false;
  if (line[index]=='-') 
    {
      index=index+1;
      if (!skipWhiteSpace(line,index)) return false;
      neg=true;
    }
  if (line[index]=='0')
    {
      index=index+1;
      if (index>=line.length() || !isCharNumAfter0(line[index]))
        {
          //zero
          num=0;
          chrIndex=index;
          return true;
        }
      else if (line[index]>='0' && line[index]<='7')
        {
          //octal
          numU=0;
          while (index<line.length() && line[index]>='0' && line[index]<='7') 
            {
              numU=numU<<3+line[index]-'0';
              index=index+1;
            }
          if (!neg) num=numU; else num=-numU;
          chrIndex=index;
          return true;
        }
      else if (line[index]=='b' || line[index]=='B')
        {
          //binary
          numU=0;
          index=index+1;
          if (index>=line.length()) return false;
          while (index<line.length() && line[index]>='0' && line[index]<='1') 
            {
              numU=numU<<1+line[index]-'0';
              index=index+1;
            }
          if (!neg) num=numU; else num=-numU;
          chrIndex=index;
          return true;
        }
      else if (line[index]=='x' || line[index]=='X')
        {
          //hex
          numU=0;
          index=index+1;
          if (index>=line.length()) return false;
          while (index<line.length() && isHexDigit(line[index]))
            {
              char c=line[index];
              if (c>='0' && c<='9') nibble=c-'0';
              else if (c>='a' && c<='f') nibble=c-'a'+10;
              else if (c>='A' && c<='F') nibble=c-'A'+10;
              numU=numU<<4+nibble;
              index=index+1;
            }
          if (!neg) num=numU; else num=-numU;
          chrIndex=index;
          return true;
        } 
    }
  else if (line[index]>='0' && line[index]<='9')
    {
      //decimal
      numU=0;
      while (index<line.length() && line[index]>='0' && line[index]<='9')
        {
          numU=numU*10+line[index]-'0';
          index=index+1;
        }
      if (!neg) num=numU; else num=-numU;
      chrIndex=index;
      return true;
    }
  return false;
}


bool readReg(std::string &line,int &chrIndex,RegKind regKind,int &reg)
{
  int index;
  std::string token;
  int i;

  index=chrIndex;
  if (index>=line.length()) return false;
  if (line[index]!='%') return false;
  index=index+1;
  if (!readToken(line,index,false,token)) return false;
  for (i=0; i<(sizeof regNames)/(sizeof regNames[0]); i++)
    {
      if (token==regNames[i].name && regKind==regNames[i].regKind)  
        {
          reg=regNames[i].code;
          chrIndex=index;
          return true;
        }
    }
  return false;
}



bool readRegInstr(std::string &line,int &chrIndex,RegKind regKind,bool allow3op, int &rA,int &rB,int &rT)
{ 
  int index;
  int reg1,reg2,reg3;

  index=chrIndex;
  if (!skipWhiteSpace(line,index)) return false;
  if (!readReg(line, index, regKind, reg1)) return false;
  if (!skipWhiteSpace(line,index)) return false;
  if (line[index]!=',') return false;
  index=index+1;
  if (!skipWhiteSpace(line,index)) return false;
  if (!readReg(line, index, regKind, reg2)) return false;
  if (skipWhiteSpace(line,index))  
    {
      if (!allow3op) return false;
      if (line[index]!=',') return false;
      index=index+1;
      if (!skipWhiteSpace(line,index)) return false;
      if (!readReg(line, index, regKind, reg3)) return false;
      if (skipWhiteSpace(line,index)) return false;
      rA=reg1;
      rB=reg2;
      rT=reg3;
      chrIndex=index;
      return true;
    }
  else
    {
      rA=reg2;
      rB=reg1;
      rT=reg2;
      chrIndex=index;
      return true;
    }
  return false;
}


bool readConstInstr(std::string &line,int &chrIndex,RegKind regKind,bool allow3op,int &rA,int &rT,int &constant)
{
  int index;
  int reg1,reg2;
  long long int tehConst;
  bool threeOp;

  index=chrIndex;
  threeOp=false;
  if (!skipWhiteSpace(line,index)) return false;
  if (readReg(line, index, regKind, reg1)) 
    {
      //3op
      if (!allow3op) return false;
      if (!skipWhiteSpace(line,index)) return false;
      if (line[index]!=',') return false;
      index=index+1;
      if (!skipWhiteSpace(line,index)) return false;
      threeOp=true;
    }
  if (line[index]!='$') return false;
  index=index+1;
  if (index>=line.length()) return false;
  if (!readNum(line, index,tehConst)) return false;
  constant=tehConst;
  if (!skipWhiteSpace(line,index)) return false;
  if (line[index]!=',') return false;
  index=index+1;
  if (!skipWhiteSpace(line,index)) return false;
  if (!readReg(line, index, regKind, reg2)) return false;
  if (skipWhiteSpace(line,index)) return false;
  if (!threeOp) reg1=reg2;
  rA=reg1;
  rT=reg2;
  chrIndex=index;
  return true; 
}

void parse(std::ifstream &t)
{
  std::string line;
  int chrIndex;
  std::string token,token2;
  int i;
  bool found;
  int rA,rB,rT,constant;
  int lineNo=0;
  while (!t.eof())
    {
      getline(t,line);
      lineNo++;
      token="";
      chrIndex=0;
      while (chrIndex<line.length())
        {
          if (!skipWhiteSpace(line,chrIndex)) break;
          if (!readToken(line, chrIndex, false, token))
            {
              std::cerr << "Syntax error. token expected\n";
              return;
            }
          found=false;
          for (i=0; i<(sizeof directiveNames)/(sizeof directiveNames[0]);i++)
            if (token==directiveNames[i].name)
              {
                found=true;
                break;
              }
          if (found)
            {
              //directive
              std::cerr << "error. directives not yet supported";
              return;
            }
          else 
            {
              if (chrIndex<line.length() && line[chrIndex]==':') 
                {
                  //label
                  chrIndex=chrIndex+1;
                  executable.defineLabel(token);
                  continue;
                }
              else 
                {
                  //instruction or assignment(assignment ignored for now)
                  for (i=0; i<(sizeof instr)/(sizeof instr[0]);i++)
                    if (token==instr[i].name) switch(instr[i].type)
                    {
                    
                      case instr_simpleInt: 
                          if (readRegInstr(line,chrIndex,instr[i].regKind,true,rA,rB,rT))
                            {
                              ((CodeSection *)executable.sections[0])->AddSimpleRegInt(instr[i].code, instr[i].regKind, rA,rB,rT);
                              goto newLine;
                            }
                          else if (readConstInstr(line,chrIndex,instr[i].regKind,true,rA,rT,constant))
                            {
                              ((CodeSection *)executable.sections[0])->AddSimpleConstInt(instr[i].code, instr[i].regKind, rA,rT,constant);
                              goto newLine;
                            }
                          else break;
                      case instr_condJump:
                          if (!skipWhiteSpace(line,chrIndex)) break;
                          if (readToken(line,chrIndex,false,token2))
                            {
                              executable.addUnknownLabel(token2);
                              ((CodeSection *)executable.sections[0])->AddShortCondJump(instr[i].code,&executable.labels[token2]);
                              goto newLine;
                            }
                          else break;
                      case instr_unCondJump: 
                          if (!skipWhiteSpace(line,chrIndex)) break;
                          if (readToken(line,chrIndex,false,token2))
                            {
                              executable.addUnknownLabel(token2);
                              ((CodeSection *)executable.sections[0])->AddShortJump(instr[i].code,&executable.labels[token2]);
                              goto newLine;
                            }
                          else break;
                      case instr_noParam:
                         if (!skipWhiteSpace(line,chrIndex))
                         {
                           ((CodeSection *)executable.sections[0])->AddNoParam(instr[i].code); 
                           goto newLine;
                         }
                         else break;
                    } //switch
                  std::cerr << "syntax error; invalid instruction at line" << lineNo <<"\n";
                  break;
                }
            }
        }//chrIndex loop
      newLine:;
    }//eof loop
}

bool DIR_data(std::string &line, int chrIndex)
{
	executable.section = 1;
	if (skipWhiteSpace(line, chrIndex))	return false;
	return true;
}

bool DIR_code(std::string &line, int chrIndex)
{
	executable.section = 0;
	if (skipWhiteSpace(line, chrIndex))	return false;
	return true;
}


bool DIR_comm(std::string &line, int chrIndex)
{
	long long int comm,num;
	std::string label;
	int index = chrIndex;
	int align=4;//this may need to change
	executable.section = 0;
	if (!skipWhiteSpace(line, index)) return false;
	if (!readToken(line, index, false, label)) return false;
	if (!skipWhiteSpace(line, index)) return false;
	if (line[index] != ',')) return false;
	index++;
	if (!skipWhiteSpace(line, index)) return false;
	if (!readNum(line, index, comm)) return false;
	if (!skipWhiteSpace(line, index)) goto noAlign;
	if (!readNum(line, index, num)) return false;
	align = num;
noAlign:
	executable.comm(label, comm, align);
	return true;
}

bool DIR_byte(std::string &line, int chrIndex)
{
	long long int num;
	std::string label;
	unsigned char a;
	int index = chrIndex;
	if (!skipWhiteSpace(line, index)) return false;
	if (!readNum(line, index, comm)) return false;
	a = num;
	if (executable.currentSection < 2) 
		(SectionWidthData *)executable.sections[executable.currentSection]->grow(&a, 1);
	else return false;
	if (!skipWhiteSpace(line, index)) return true;
	while (line[index] == ',')
	{
		index++;
		if (!skipWhiteSpace(line, index)) return false;
		if (!readNum(line, index, comm)) return false;
		a = num;
		(SectionWidthData *)executable.sections[executable.currentSection]->grow(&a, 1);
		if (!skipWhiteSpace(line, index)) return true;
	}
	return false;
}


bool DIR_short(std::string &line, int chrIndex)
{
	long long int num;
	std::string label;
	unsigned short a;
	int index = chrIndex;
	if (!skipWhiteSpace(line, index)) return false;
	if (!readNum(line, index, comm)) return false;
	a = num;
	if (executable.currentSection < 2)
		(SectionWidthData *)executable.sections[executable.currentSection]->grow(&a, 2);
	else return false;
	if (!skipWhiteSpace(line, index)) return true;
	while (line[index] == ',')
	{
		index++;
		if (!skipWhiteSpace(line, index)) return false;
		if (!readNum(line, index, comm)) return false;
		a = num;
		(SectionWidthData *)executable.sections[executable.currentSection]->grow(&a, 2);
		if (!skipWhiteSpace(line, index)) return true;
	}
	return false;
}

bool DIR_int(std::string &line, int chrIndex)
{
	long long int num;
	std::string label;
	unsigned int a;
	int index = chrIndex;
	if (!skipWhiteSpace(line, index)) return false;
	if (!readNum(line, index, comm)) return false;
	a = num;
	if (executable.currentSection < 2)
		(SectionWidthData *)executable.sections[executable.currentSection]->grow(&a, 4);
	else return false;
	if (!skipWhiteSpace(line, index)) return true;
	while (line[index] == ',')
	{
		index++;
		if (!skipWhiteSpace(line, index)) return false;
		if (!readNum(line, index, comm)) return false;
		a = num;
		(SectionWidthData *)executable.sections[executable.currentSection]->grow(&a, 4);
		if (!skipWhiteSpace(line, index)) return true;
	}
	return false;
}

bool DIR_quad(std::string &line, int chrIndex)
{
	long long int num;
	std::string label;
	unsigned long long a;
	int index = chrIndex;
	if (!skipWhiteSpace(line, index)) return false;
	if (!readNum(line, index, comm)) return false;
	a = num;
	if (executable.currentSection < 2)
		(SectionWidthData *)executable.sections[executable.currentSection]->grow(&a, 8);
	else return false;
	if (!skipWhiteSpace(line, index)) return true;
	while (line[index] == ',')
	{
		index++;
		if (!skipWhiteSpace(line, index)) return false;
		if (!readNum(line, index, comm)) return false;
		a = num;
		(SectionWidthData *)executable.sections[executable.currentSection]->grow(&a, 8);
		if (!skipWhiteSpace(line, index)) return true;
	}
	return false;
}


int main(int argc, char *argv[])  
{

  std::string  fileName;
  std::string  oFileName;      

  if (argc!=2) 
    { 
      std::cerr << "usage: asm filename\n";
      return 1;
    }
  fileName=argv[1];
  int len=fileName.length();
  if (fileName.substr(len-2,2)!=".s") 
  {
    std::cerr << "file name must have .s extension\n";
    return 1;
  }
  std::ifstream  *inputFile=new std::ifstream(fileName.c_str(),std::ios_base::in|std::ios_base::binary);
  parse(*inputFile);
  inputFile->close();
  delete inputFile;
  executable.doRelocsAndLabels();
  oFileName=fileName.substr(0,len-2)+".memh";
  std::ofstream  *outputFile=new std::ofstream(oFileName.c_str(), std::ios_base::out | std::ios_base::trunc | std::ios_base::binary);
  printSection(((SectionWithData *)executable.sections[0])->data,((SectionWithData *)executable.sections[0])->dataLen,*outputFile);
  printSection(((SectionWithData *)executable.sections[1])->data,((SectionWithData *)executable.sections[1])->dataLen,*outputFile);
  outputFile->close();
  delete outputFile;
  return 0;
}

