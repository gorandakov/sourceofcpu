

class ptr {
    unsigned long val;
    bool get_bounds(unsigned long &low,unsigned long &hi) {
	unsigned exp=val>>59;
	bool eqn=((val>>52)&0x7f)<((val>>45)&0x7f); 
	unsigned long valL=((val>>44)&1) || eqn ? val : val+(1<<(exp+6));
	unsigned long valH=!((val>>44)&1) || eqn ? val : val-(1<<(exp+6));
	low=(((val>>52)&0x7f)<<(exp+6))|((0xfffffffe000<<exp)&
	0xfffffffffff&valL);
	high=(((val>>45)&0x7f)<<(exp+6))|((0xfffffffe000<<exp)&
	0xfffffffffff&valH);
	return (val&0xfffffffffff)<=high && (val&0xfffffffffff)>=high && !(
	eqn && !((val>>44)&1);
    }
    void set_bounds(unsigned long low,unsigned long hi) {
        unsigned exp=31;
	while (1) {
	    unsigned long masq;
       	    masq=(0xfffffffe000<<exp)&0xfffffffffff;
            if ((low&mask)==(val&mask)&&(hi&mask)==(val&mask)) {
	        val=(val&0xfffffffffff)|(((hi>>(exp+6))&0x7f)<<45)|
                (((low>>(exp+6))&0x7f)<<52)|(1<<44);
	    } else if ((low&mask)==(val&mask)) {
	        val=(val&0xfffffffffff)|((((hi>>(exp+6))+1)&0x7f))<<45)|
                (((low>>(exp+6))&0x7f)<<52)|(1<<44);
	    } else if ((hi&mask)==(val&mask) {
	        val=(val&0xfffffffffff)|(((hi>>(exp+6))&0x7f)<<45)|
                ((((low>>(exp+6))-1)&0x7f)<<52)|(0<<44);
	    } else {
	        break;
	    }
	    exp--;
	}
	val|=exp<<59;
    }
}
