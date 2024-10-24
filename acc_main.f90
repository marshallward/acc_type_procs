use eos_mod
implicit none

procedure(Iproc_scalar), pointer :: add_ptr

type(eos_proc_nonpoly) :: eos_n
type(eos_proc_poly) :: eos_p
type(eos_proc_nonpoly_ptr) :: eos_n_p
type(eos_proc_poly_ptr) :: eos_p_p

integer, parameter :: n = 10000000
real :: x(n), y(n)
real :: s
integer :: i

! Kernel regions can be placed inside type-bound procedures
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


!!!! This doesn't work.  procedure pointers cannot be inside kernel regions.
!!!! Error: NVFORTRAN-W-0155-Data clause needed for exposed use of pointer add_ptr$sd
!!!! But add_ptr is not "data" 🤔
!!x(:) = 2.
!!y(:) = 3.
!!! Local or module, does not seem to matter
!!add_ptr => add_local
!!add_ptr => add_scalar
!!!$acc enter data copyin(add_ptr)
!!
!!!$acc kernels
!!do i=1,n
!!  call add_ptr(x(i), y(i))
!!enddo
!!!$acc end kernels
!!print *, sum(x)

contains

subroutine add_local(x, y)
  real, intent(inout) :: x
  real, intent(in) :: y

  x = x + y
end subroutine add_local

end
