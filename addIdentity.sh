#!/bin/bash
echo -n 'add an idendity:'
read ID
echo -n 'pre-shaered-key:'
read PSK
echo 'Add ID:'${ID}' PSK:'${PSK}
echo -n 'No more identity? [no/yes(default)]:'
read finished
echo "ID PSK" >> quick.racoon.psk


