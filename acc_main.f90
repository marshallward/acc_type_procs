use eos_mod
implicit none

type(eos_proc_nonpoly) :: eos_n
type(eos_proc_poly) :: eos_p
type(eos_proc_nonpoly_ptr) :: eos_n_p
type(eos_proc_poly_ptr) :: eos_p_p

integer, parameter :: n = 10000000
real :: x(n), y(n)
real :: s

x(:) = 2.
y(:) = 3.
call eos_n%op(x,y)
print *, sum(x)

x(:) = 2.
y(:) = 3.
call eos_p%op(x,y)
print *, sum(x)

eos_n_p%op => add
x(:) = 2.
y(:) = 3.
call eos_n_p%op(x,y)
print *, sum(x)

eos_p_p%op => add_proc_poly_ptr
x(:) = 2.
y(:) = 3.
call eos_n_p%op(x,y)
print *, sum(x)

end
