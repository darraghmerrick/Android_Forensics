##############################################################################
#****************************Author: Darragh Merrick*************************#
#******************************created: 10/04/2013***************************#
#*******************************Android Script Menu**************************#
##############################################################################
#use strict;
#!/usr/bin/perl
use warnings;
print " \n                                            .?               ,=                        \n ";      
	print "                                           .,I             +?.                        \n ";     
	print "                                            .:I,IIIIIIIII.?=.                         \n ";      
	print "                                           .:IIIIIIIIIIIIIII~.                        \n ";      
	print "                                         .=IIIIIIIIIIIIIIIIIII=.                      \n ";      
	print "                                        .IIII...IIIIIIIII...IIII.                     \n ";     
	print "                                        IIIIII,+IIIIIIIII?,IIIIII                     \n ";      
	print "                                     .~IIIIIIIIIIIIIIIIIIIIIIIII+.                    \n ";     
	print "                                      .IIIIIIIIIIIIIIIIIIIIIIIIIII.                   \n ";      
	print "                                      ........................... .                   \n ";      
	print "                                ~III. .IIIIIIIIIIIIIIIIIIIIIIIIIII. .III+             \n ";      
	print "                               ?IIIII..IIIIIIIIIIIIIIIIIIIIIIIIIII..IIIII?.           \n ";     
	print "                              .IIIIII..IIIIIIIIIIIIIIIIIIIIIIIIIII..IIIIII.           \n ";     
	print "                              .IIIIII..IIIIIIIIIIIIIIIIIIIIIIIIIII..IIIIII.           \n ";      
	print "                              .IIIIII..IIIIIIIIIIIIIIIIIIIIIIIIIII..IIIIII.           \n ";      
	print "                              .IIIIII..IIIIIIIIIIIIIIIIIIIIIIIIIII..IIIIII.           \n ";     
	print "                              .IIIIII..IIIIIIIIIIIIIIIIIIIIIIIIIII..IIIIII.           \n ";     
	print "                              .IIIIII..IIIIIIIIIIIIIIIIIIIIIIIIIII..IIIIII.           \n ";      
	print "                              .IIIIII..IIIIIIIIIIIIIIIIIIIIIIIIIII..IIIIII.           \n ";     
	print "                              .IIIIII..IIIIIIIIIIIIIIIIIIIIIIIIIII..IIIIII.           \n ";      
	print "                              .+IIIII..IIIIIIIIIIIIIIIIIIIIIIIIIII..IIIII?.           \n ";      
	print "                                .III. .IIIIIIIIIIIIIIIIIIIIIIIIIII. .III:             \n ";     
	print "                                      .IIIIIIIIIIIIIIIIIIIIIIIIIII.                   \n ";      
	print "                                      .IIIIIIIIIIIIIIIIIIIIIIIIIII.                   \n ";     
	print "                                      .IIIIIIIIIIIIIIIIIIIIIIIIIII.                   \n ";     
	print "                                        =IIIIIIIIIIIIIIIIIIIIIII+.                    \n ";     
	print "                                           .IIIIII.   .IIIIII.                        \n ";     
	print "                                           .IIIIII.   .IIIIII.                        \n ";      
	print "                                           .IIIIII.   .IIIIII.                        \n ";      
	print "                                           .IIIIII.   .IIIIII.                        \n ";     
	print "                                           .IIIIII.   .IIIIII.                        \n ";     
	print "                                            .?III      .?III.                         \n ";
	print "\n************************************************************************************ "; 
	print "\n*                            Welcome to Android Extraction Toolkit                 * ";
	print "\n************************************************************************************ ";
$num = 2; # A delay to give user a chance to read greeting.
	while($num--){
	sleep(1);
	             }
error:
	

	print " \n To Check if the Android device is rooted > Press 1 \n ";
	print " \n *****************************************************************************************\n ";
	print " \n To run Android Xtract, to phycially image Android filesystem partitions > Press 2\n ";
	print " \n *****************************************************************************************\n ";
	print " \n To remove programs installed by Android Xtract after the extraction process > Press 3\n ";
	print " \n *****************************************************************************************\n ";
	print " \n To bypass the Android Screen Swipe Lock > Press 4\n ";
	print " \n *****************************************************************************************\n ";
	print " \n Installs AFLogical and disables the screen-lock  > Press 5\n ";
	print " \n *****************************************************************************************\n ";
	print " \n Install Lime and capture RAM > Press 6\n ";
	print " \n *****************************************************************************************\n ";
	print " \n search device for photos and extract if found > Press 7\n ";
	print " \n *****************************************************************************************\n ";
	print " \n Extract Browser history from device > Press 8\n ";
	print " \n *****************************************************************************************\n ";
	print " \n Extract all data from com.android.providers > Press 9\n ";
	print " \n *****************************************************************************************\n ";
	print " \n Exit > Press 10\n ";
	print " \n *****************************************************************************************\n ";
	print " \n Enter Choice number (1-10): ";

	my $choice = <STDIN>; #The program chosen by the user.
	chomp $choice; 
	if ($choice == 1 ) {
	print "Checking if the Android device is rooted\n";
	my $Script1 =system("/usr/bin/perl  Android_Root_Check.pl ");
		           }
	elsif ($choice == 2 ) {
	print "The 'Android Xtract' program will now attempt to determine the devices filesystem and physically image partitions\n";
	my $Script2 =system("/usr/bin/perl  Android_Xtract.pl ");
			      }
	elsif ($choice == 3) {
	print "  This program removes programs installed by Android Xtract\n";
	my $Script3 =system("/usr/bin/perl  remove_Android_Extract.pl ");
			      }
	elsif ($choice == 4 ) {
	print "This program bypasses the Android Screen Swipe Lock.\n";
	my $Script4 =system("/usr/bin/perl  screen_unlock.pl ");
			      }
	elsif ($choice == 5 ) {
	print "This program pushes and installs AFLogical and disables the screen-lock to allow the investigator to open the application and start the capture.\n";
	my $Script5 =system("/usr/bin/perl  AFLogical-auto.pl ");
			      }
	elsif ($choice == 6 ) {
	print "Android Live data Forensics – this program will install Lime and capture RAM.\n";
	my $Script6 =system("/usr/bin/perl  Android_LDF.pl ");
			      }
	elsif ($choice == 7) {
	print "This program will search the Android device for photos and extract if found\n";
	my $Script7 =system("/usr/bin/perl  get_photos.pl ");
			      }
	elsif ($choice == 8) {
	print "This program will extract Browser history from the Android device.\n";
	my $Script8 =system("/usr/bin/perl  Extract_Google_Data.pl ");
			      }
	elsif ($choice == 9 ) {
	print "This program will extract all data from com.android.providers\n";
	my $Script9 =system("/usr/bin/perl  Extract_com.android.providers.pl ");
			      }
	elsif ($choice == 10 ) {
	print "Thank you for using the Android Extraction toolkit. \n Goodbye\n";
	goto end;
			      }
	else 	{
	print " That is not a valid input, please enter (1-10)\n";
	goto error;
		}
end:
	print "Thank you for using the Android Extraction toolkit. \n Goodbye\n";	

