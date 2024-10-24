module eos_mod
implicit none

type :: eos_proc_nonpoly
contains
  procedure, nopass :: op => add
end type eos_proc_nonpoly

type :: eos_proc_poly
contains
  procedure :: op => add_proc_poly
end type eos_proc_poly

type :: eos_proc_nonpoly_ptr
  procedure(Iproc), nopass, pointer :: op
end type eos_proc_nonpoly_ptr

type :: eos_proc_poly_ptr
  procedure(Iproc_class), pointer :: op
end type eos_proc_poly_ptr

interface
  subroutine Iproc(x, y)
    real, intent(inout) :: x(:)
    real, intent(in) :: y(:)
  end subroutine Iproc

  subroutine Iproc_scalar(x, y)
    real, intent(inout) :: x
    real, intent(in) :: y
  end subroutine Iproc_scalar

  subroutine Iproc_class(eos, x, y)
    import :: eos_proc_poly_ptr
    class(eos_proc_poly_ptr) :: eos
    real, intent(inout) :: x(:)
    real, intent(in) :: y(:)
  end subroutine Iproc_class
end interface

contains

subroutine add(x, y)
  real, intent(inout) :: x(:)
  real, intent(in) :: y(:)

  !$acc kernels
  x(:) = x(:) + y(:)
  !$acc end kernels
end subroutine add

subroutine add_proc_poly(eos, x, y)
  class(eos_proc_poly) :: eos
  real, intent(inout) :: x(:)
  real, intent(in) :: y(:)

  !$acc kernels
  x(:) = x(:) + y(:)
  !$acc end kernels
end subroutine add_proc_poly

subroutine add_proc_poly_ptr(eos, x, y)
  class(eos_proc_poly_ptr) :: eos
  real, intent(inout) :: x(:)
  real, intent(in) :: y(:)

  !$acc kernels
  x(:) = x(:) + y(:)
  !$acc end kernels
end subroutine add_proc_poly_ptr

subroutine add_scalar(x, y)
  !$acc routine
  real, intent(inout) :: x
  real, intent(in) :: y

  x = x + y
end subroutine add_scalar

end module eos_mod
