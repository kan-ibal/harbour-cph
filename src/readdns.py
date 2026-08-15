#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#import pyotherside
import subprocess
import tempfile

def connmandns():
    tempfile.tempdir = '/tmp'
    try:
     f = open("/run/connman/resolv.conf")
    except FileNotFoundError:
     # doesn’t exist
     file1 = open("/run/systemd/resolve/resolv.conf", "r")
    else:
     # exists
     file1 = open("/run/connman/resolv.conf", "r")
    #$print("Output of Read function is ")
    #print(file1.read())
    #print()
    t = []
    for line in file1.readlines():
     line = line.strip()
     t.append(line)
    for i in range(len(t)):
     if 'nameserver' in t[i]:
      dns = t[i].split( )
      #print( dns[1] )
      break
    #print( dns[1] )
    ip = str('1.1.1.1')
    dnss='https://'+dns[1]
    proc = subprocess.Popen(["curl", "-I", "--max-time", "2", "--connect-timeout", "3", "--silent", dns[1]], cwd=tempfile.tempdir, shell=False, stdout=subprocess.PIPE)
    (out, err) = proc.communicate()
    #print ( out )
    #print ( err )
    if len(out) != 0:
     return dns[1]
     #pyotherside.send( 'ipAddress', dns[1] )
    else:
     proc2 = subprocess.Popen(["curl", "-I", "--max-time", "2", "--connect-timeout", "1", "--silent", "--insecure", dnss], cwd=tempfile.tempdir, shell=False, stdout=subprocess.PIPE)
     (out2, err2) = proc2.communicate()
     #print ( out2 )
     #print ( err2 )
     if len(out2) != 0:
      return dns[1]
      #pyotherside.send( 'ipAddress', dns[1] )
     else:
      return ip
      #pyotherside.send( 'ipAddress', ip )
    file1.close()

#connmandns()
