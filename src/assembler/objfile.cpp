#include <fstream>

void printSection(char *data,int length,std::ofstream &t);


void fullHex(unsigned char val,char fullH[2])
{
  int nib=val>>4;
  if (nib>=0 && nib<=9) fullH[0]=nib+'0';
  else if (nib>=10 && nib<=15) fullH[0]=nib+'A'-10;
  nib=val &0x0f;
  if (nib>=0 && nib<=9) fullH[1]=nib+'0';
  else if (nib>=10 && nib<=15) fullH[1]=nib+'A'-10;
}


void printSection(char *data,int length,std::ofstream &t)
{
  int i,j;
  char instr[65];
  char c1c2[2];
  i=0;
  int k;
  while (length-i>=32)
    {
      for (k=31;k>=0;k--)
        {
          fullHex(data[k+i],c1c2);
          instr[62-k*2]=c1c2[0];
          instr[63-k*2]=c1c2[1];
        }
      instr[64]=0;
      i=i+32;
      t << &instr[0] << "\n";
    }
}



