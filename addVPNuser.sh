#!/bin/bash

echo 'Add user and password:'
echo -n 'add an user:'
read user
echo -n 'password:'
read pass
useradd -r ${user}
echo -e "${pass}\n${pass}\n" |  passwd ${user}





