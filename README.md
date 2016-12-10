I am using Linux Ubuntu to start devoloping apps for my Garmin Vivoactive HR that supports Garmin Connect IQ.

The main instructions I found on this site: http://blog.aaronboman.com/programming/connectiq/2014/11/13/the-garmin-connect-iq-sdk-on-ubuntu-linux/

My quick instructions

* Install Eclipse and the Garmin plugin
Install Eclipse on yor Linux machine and the plugin, as the instructions on Garmin Connect IQ developer page.
On Eclipse, on the plugin options, you will be asked for it to automatically download an SDK (it will download the MAC plugin but works well).

* SDK and Simulator
Checkout this github repository and use the shell scritpts to start the simulator and simulate the app.
Make the bash scripts executable

Inside of the bin directory, you will need to make both the monkeysim_linux and monkeydo_linux files executable. Do that by running the following:

user@machine:~/connectiq/bin$ chmod u+x monkeysim_linux monkeydo_linux

* Install the JDK

If it isn't already installed, you'll need the JDK. If you don't know if it's installed, you can check by running

user@machine:~$ javac -version

If that fails with the message "The program javac can be found in the following packages" then it's not installed. You will need to run the following to install it:

user@machine:~$ sudo apt-get install default-jdk

If you want a more specific version of the JDK or if you want the Oracle JDK check out the tutorial at Digital Oceans.
Install Wine

* Install Wine

In order to run the Windows simulator executable Wine will need to be installed. Install it simply by running:

user@machine:~$ sudo apt-get install wine

After installation has completed, run the wine command and it will do some initial setup such as creating the virtual C drive, program files, etc. These new directories will be placed in ~/.wine.

* Putting it all together

Try testing your setup out on one of the sample projects:

1. build the project code on Eclipse
2. start the simulator: monkeysim_linux &
2. start the simulation: monkeydo_linux bin/Analog.prg

Now you should have a wonderful analog watch face telling you what time it is.
