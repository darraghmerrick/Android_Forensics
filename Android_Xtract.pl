##############################################################################
#****************************Author: Darragh Merrick*************************#
#******************************created: 10/04/2013***************************#
#*************************Android Data Acquisition Tool**********************#
##############################################################################

#!/usr/bin/perl -w
use warnings;
START:
&connectivity;

	sub connectivity # This subroutine will start adb and attempt to connect to android adb enabled device
	{                # This subroutine will also determine whether the device uses an ext4 or yaffs2 filesystem.
	                                                  

	print "\n************************************************************************************ "; 
	print "\n*                                      Welcome to Android Xtract                   * ";
	print "\n************************************************************************************ ";
	print " \n This program is distributed in the hope that it will be useful,\n but WITHOUT ANY WARRANTY; without even the implied warranty of \n MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. The author \n will be in no way liable for any damages to devices or loss of data \n that may occur.\n";
	print " \n Please connect Android device now ...\n";
	open (FH,">>results.txt");#opens filename results.txt for appending
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
	goto error;            }
	if($con2[5] =~ /device/) { 
	print "\n adb device successfully connected :-)";
                                 }
	
	my $fs = `adb shell 'mount'\n`; #store mount data in an array
	my @fs2 = split(" ", $fs);
	print " Checking filesystem type: \n ";
	foreach (@fs2)
	 {
   	 if ($_ =~ /ext4/) { # Examines mounted partitions for the presence of ext4 filesystem.
	goto Ext4_Imaging;        } # Jump to ext4 imaging subroutine.
        elsif ($_=~ /yaffs2/) { # Examines mounted partitions for the presence of yaffs2 filesystem.
 	goto yaffs2_Imaging;                } # Jump to yaffs2 imaging subroutine.
		
	}
	
	print " Could not determine filesystem! yaffs2, ext4 and FAT are the only filesystems supported by this program\n ";
	goto end;
	     
        } # End of sub connectivity.
Ext4_Imaging:
	sub Ext4_Imaging; # This subroutine will image ext4 partitions using 'dd' in a forensically sound manner.
	{
	print "\n The Filesystem on this device is Ext4 \n";
	$num = 2; # A delay to give user a chance to read error message.
	while($num--){
	sleep(1);
	             }
	my $adb =`adb forward tcp:54321 tcp:12345`; #forward tcp 12345 (port on which netcat is listening) of the droid to tcp 54321 on the PC. 
	print "\n $adb  \n Now printing a list of mounted partitions: \n";
	my $mount = `adb shell 'mount'`; 
	print FH "$mount\n"; #print the data from $mount into the file results.txt
	my $df = `adb shell 'df'`;
	print FH "$df\n"; #print the data from $df into the file results.txt
	print " \n $mount \n $df \n"; # Display Mounted partitions & Report how much free disk space is available for each mount.
	print " \n Which mounted partition is to be imaged? \n Enter full path e.g. /dev/block/sdb[n] \n";
        my $partition = <STDIN>; #Enter partition to be imaged.
	chomp $partition; 
	if (($partition !~ /^\/dev\/block\/sdb/)&&($partition !~ /^\/dev\/block\/vold/)){
	print " You entered $partition \n The file path you have entered is not valid! \n The file path must contain /dev/block/sdb[n]\n";
	$num = 2; # A delay to give user a chance to read error message.
	while($num--){
	sleep(3);
	             }
	goto Ext4_Imaging; 
					                                                                                              
	
	                                          }
	print "Calculating md5sum of $partition will now start\n ";
	my $md5sum = `adb shell su -c "md5sum $partition"`; #md5sum to compare later to image md5sum.
	print " $partition \n $md5sum\n";
	print FH "The md5sum of $partition = $md5sum\n "; #print the data from $md5sum into the file results.txt
	print " \n Open a new terminal window. \n To save the image Enter:\n nc 127.0.0.1 54321|pv >FILENAME.dd \n"; # Save the nc data to pc. 
	print "\n If netcat won't connect to droid, execute command 'netstat -at' to view connections.\n"; # netcat troubleshooting message to user.                                                                                    
	print "\n  The localhost should be listening on tcp port 54321, set by command 'adb forward tcp:54321 tcp:12345' earlier. ";
	print "\n ******************************************************************************"; 
	print "\n * Proto Recv-Q Send-Q Local Address           Foreign Address         State  *";
	print "\n * tcp        0      0 localhost:54321         *:*                     LISTEN *";
	print "\n ******************************************************************************";
	if ($partition =~ /^\/dev\/block\/sdb3/) {
	print "\n You have chosen to image $partition \n Waiting for netcat to receive file in new terminal window \n";
	my $dd = `adb shell su -c "/dev/Android_Physical/busybox dd if=$partition bs=4096 |/dev/Android_Physical/busybox nc -l -p 12345"`;
	print "\n $dd \n";
	goto md5sum;
	                                            }
	elsif ($partition =~ /^\/dev\/block\/vold/) {
	print "\n You have chosen to image $partition \n";
	my $dd2 = `adb shell su -c "dd if=$partition bs=32768 | nc -l -p 12345"`;
	print "\n $dd \n";
	goto md5sum;
	                                               }
	if ($partition =~ /^\/dev\/block\/mmcblk1/) {
	print "\n You have chosen to image $partition \n Waiting for netcat to receive file in new terminal window \n";
	my $dd = `adb shell su -c "dd if=$partition bs=4096 | nc -l -p 12345"`;
	print "\n $dd \n";
	goto md5sum;
	                                            }
md5sum:	
	print "\n please calculate md5sum of the $partition image and compare it to the $md5sum to ensure the integretity of the copy. \n";
again:
	print "\n Does the md5sum match? \n Yes => Press: 1 \n No => Press: 2  \n"; # Check if errors occured during transfer.	
	$answer = <STDIN>;
	chomp $answer;
	if ($answer==2) {
	print " \n Restarting imaging of partition \n"; # Copy is not the same, restart imaging process.
	$num = 2; # A delay to give user a chance to read warning.
	while($num--){
	sleep(1);
	             }
	goto Ext4_Imaging; 
                          } 
	elsif ($answer==1) {
	print " \n $partition has been successfully imaged. \n";
	                   }
	else		   {
	print "\n That is not a valid input! \n";
	goto again;
	             }
	
	} # End of sub Ext4_Imaging;
  # Next section will give user an option to image another partition or finish program.
