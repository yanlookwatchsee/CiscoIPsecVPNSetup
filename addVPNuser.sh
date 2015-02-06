#!/bin/bash

echo 'Add user and password:'
echo -n 'add an user:'
read user
echo -n 'password:'
read pass
useradd -r ${user}
echo '${pass}\n${pass}\n\n' |  passwd ${user}





