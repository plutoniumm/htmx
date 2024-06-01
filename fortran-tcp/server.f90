program server
  use iso_c_binding, only: c_char, c_int, c_int64_t, c_null_char, c_size_t, &
  c_carriage_return, c_new_line
  use mod_dill, only: ipaddr, ipaddr_local, ipaddr_port, ipaddr_str, &
  IPADDR_MAXSTRLEN, IPADDR_IPV4, tcp_accept, tcp_close, &
  tcp_listen, msend, suffix_attach, suffix_detach
  use modhttp, only: htstring, htfile

  implicit none

  integer(c_int) :: conn, rc, socket
  type(ipaddr) :: addr, addr_remote
  character(kind=c_char, len=IPADDR_MAXSTRLEN) :: address_string = ''
  character(len=*), parameter :: TCP_SUFFIX = c_carriage_return // c_new_line // c_null_char
  character(len=1000) :: msg
  integer(c_size_t) :: mlen, size = 1_c_size_t, dead = -1_c_int64_t

  rc = ipaddr_local(addr, '127.0.0.1' // c_null_char, 3000_c_int, IPADDR_IPV4)

  print *, 'Listening on 127.0.0.1:', ipaddr_port(addr)
  socket = tcp_listen(addr, 0_c_int)

  do
    conn = tcp_accept(socket, addr_remote, dead)
    print *, 42, address_string
    print *, 699, addr
    call ipaddr_str(addr, address_string)
    print *, 'New conn from ' // trim(address_string)
    conn = suffix_attach(conn, TCP_SUFFIX, 2_c_size_t)

    msg = 'Hello from fortran'
    mlen = len_trim(msg) * size
    call htstring(msg, msg, mlen)

    rc = msend(conn, msg // c_null_char, mlen, dead)
    rc = tcp_close(suffix_detach(conn, dead), dead)
  end do

end program server