reimage2:
  print "\n Do you want to image another partition? \n Yes => Press: 1 \n No => Press: 2  \n";
  $answer3 = <STDIN>;
  chomp $answer3;
  if ($answer3 == 1) {
  goto Ext4_Imaging; 
                   } 
   elsif ($answer3 == 2)   {
  goto end;
                         }  
  else {
  print "\n That is not a valid input! \n";
  goto reimage2;
	             }  
yaffs2_Imaging:
	sub yaffs2_Imaging; # This subroutine will image yaffs2 partitions using 'nanddump' in a forensically sound manner.
	{
	print "\n The Filesystem on this device is yaffs2 \n";
	my $adb =`adb forward tcp:54321 tcp:12345`; #forward tcp 12345 (port on which netcat is listening) of the droid to tcp 54321 on the PC. 
	print "\n $adb  \n Now printing a list of mounted partitions: \n";
	my $mount = `adb shell 'mount'`; 
	print FH "$mount\n"; #print the data from $mount into the file results.txt
	my $mtd = `adb shell su -c "cat /proc/mtd"`;
	print FH "$mtd\n"; #print the data from $mtd into the file results.txt
	print " \n $mount \n $mtd"; # Display Mounted partitions & Report how much free disk space is available for each mount.
	print " \n Which mounted partition is to be imaged \n Enter full path e.g. /dev/mtd/mtd8\n";  
	my $partition = <STDIN>; #Enter partition to be imaged.
	if ($partition !~ /^\/dev\/mtd\/mtd/) {
	print " You entered $partition \n The file path you have entered is not valid! \n The file path must contain /dev/mtd/mtd[n]\n";
	$num = 2; # A delay to give user a chance to read greeting.
	while($num--){
	sleep(3);
	             }
	goto yaffs2_Imaging;
					      }
	chomp $partition;
	print "Calculating md5sum of $partition will now start\n ";
	my $md5sum = `adb shell su -c "md5sum $partition"`; #md5sum to compare later to image md5sum.
	print " $partition \n $md5sum\n";
	print FH "The md5sum of $partition = $md5sum\n"; #print the data from $fs into the file results.txt
	#my $term = `gnome-terminal --tab`;
	print " \n Open a new terminal window. \n To save the image Enter:\n nc 127.0.0.1 54321|pv >FILENAME.dd \n"; # Save the nc data to pc.                                                                                     
	print "\n If netcat won't connect to droid, execute command 'netstat -at' to view connections.\n"; # netcat troubleshooting message to user.
	print "\n  The localhost should be listening on tcp port 54321, set by command 'adb forward tcp:54321 tcp:12345' earlier. ";
	print "\n ******************************************************************************"; 
	print "\n * Proto Recv-Q Send-Q Local Address           Foreign Address         State  *";
	print "\n * tcp        0      0 localhost:54321         *:*                     LISTEN *";
	print "\n ******************************************************************************";

	my $nanddump = `adb shell su -c "nanddump $partition | nc -l -p 12345"`; # # Execute nanddump command. 
	print "\n $nanddump \n";
	print "\n please calculate md5sum of the $partition image and compare it to the $md5sum to ensure the integretity of the copy. \n";
again:
	print "\n Does the md5sum match? \n Yes => Press: 1 \n No => Press: 2  \n"; # Check if errors occured during transfer.	
	$answer4 = <STDIN>;
	chomp $answer4;
	if ($answer4==2) {
	print " \n Restarting imaging of partition \n"; # Copy is not the same, restart imaging process.
	$num = 2; # A delay to give user a chance to read warning.
	while($num--){
	sleep(1);
	             }
	goto yaffs2_Imaging; 
                          } 
	elsif ($answer4==1) {
	print " \n $partition has been successfully imaged. \n";
	goto reimage;
	                   }
	else		   {
	print "\n That is not a valid input! \n";
	goto again;
	             }
	
	} # End of sub yaffs2_Imaging;
  # Next section will give user an option to image another partition or finish program.
