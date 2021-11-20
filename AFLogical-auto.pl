##############################################################################
#****************************Author: Darragh Merrick*************************#
#******************************created: 10/04/2013***************************#
#*****************************Android Screen Unlock**************************#
##############################################################################
#!/usr/bin/perl
use Android;
use Carp;
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

my $install = `adb install AFLogicalOSE/AFLogical-OSE_1.5.2.apk`; #To install AntiGuard run this command

my $install2 = `adb install AntiGuard/AntiGuard.apk`; #To install AntiGuard run this command

my $start = `adb shell am start -n io.kos.antiguard/.unlock`; #To unlock the screen start the program
print " The screen should now be unlocked, On the Android screen press back to gain access. \n Launch AFLogical.apk and capture data \n ";
error:
print " If the Logical extraction is complete, Enter 1 to continue. \n";
print "If the process failed or screen did not unlock Enter 2 to end. \n";
$answer = <STDIN>;
	chomp $answer;
	if ($answer==1) {
print " AFLogical.apk and Antiguard.apk will now be uninstalled from the Android device \n";
`adb pull /sdcard/forensics`;
my $uninstall = `adb uninstall io.kos.antiguard`;
my $uninstall2 = `adb uninstall com.viaforensics.android.aflogical_ose`;
goto end;
                        }

elsif ($answer == 2)   {
  goto end;
                         }  
  else {
  print "\n That is not a valid input! \n";
  goto error;
       }
end:
print " Thank you for using AFLogical-auto \n";

