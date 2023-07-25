
module allergies
  implicit none

  character(len=12), dimension(8) :: allergens = [character(len=12) :: "eggs", "peanuts", "shellfish", "strawberries", &
    "tomatoes", "chocolate", "pollen", "cats"]

contains

  logical function allergicTo(allergy_str, allergy_key)
    character(len=*), intent(in) :: allergy_str
    integer, intent(in) :: allergy_key
    integer :: i
    integer :: index_for_allergen

    allergicTo = .false.
    do i=1,len(allergens)
      if (allergens(i) == allergy_str) then
        allergicTo = mod(allergy_key / (2**(i-1)), 2) == 1
        return
      end if
    end do

  end function


  function allergicList(allergy_key)
    integer, intent(in) :: allergy_key
    character(len=100) :: allergicList
    integer :: i
    integer :: modded_key

    modded_key = mod(allergy_key, 256)

    allergicList = ''
    do i=1,len(allergens)
      if (allergicTo(allergens(i), modded_key)) then
        allergicList = trim(allergicList) // ' ' // trim(allergens(i))
      end if
    end do
    ! No idea why the `2`, here - there was always a leading space, for some reason
    allergicList = allergicList(2:len(allergicList)-1)
  end function



end module
