#!/bin/bash

V="1.2.3"

cd ~/Desktop/Test
zip FE_${V}.zip FE/*

cd ~/Desktop/Test
unzip FE_${V}.zip -d ~/Desktop/Test/New 
