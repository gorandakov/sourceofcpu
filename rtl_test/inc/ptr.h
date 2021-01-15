

class ptr {
	public:
    unsigned long val;
    bool get_bounds(unsigned long &low,unsigned long &hi,bool no_O,ptr ptr2) {
	unsigned exp=val>>59;
	bool eqn=((val>>52)&0x7f)<((val>>45)&0x7f);
        unsigned long masque=eqn ? 0xfffffffffff : 0x1fffffffffff;	
        unsigned long masqueL=eqn ? 0xfffffffe000 : 0xffffffff000;	
	unsigned long valL=(((val>>44)&1) || eqn) ? val&0xfffffffffff : ((val&0xfffffffffff)-(1ul<<(exp+13))) & masqueL;
	unsigned long valH=(!((val>>44)&1) || eqn) ? val&0xfffffffffff : ((val&0xfffffffffff)+(1ul<<(exp+13))) & masque;
	if (valL>(val&0xfffffffffff) ) valL=0;
	low=(((val>>52)&0x7f)<<(exp+6))|((0xffffffff000<<exp)&
	masqueL&valL);
	hi=(((val>>45)&0x7f)<<(exp+6))|((0x1fffffffe000<<exp)&
	masque&valH)|((64ul<<exp)-1);
	unsigned long lowA=(0x0ul<<(exp+6))|((0xffffffff000<<exp)&
	masqueL&valL);
	unsigned long hiA=(0x7ful<<(exp+6))|((0x1fffffffe000<<exp)&
	masque&valH)|((64ul<<exp)-1);
	if (no_O) {
	    lowA=((0xfffffffffc0<<exp)&
	    (0xfffffffffc0)&valL);
	    hiA=((0x1fffffffffc0<<exp)&
	    (masque|0x1fff)&valH)|((64ul<<exp)-1);
	}
	return (ptr2.val&masque)<=hiA && (ptr2.val&masque)>=lowA;
    }
    void set_bounds(unsigned long low,unsigned long hi) {
        unsigned long exp=31;
	while (1) {
	    unsigned long mask;
       	    mask=(0xfffffffe000<<exp)&0xfffffffffff;
            if ((low&mask)==(val&mask)&&(hi&mask)==(val&mask)) {
	        val=(val&0xfffffffffff)|(((hi>>(exp+6))&0x7f)<<45)|
                (((low>>(exp+6))&0x7f)<<52)|(1ul<<44);
	    } else if ((low&mask)==(val&mask)) {
	        val=(val&0xfffffffffff)|(((((hi>>(exp+6))+1)&0x7f))<<45)|
                (((low>>(exp+6))&0x7f)<<52)|(1ul<<44);
	    } else if ((hi&mask)==(val&mask)) {
	        val=(val&0xfffffffffff)|(((hi>>(exp+6))&0x7f)<<45)|
                ((((low>>(exp+6))-1)&0x7f)<<52)|(0ul<<44);
	    } else {
	        break;
	    }
	    exp--;
	}
	val|=exp<<59;
    }
};
