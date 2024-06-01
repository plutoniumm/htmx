module http
  implicit none
contains
  function respond(message) result(http)
      character(len=*), intent(in) :: message
      character(len=:), allocatable :: http

      ! HTTP res header
      character(len=*), parameter :: http_header = &
          "HTTP/1.0 200 OK" // char(13) // char(10) // char(13) // char(10)

      ! Concat header w/ message
      http = http_header // message
  end function respond
end module http