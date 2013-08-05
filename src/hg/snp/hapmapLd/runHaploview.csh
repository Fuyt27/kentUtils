#!/bin/csh -ef
# DO NOT EDIT this file in any installed-bin location --
# edit kent/src/hg/snp/hapmapLd/runHaploview.csh instead.

# $Id: runHaploview.csh,v 1.2 2007/10/31 05:44:37 angie Exp $

# Originally written by Daryl Thomas ~Feb. 2006 (see makeDb/doc/hg17.txt).
# Haploview cluster-run job script.

if ( $#argv < 2 ) then
    echo "usage: $0 </path/genotype.txt.gz> </path/java> </path/Haploview.jar> [<javaMaxMem>]"
    echo "       $0 /san/etc/chr1.etc.txt.gz /usr/java/jre1.5.0_12/bin/java /san/etc/Haploview.jar 4G"
    exit 1
endif
set txt = $1
set jre = $2
set jar = $3
set memFlag = ""
if ( $#argv >= 4 ) then
    set memFlag = "-Xmx$4"
endif
if ( `uname -i` == "x86_64" ) then
  set cpuFlag = "-d64"
else
  set cpuFlag = ""
endif
set txtDir = $txt:h
set txtFile = $txt:t
set root = $txtFile:r

mkdir -p /scratch/tmp
set tmpDir = `mktemp -d -p /scratch/tmp runHaploview.XXXXXX`
pushd $tmpDir
gunzip -c $txt > $root
$jre $cpuFlag $memFlag \
  -jar $jar \
  -nogui -dprime -check -maxDistance 250 -hapmap $root

gzip   -f $root.LD    $root.CHECK
mv     -f $root.LD.gz $root.CHECK.gz $txtDir/
popd
rm -r $tmpDir