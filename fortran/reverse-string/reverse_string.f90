module reverse_string
  implicit none
contains

  recursive function reverse(input) result(reversed)
    character(*), intent(in) :: input
    character(len=len(input)) :: reversed
    integer :: length_of_input

    length_of_input = len(input)
    if (length_of_input < 2) then
      reversed = input
      return
    end if

    reversed = input(length_of_input:length_of_input) // reverse(input(1:length_of_input-1))
  end function

end module