reimage:
  print "\n Do you want to image another partition? \n Yes => Press: 1 \n No => Press: 2  \n";
  $answer2 = <STDIN>;
  chomp $answer2;	
  if ($answer2 == 1) {
  goto yaffs2_Imaging; 
                   } 
  elsif ($answer2 == 2)   {
  goto end;
                         }  
  else {
  print "\n That is not a valid input! \n";
  goto reimage;
	             }
error:
  print "\n When device is ready, Press:1 to attempt reconnect or Press 2 to end program. \n";
  $adb = <STDIN>;
  chomp $adb;
 	if ($adb==1) {
	print " \n Attempting to reconnect adb device \n";
	$num = 2; # A delay to give user a chance to read warning.
	while($num--){
	sleep(1);
	                }
 	goto START; 
                     }
 	elsif ($adb==2)	{ 
 	print " \n adb connection aborted! \n"; # user has terminated program
	$num = 2; # A delay to give user a chance to read warning.
	while($num--){
	sleep(1);
	                }	
	goto end;
	             }
	else         {
	print "\n That is not a valid input! \n";
	goto error;
                     }
end:
   print " \n Do you want to image another Android device? \n Yes => Press: 1 \n No => Press: 2 \n";
   $end = <STDIN>;
   chomp $end;
   if ($end == 1) {
   print " \n Please disconnect current device from usb port. \n";
   $num = 2; # A delay to give user a chance to disconnect device.
	while($num--){
	sleep(3);
	             }
   goto START; 
                  }
   elsif ($end == 2) 	{ 
 
   goto finish;
                        }
   else    {
   print "\n That is not a valid input!\n";
   goto end;
        }
finish:
   print " \n Thank you for using the Android Xtract \n";
   print " \n This program was brought to you by; \n Name: Darragh Merrick \n University: UCD School of Computer Science and Informatics";
   print " \n Course: Computer Forensics and Cybercrime Investigation  \n Position: MsC Student"; 
   print " \n Research Project: 'The growth of Android, and its impact on Forensic Examiners' \n";
   print "\n To return to main menu >Press 1 \n To finish program now > Press 2 \n";
   my $choice = <STDIN>; #The program chosen by the user.
   chomp $choice; 
   if ($choice == 1 ) {
   my $Script1 =system("/usr/bin/perl  Android_Script_Menu.pl ");
	              }
   else {
   print " \n Goodbye :-) \n";
	}



