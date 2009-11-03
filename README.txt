
------------------------------------------------------------------------------------

 ____    ____    __  __   ______  ______  ______      ______  ____    ______     
/\  _`\ /\  _`\ /\ \/\ \ /\  _  \/\__  _\/\__  _\    /\  _  \/\  _`\ /\__  _\    
\ \,\L\_\ \ \L\_\ \ \/'/'\ \ \L\ \/_/\ \/\/_/\ \/    \ \ \L\ \ \ \L\ \/_/\ \/    
 \/_\__ \\ \  _\L\ \ , <  \ \  __ \ \ \ \   \ \ \     \ \  __ \ \ ,__/  \ \ \    
   /\ \L\ \ \ \L\ \ \ \\`\ \ \ \/\ \ \ \ \   \_\ \__   \ \ \/\ \ \ \/    \_\ \__ 
   \ `\____\ \____/\ \_\ \_\\ \_\ \_\ \ \_\  /\_____\   \ \_\ \_\ \_\    /\_____\
    \/_____/\/___/  \/_/\/_/ \/_/\/_/  \/_/  \/_____/    \/_/\/_/\/_/    \/_____/

------------------------------------------------------------------------------------

 THE SEKATI ACTIONSCRIPT 3.0 API  - http://sekati.googlecode.com - 2007-2009                             

------------------------------------------------------------------------------------

I. Introduction

	SEKATI API s a high-level multipurpose pure Actionscript 3.0 framework designed 
	to bootstrap the development of flash/flex projects and applications. It is the 
	successor of the SASAPI (AS2) framework, and boasts a flexible configuration 
	structure, large collection of useful groundwork classes, utilities, test files 
	and xml configurable application skeleton.

	A Buildfile is included with Ant tasks for generating project structures, 
	compilation, generating asdoc documentation and automating deployment via 
	rsync+ssh.

	Specific attention has been paid to writing thorough and concise Documentation for 
	the API and generating useful Unit Tests to allow the framework to be easily tapped
	and referenced as needed.

	Project Page:	http://sekati.googlecode.com/
	SVN Repository:	http://sekati.googlecode.com/svn/trunk/


II. Documentation
	
	Specific attention has been paid to writing thorough and concise Documentation for 
	the API and generating useful Unit Tests to allow the framework to be easily tapped
	and referenced as needed.
	
	Documentation:		http://docs.sekati.com/sekati/
	Changelog:			http://code.google.com/p/sekati/source/browse/trunk/CHANGELOG.txt
	Unit Tests:			http://api.sekati.com/sekati/tests/
	Visual Tests:		http://api.sekati.com/sekati/tests/visual/


III. Feedback

	I am interested in feedback of every kind, be it a bug, feature request or question.

	Issue Tracker:		http://code.google.com/p/sekati/issues/list
	Project Wiki:		http://code.google.com/p/sekati/w/list
	Project Feeds:		http://code.google.com/p/sekati/feeds
	Discussion List:	http://groups.google.com/group/sekati-api
	
IV. License & Credits
	License:			http://code.google.com/p/sekati/wiki/License
	Credits:			http://code.google.com/p/sekati/wiki/Credits


V. Notes
	
	If you are just getting started with the framework you should take a look at the 
	core classes: App, Bootstrap & Document as well as the example implementations:
	SekatiMain, SekatiPreloader. Additionally if you are using INDE or Eclipse & FDT 
	there are a number of launch profiles you may use to compile these examples.
	
	A note on launch profiles: most mxmlc swf building profiles are best run from 
	the "Run->Debug Configuration" FDT menu, however the ASDoc profile should be
	launched from "Run->External Tools->External Tools Configuration..." menu and
	similarly the Air launch profile needs to be run from the 
	"Run->Run Configurations" menu.