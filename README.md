I am using Linux Ubuntu to start devoloping apps for my Garmin Vivoactive HR that supports Garmin Connect IQ.

The main instructions I found on this site: http://blog.aaronboman.com/programming/connectiq/2014/11/13/the-garmin-connect-iq-sdk-on-ubuntu-linux/

My quick instructions
Download the SDK
You will need a copy of the SDK. Hop on over to your friendly neighborhood Connect IQ store and grab a copy of the Windows SDK. You will then need to extract the zip file to location you want to install. For example, I put mine in my home directory: /home/aaron/connectiq.
Next, for convenience, place the connectiq/bin directory in your PATH. Edit your ~/.bashrc like so:
export PATH=$PATH:~/connectiq/bin
