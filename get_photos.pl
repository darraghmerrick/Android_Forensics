##############################################################################
#****************************Author: Darragh Merrick*************************#
#******************************created: 12/07/2013***************************#
#***********************************Get photos*******************************#
##############################################################################
#!/usr/bin/perl -w
use warnings;
#$i=0;
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
                                 }
	if($con2[5] =~ /device/) { 
	print "\n adb device successfully connected :-) \n";
				 }
	my $rw = `adb shell su -c "mount -o remount, rw /dev "`;
	my $temp = `adb shell su -c "mkdir /dev/images"`;
	my $list =`adb shell su -c "ls -R /sdcard/"`|| die("The /sdcard directory can not be found"); # Uses linux command `ls -l` to list contents.
	my @list =split(" ", $list);
	foreach (@list) {
	if ($_ =~ /^\/sdcard\//)  {
	unshift (@dir,$_);
	$dir[0] =~ s/\:/\//g; #replace : with /

	 }
	elsif ($_ =~ m/\.gif/i) { 
	my $move = `adb shell su -c "cp "$dir[0]$_" /dev/images/"`;
	print " Extracting $dir[0]$_ \n ";
	$i++;
                            }
	                 
	elsif ($_ =~ m/\.png/i) {
	my $move = `adb shell su -c "cp "$dir[0]$_" /dev/images/"`;
	print " Extracting $dir[0]$_ \n ";
	$i++;	
	                        }
	elsif ($_ =~ m/\.jpg/i) {
	my $move = `adb shell su -c "cp "$dir[0]$_" /dev/images/"`;
	print " Extracting $dir[0]$_ \n ";
	$i++;	
	                       }
	elsif ($_ =~ m/\.jpeg/i) {
	my $move = `adb shell su -c "cp "$dir[0]$_" /dev/images/"`;
	print " Extracting $dir[0]$_ \n ";
	$i++;	
	                       }
		             }
	my $extract =`adb pull /dev/images/`;
	my $remove = `adb shell su -c "rm -r /dev/images"`;			
	if ($i eq 0)	{
	print " No images were found on this Android device \n";
                        }
error:	print " Thank you for using Android photo Extract \n";
	print "\n To return to main menu >Press 1 \n To finish program now > Press 2 \n";
	my $choice = <STDIN>; #The program chosen by the user.
	chomp $choice; 
	if ($choice == 1 ) {
	my $Script1 =system("/usr/bin/perl  Android_Script_Menu.pl ");
	}
	else {
	print " \n Goodbye :-) \n";
	}
			
