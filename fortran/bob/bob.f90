module bob
  implicit none

  character(len=52), parameter :: all_letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
  character(len=26), parameter :: lca = 'abcdefghijklmnopqrstuvwxyz'
  character(len=26), parameter :: uca = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
contains

! https://stackoverflow.com/a/73336863/1040915


  pure elemental logical function character_is_lowercase(ch)
    character, intent(in) :: ch
    character_is_lowercase = index(lca, ch) /= 0
  end function character_is_lowercase

  pure elemental logical function character_is_letter(ch)
    character, intent(in) :: ch
    character_is_letter = index(all_letters, ch) /= 0
  end function character_is_letter

  function string_is_upper(s)
    logical :: string_is_upper
    character(len=*), intent(in) :: s
    integer :: i
    logical :: string_contains_letters

    string_contains_letters = .false.
    do i=1, LEN(s)
      if (character_is_letter(s(i:i))) then
        string_contains_letters = .true.
      end if
      if (character_is_lowercase(s(i:i))) then
        string_is_upper = .false.
        return
      end if
    end do

! We know that the string contains no lowercase characters - but did it contain _any_ letters at all?
    string_is_upper = string_contains_letters
  end function string_is_upper

  function string_is_empty(s)
    logical :: string_is_empty
    character(len=*), intent(in) :: s
    integer :: i
    integer :: string_length

    string_length = LEN(s)
    if (string_length == 0) then
      string_is_empty = .true.
      return
    end if

    do i=1, string_length
      if (s(i:i) /= ' ') then
        string_is_empty = .false.
        return
      end if
    end do

    string_is_empty = .true.
  end function string_is_empty

! Ideally this would actually be done recursively, but there seems to be some funkiness with that
  function is_question(s)
    logical :: is_question
    character(len=*), intent(in) :: s
    integer :: i
    integer :: string_size

    string_size = LEN(s)
    if (string_size == 0) then
      is_question = .false.
      return
    end if

    do i=1, string_size
      if (s(string_size-(i-1):string_size-(i-1)) == '?') then
        is_question = .true.
        return
      else if (s(string_size-(i-1):string_size-(i-1)) == ' ') then
        cycle
      else
        is_question = .false.
        return
      end if
    end do

  end function is_question


  function hey(statement)
    character(100) :: hey
    character(len=*), intent(in) :: statement

    integer :: string_length

    string_length = LEN(statement)

    if (string_is_empty(statement)) then
      hey = 'Fine. Be that way!'
      return
    end if

    if (is_question(statement)) then
      if (string_is_upper(statement(1:string_length-1))) then
        hey = "Calm down, I know what I'm doing!"
        return
      else
        hey = 'Sure.'
        return
      end if
    end if

    if (string_is_upper(statement)) then
      hey = 'Whoa, chill out!'
      return
    end if

    hey = 'Whatever.'

  end function hey

end module bob
