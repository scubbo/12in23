
module armstrong_numbers
  implicit none
contains

  function numberOfDigits(i)
    integer, intent(in) :: i
    integer :: numberOfDigits
    numberOfDigits = floor(log10(real(i))) + 1
  end function

  logical function isArmstrongNumber(i)
    integer, intent(in) :: i
    integer :: sum
    integer :: numDigs
    integer :: idx

    numDigs = numberOfDigits(i)

    sum = 0
    do idx=1,numDigs
      sum = sum + (mod(i/(10**(idx-1)), 10) ** numDigs)
    end do

    isArmstrongNumber = (sum == i)

  end function

end module
