Note simd size is 64 bit but the 2xfma is composed of 3 fpu ops each so there are 6 fpu in two domains with one free criss-cross in rs2.
It might be desirable to make the criss cross auto select the correct half when only one half contains data.
Even though vector size is 56, it is possible to do 600 with dual read domain regfile and a cross bar after scheduler, but it would have
to be done on a super conductor monistor process.
Super conductor monistor process would have the gate conductor e.g. 5-10 times thinner than the gate, so that it is possible to evacuate the charge carriers of the gate conductor without evacuating the 
charge carriers of the gate.
It is needed to support super high E field strength, might need CVD diamond gate dielectric.
It would need to use iron for the gate conductor, gate and all layers of wire except contact.

