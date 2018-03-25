module usr_define
implicit none
contains

subroutine init
end subroutine 

subroutine simulation
implicit none
end subroutine 

subroutine test_code
	write(*,*)'test!'
endsubroutine 

subroutine tools
	write(*,*)'tools!'
endsubroutine 

end module usr_define

subroutine usr_init(id) bind(C, name="usr_init")
use iso_c_binding 
use usr_define
implicit none
integer(kind=c_int),intent(in):: id
select case (id)
case(0)
	call init
case(1)
	call test_code
case(2)
    call tools 
case default
	write(*,*) 'wrong selection'
end select
endsubroutine usr_init 


subroutine interf2c(id) bind(C, name="interf2c")
use iso_c_binding 
use usr_define
implicit none
integer(kind=c_int),intent(in):: id
!real(kind=c_double),intent(out) :: grad(1000,1)
!real(kind=c_double),intent(out) :: hess(10000,1)
select case (id)
case(0)
	call simulation 
case(1)
	call simulation
case(2)
	call simulation
	call simulation
case default
	write(*,*) 'wrong selection'
end select
endsubroutine interf2c

