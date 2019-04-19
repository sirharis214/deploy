clone the Repo into your ~    **do not clone into a directory, clone straight into ~

Your working directory should look like:
	~/deploy/QA/

This one QA Directory has everything you need.
Files should already be hosted into /var/www/.
restart apache for good measure if you wish.

run the file   ./mark.php
	it will gather info:
	lvl - QA
	machine - FE/BE (based on IP)
	version - based on filename
	filename - based on what is in the directory Files 
		( should only be 1 zip file at any given time, 
		  old pkg gets deleted before new one comes in )
It will prompt you to type status, good or bad.
done with QA.

