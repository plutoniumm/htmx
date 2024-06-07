#!/bin/sh
make clean;
make;
echo "Cleaned and recompiled";

spawn-fcgi -a 127.0.0.1 -p 9000 ./fortran_fcgi;
echo "Spawned new process";
nginx -s reload;
echo "Nginx reloaded";