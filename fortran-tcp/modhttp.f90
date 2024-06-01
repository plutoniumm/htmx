module modhttp
   use iso_c_binding, only: c_new_line

   implicit none
   public :: htstring, htfile
contains
   subroutine htstring(string, response, mlen)
      implicit none
      character(len=*), intent(in):: string
      character(len=*), intent(out):: response
      integer(kind=8), intent(out):: mlen
      character(len=20) :: strlen

      write (strlen, '(I20)') len_trim(string) + 2

      response = 'HTTP/1.1 200 OK'//c_new_line// &
                 'Content-Type: text/html'//c_new_line// &
                 'Content-Length: '//trim(adjustl(strlen))//c_new_line// &
                 c_new_line//string
      mlen = len_trim(response)

   end subroutine htstring

   subroutine htfile(filename, str)
    implicit none

    character(len=*), intent(in) :: filename
    character(len=:), allocatable, intent(out) :: str
    integer :: iunit, istat, filesize
    character(len=1) :: c

    open (newunit=iunit, file=filename, status='OLD', &
          form='UNFORMATTED', access='STREAM', iostat=istat)

    if (istat /= 0) then
       write (*, *) 'Error opening file.'
       return
    end if
    inquire (file=filename, size=filesize)
    if (filesize == 0) then
       write (*, *) 'Error getting file size.'
       return
    end if

    allocate (character(len=filesize) :: str)
    read (iunit, pos=1, iostat=istat) str

    if (istat == 0) then
      read (iunit, pos=filesize + 1, iostat=istat) c
      if (.not. IS_IOSTAT_END(istat)) &
        write (*, *) 'Error: file was not completely read.'
    else
      write (*, *) 'Error reading file.'
    end if

    close (iunit, iostat=istat)
 end subroutine htfile

end module modhttp