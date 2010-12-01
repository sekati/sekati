<?php
/**
 * Unit Test Runner - Created on Sep 2, 2007, Last Updated on Nov 20, 2008
 * @version 1.1.8
 * @author jason m horwitz | sekati.com
 * Copyright (C) 2007  jason m horwitz, Sekat LLC. All Rights Reserved.
 * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php
 */
header('Content-type: text/html');
header('Cache-Control: no-cache, must-revalidate');
header('Pragma: no-cache');
header('Expires: -1');
//error_reporting(E_ALL ^ E_NOTICE);
error_reporting(E_ALL);

$nl = "\n";
$appName = 'SEKATI API | Visual Test Runner | jason m horwitz | sekati.com';
$header = '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />'.$nl;
$header .= '<script language="javascript" src="../../deploy/js/sekati.js" type="text/javascript"></script>'.$nl;
$header .= '<script language="javascript" src="../../deploy/js/swfobject.js" type="text/javascript"></script>'.$nl;
$header .= '<script language="javascript" src="../../deploy/js/swfmouse.js" type="text/javascript"></script>'.$nl;
$header .= '<script language="javascript" src="../../deploy/js/swffit.js" type="text/javascript"></script>'.$nl;
$header .= '<link rel="stylesheet" type="text/css" href="../../deploy/css/style.css" />'.$nl;
$header .= "<title>".$appName.'</title></head><body>'.$nl;
$header .= '<br /><div><div style="float:left;"><a href="http://sekati.googlecode.com" target="_blank">SEKATI API</a> :: VISUAL TEST RUNNER</div><div style="float:right;"><a href="../index.html" target="_self">UNIT TESTS</a> | <a href="../docs/" target="_blank">DOCUMENTATION</a></div></div><br /><hr />'.$nl;
$footer = '<br/><hr/></body></html>';
$root = ".";
$path = reverse_strrchr($_SERVER['SCRIPT_FILENAME'],'/',0)."/".$root;
$self   = $_SERVER['SCRIPT_NAME'];
$swf	= $_GET['swf'];
$html	= $_GET['html'];

/**
 * Return everything up to the last occurance of the needle + the number of trailing characters.
 * @param string $haystack - the string to be searched.
 * @param string $needle - the string we are searching for.
 * @param number $trail - the number of additional characters to include after the $needle.
 * @return string
 * @example  ( Assuming: $_SERVER["SCRIPT_URI"] = "http://localhost/path/site.swf"; )
 * $ns = reverse_strrchr($_SERVER["SCRIPT_URI"], "/", 1); // returns "http://localhost/path/"
 */
function reverse_strrchr($haystack, $needle, $trail) {
   return strrpos($haystack, $needle) ? substr($haystack, 0, strrpos($haystack, $needle) + $trail) : false;
}

/**
 * Create an html navigation indexing all of the test swf's (which will 
 * be embedded) and html files which will be linked to.
 */
function indexTests() {
	global $path;
	$str = "<div id='index' style=\"position:absolute; top:80%;\"><ol>";
	if ($dir = @opendir($path)) {
		while (false !== ($item = readdir($dir))) {  
			if (preg_match("/.html/", $item)) {
				$str .= "<li><a href=\"?html=$item\"><strong>$item</strong></a></li>";
			} else if (preg_match("/.swf/", $item)) {
				$str .= "<li><a href=\"?swf=$item\">$item</a></li>";
			}
		}
		closedir($dir);
	}
	return $str."</ol></div>";
}

/**
 * Generate a swfIN template
 * @param string $swf - the swf to embed.
 * @return string swfin template.
 */
function template ($swf) {
	global $nl;
	$embed = <<<EOF
	<script type="text/javascript">
		var application = "$swf";
		var objId = 'unitTest'; 
		var divId = 'flash_update';
		var version = '9.0.115';
		var width = '100%';
		var height = '75%';	
		var expressInstall = '../../deploy/expressInstall.swf';
		var flashvars = {};
		//flashvars.config = "xml/config.xml";
		var params = {};
		params.menu = "true";
		params.quality = "high";
		params.scale = "noscale";
		params.wmode = "opaque"; // "window", "transparent", "direct", "gpu"
		params.bgcolor = "#ffffff";
		params.seamlesstabbing = "true";
		params.swliveconnect = "true";
		params.allowfullscreen = "true";
		params.allowscriptaccess = "always";
		params.allownetworking = "all";
		// Attributes
		var attributes = {};
		attributes.id = objId;
		attributes.name = objId;
		if(!sekati.util.isAppleiOS()) {
			swfobject.embedSWF(application, divId, width, height, version, expressInstall, flashvars, params, attributes);
			var mousewheel = new SWFMouse();
			mousewheel.registerObject( attributes.id );
			//swffit.fit( attributes.id, 800, 600 );
		} else {
		}
	</script>	
EOF;
	$str = '<div id="flash_update" style="position:relative;"><h1>Flash Player Upgrade Required</h1><br/><a href="adobe.com/go/flashplayer" target="_blank">&raquo; Download Flash plugin to view this site</a>&nbsp; &nbsp; &nbsp; &nbsp;<a href="javascript:location.reload(true)">&raquo; Enter Site</a></div>'.$embed.$nl;
	return $str;
}

if($swf) {
	$swfURL = preg_split("/.swf/", $swf);	
	die($header.template( $swfURL[0].'.swf').'<hr /><br/>'.indexTests().'<hr /><br />'.$footer );
}
if($html) die ($header."Loading Test: $html ...<meta HTTP-EQUIV='Refresh' CONTENT='1;URL=$html'>.$footer");
echo ($header.indexTests().$footer);
?>
