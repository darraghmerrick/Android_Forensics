##############################################################################
#****************************Author: Darragh Merrick*************************#
#******************************created: 10/04/2013***************************#
#*******************************Android Root Check***************************#
##############################################################################
#!/usr/bin/perl -w
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
                                 }
my $check = `adb shell su -c "id "`or die "$!\n This Android device does not have root access";
my @check2 = split(" ", $check);
if ($check2[0] =~ /root/) {
print " \n This Android device has root access \n";
}
else {
print "\n This Android device does not have root access \n";
	}
print "\n To return to main menu >Press 1 \n To finish program now > Press 2 \n";
my $choice = <STDIN>; #The program chosen by the user.
chomp $choice; 
if ($choice == 1 ) {
my $Script1 =system("/usr/bin/perl  Android_Script_Menu.pl ");
}
else {
print " \n Goodbye :-) \n";
}


