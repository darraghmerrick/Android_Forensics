##############################################################################
#****************************Author: Darragh Merrick*************************#
#******************************created: 12/07/2013***************************#
#***********************************Android_LDF******************************#
##############################################################################
#use strict;
use warnings;
print " \n This program is distributed in the hope that it will be useful,\n but WITHOUT ANY WARRANTY; without even the implied warranty of \n MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. The author \n will be in no way liable for any damages to devices or loss of data \n that may occur.\n";
	print " \n Please connect Android device now ...\n";
	$num = 2; # A delay to give user a chance to read greeting.
	while($num--){
	sleep(1);
	             }
my $kill =`adb wait-for-device`;          # Ensure graceful start.
	my $con1 = `adb devices`;             # Connect to android device and display serial.
	my @con2 = split(" ", $con1);
	print " \n @con2 \n";
	if($con2[5] !~ /device/) { # This process troubleshoots no adb connection (when adb is turned off)!
	print "\n No adb connection! \n Please check that usb is connected to the device and that adb is enabled on it.";
	print "\n The local machine has a valid adb vendor list in location /etc/udev/rules.d/51-android.rules\n";
	print "\n Execute 'lsusb' command from Linux terminal to show connected usb devices\n";
	goto error;              }
	if($con2[5] =~ /device/) { 
	print "\n adb device successfully connected :-) \n";
print "Lime is now being installed \n";
my $lime = `adb push lime.ko /dev/lime.ko`;
my $tcp = `adb forward tcp:4444 tcp:4444`;
print "Lime is capturing memory \n";
my $capture = `adb shell su -c "/dev/lime.ko “path=tcp:4444 format=lime”`;
my $forward = `nc localhost 4444 > ram.lime`;
                                 }
print " Check that ram.line has been saved to your local directory \n";
print " Thank you for using Android_LDF \n";

