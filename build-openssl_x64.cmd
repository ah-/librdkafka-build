REM "NASM (http://www.nasm.us) is required to compile OpenSSL"
REM "ActivePerl (http://www.activestate.com/activeperl) is required to compile OpenSSL"
REM "Perl module Text::Template is required to compile OpenSSL"

CALL "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64

SET var=%cd%
ECHO %var%

cd openssl

cd
dir

git reset --hard HEAD
git fetch
git checkout OpenSSL_1_0_2-stable

mkdir %var%\openssl_dist
mkdir %var%\openssl_dist\x64

git clean -f

perl Configure VC-WIN64A  --prefix=%var%\openssl_dist\x64
CALL ms\do_win64a.bat
nmake -f ms/nt.mak clean
nmake -f ms/nt.mak
nmake -f ms/nt.mak test 
nmake -f ms/nt.mak install

echo copy /Y %var%\openssl_dist\x64\lib\libeay32.lib %var%\lib\x64\libeay32MT.lib
copy /Y %var%\openssl_dist\x64\lib\libeay32.lib %var%\lib\x64\libeay32MT.lib
echo copy /Y %var%\openssl_dist\x64\lib\ssleay32.lib %var%\lib\x64\ssleay32MT.lib
copy /Y %var%\openssl_dist\x64\lib\ssleay32.lib %var%\lib\x64\ssleay32MT.lib

cd ..