# Android_Forensics
A Collection of Perl Scripts for Android Forensics written for MSc Dissertation
![](https://github.com/darraghmerrick/Android_Forensics/blob/main/Android_Extract.png)
The scripts included in this directory were created as part of a Dissertation for MSc in Forensic Computing
 and Cybercrime investigation.
The aim is contribute to the field of Android smartphone and tablet forensic investigation.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
The author will be in no way liable for any damages to devices or loss of data that may occur.

These Scripts are intended to run on a Ubuntu OS.
To start the Android toolkit execute `perl Android_Script_Menu.pl`, This will start a menu with 10 options;

1. To Check if the Android device is rooted.

2. To run Android Xtract, to phycially image Android filesystem partitions

3. To remove programs installed by Android Xtract after the extraction process.

4. To bypass the Android Screen Swipe Lock.

5. Installs AFLogical and disables the screen-lock.

6. Install Lime and capture RAM.

7. Search device for photos and extract if found.

8. Extract Browser history from device.

9. Extract all data from com.android.provider.

10. Exit Menu

To run these scripts it is assumed that abd is installed and that the vendor list has been added to udev rules,
on linux machine. For any of the physical imaging programs, the target device must be rooted.

