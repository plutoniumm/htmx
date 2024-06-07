program test_fcgi
    use fcgi_protocol
    use jade

    implicit none

    type(DICT_STRUCT), pointer  :: dict => null()
    logical                     :: stopped = .false.
    integer                     :: unitNo

    open(newunit=unitNo, status='scratch')

    do while (fcgip_accept_environment_variables() >= 0)

        call fcgip_make_dictionary( dict, unitNo )
        call respond(dict, unitNo, stopped)
        call fcgip_put_file( unitNo, 'text/html' )

        if (stopped) exit

    end do !  while (fcgip_accept_environment_variables() >= 0)
    close(unitNo)
    unitNo = fcgip_accept_environment_variables()


contains
    subroutine respond ( dict, unitNo, stopped )

        type(DICT_STRUCT), pointer        :: dict
        integer, intent(in)               :: unitNo
        logical, intent(out)              :: stopped

        character(len=50), dimension(10,2) :: pagevars
        character(len=80)  :: scriptName, query
        character(len=12000) :: templatefile
        integer            :: i

        logical                           :: okInputs

        write(unitNo, AFORMAT) &
            '%REMARK% respond() started ...', &
            	'<!DOCTYPE html><html>', &
            '<head><meta charset="utf-8"/>', &
            '<meta name="viewport" content="width=device-width, initial-scale=1"/>', &
            '<script src="https://htmx.org/js/htmx.js"></script>', &
            '<title>HTMX / Fortran (same-thing)</title>', &
            '<link rel="stylesheet" href="/assets/global.css"/>', &
            '</head><body>'


        ! use a 2D array for key-value pairs -
        pagevars(1,1) = 'fioname'
        pagevars(1,2) = 'Fortran.io'
        pagevars(2,1) = 'fiihref'
        pagevars(2,2) = '//fortran.io'
        pagevars(3,1) = 'fioimg'
        pagevars(3,2) = '//fortran-lang.org/_static/images/favicon.ico'
        pagevars(4,1) = 'htmxname'
        pagevars(4,2) = 'HTMX'
        pagevars(5,1) = 'htmxhref'
        pagevars(5,2) = '//htmx.org'
        pagevars(6,1) = 'htmximg'
        pagevars(6,2) = '//htmx.org/img/htmx_logo.2.png'

        call cgi_get( dict, "DOCUMENT_URI", scriptName )

        select case (trim(scriptName))
          case ('/')
            templatefile = 'template/index.jade'
            call jadefile(templatefile, unitNo)
          case ('/details')
            templatefile = 'template/details.jade'
            call jadetemplate(templatefile, unitNo, pagevars)
          case DEFAULT
            write(unitNo,AFORMAT) 'Page not found!'
        end select

        ! end of response
        write(unitNo,AFORMAT) '</body>', &
            '</html>', &
            '%REMARK% respond() completed ...'

        return

    end subroutine respond

end program test_fcgi
