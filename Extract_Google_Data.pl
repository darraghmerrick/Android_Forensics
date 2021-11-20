##############################################################################
#****************************Author: Darragh Merrick*************************#
#******************************created: 12/07/2013***************************#
#******************************Extract Google Data*****^^^^^*****************#
##############################################################################

#!/usr/bin/perl -w
use warnings;
$i=0;
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
	my $rw = `adb shell su -c "mount -o remount, rw /dev "`;
	my $temp = `adb shell su -c "mkdir /dev/google_extract "`;
	my $data = `adb shell su -c "ls /data/data"` || die("The /data/data directory can not be found");
	my @data2 = split(" ", $data);
	print " Extracting com.Android.providers data from Android device \n ";
	foreach (@data2)
	 {
   	 if ($_ =~ /^com.google.android/) { # Examines mounted partitions for the presence of ext4 filesystem.
	my $move = `adb shell su -c "cp -R /data/data/$_ /dev/google_extract/"`;
	print " Extracting $_ \n ";
	$i++;	
                                             } 
	 }
        if ($i==0) {
	print " No com.google.android data was extracted :-(\n ";
	
	}
	if ($i>0)  {
	my $permissions = `adb shell su -c "chmod -R 755 /dev/google_extract"`;
	my $extract =`adb pull /dev/google_extract/`;
	my $remove = `adb shell su -c "rm -r /dev/google_extract"`;
	
	}
error:	print " Thank you for using Android com.android.providers data Extract \n";
	print "\n To return to main menu >Press 1 \n To finish program now > Press 2 \n";
	my $choice = <STDIN>; #The program chosen by the user.
	chomp $choice; 
	if ($choice == 1 ) {
	my $Script1 =system("/usr/bin/perl  Android_Script_Menu.pl ");
	}
	else {
	print " \n Goodbye :-) \n";
	}
		


