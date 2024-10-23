test: acc_main.o acc_eos.o
	nvfortran -acc -o $@ $^

acc_main.o: acc_main.f90 acc_eos.mod
	nvfortran -acc -Minfo=acc -c $<

acc_eos.mod: acc_eos.o
acc_eos.o: acc_eos.f90
	nvfortran -acc -Minfo=acc -c $<
