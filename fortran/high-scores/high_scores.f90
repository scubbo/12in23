
module high_scores
  implicit none
contains

function scores(score_list)
  
  integer, dimension(:) :: score_list
  integer, dimension(size(score_list)) :: scores

  scores = score_list

end function

function personalTopThree(score_list)
  integer, dimension(:) :: score_list
  integer, dimension(3) :: personalTopThree
  integer, dimension(3) :: tempOut
  integer :: i
  integer :: candidate

  ! If I was doing this for-real I'd use a heap, but that sounds hellish here.
  tempOut = [0, 0, 0]
  do i=1,size(score_list)
    if (minval(tempOut) < score_list(i)) then
      tempOut(minloc(tempOut)) = score_list(i)
    end if
  end do

  personalTopThree(1) = maxval(tempOut)
  tempOut(maxloc(tempOut)) = 0
  personalTopThree(2) = maxval(tempOut)
  tempOut(maxloc(tempOut)) = 0
  personalTopThree(3) = maxval(tempOut)
  
end function

function personalBest(score_list)
  integer, dimension(:) :: score_list
  integer :: personalBest
  integer :: i

  personalBest = 0
  do i=1,size(score_list)
    if (score_list(i) > personalBest) then
      personalBest = score_list(i)
    end if
  end do

end function

function latest(score_list)
  integer, dimension(:) :: score_list
  integer :: latest
  integer :: length

  length = size(score_list)

  latest = score_list(length)
end function
  
end module
