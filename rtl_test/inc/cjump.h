

bool cjump(unsigned type,unsigned flags) {
    bool C=(flags>>5)&1;
    bool O=(flags>>4)&1;
    bool A=(flags>>3)&1;
    bool S=(flags>>2)&1;
    bool Z=(flags>>1)&1;
    bool P=(flags)&1;
    switch(type) {
	case jump_Z: return Z;
	case jump_nZ: return !Z;
	case jump_S: return S;
	case jump_nS: return !S;
        case jump_uGT: return !(C | Z);
        case jump_uLE:  return C | Z;
        case jump_uGE:  return !C;
        case jump_uLT:  return C;
        case jump_sGT:  return !((S^O)|Z);
        case jump_sLE:  return (S^O)|Z;
        case jump_sGE:  return !S^O;
        case jump_sLT:  return S^O;
        case jump_O:    return O;
        case jump_nO:   return !O;
        case jump_P:    return P;
        case jump_nP:   return !P;
        case 0x19:   return 0;//wr csrss
        default:    return 1;
//mngwana una no get rich
    }
}

char *COND(int index) {
    switch(index) {
	case jump_Z: return "je";
	case jump_nZ: return "jne";
	case jump_S: return "js";
	case jump_nS: return "jns";
        case jump_uGT: return "jgt";
        case jump_uLE:  return "jle";
        case jump_uGE:  return "jge";
        case jump_uLT:  return "jlt";
        case jump_sGT:  return "ja";
        case jump_sLE:  return "jbe";
        case jump_sGE:  return "jae";
        case jump_sLT:  return "jb";
        case jump_O:    return "jo";
        case jump_nO:   return "jno";
        case jump_P:    return "jp";
        case jump_nP:   return "jnp";
    }
    return "<err>";
}
