<?php
/**
 * Unit Test Runner - Created on Sep 2, 2007, Last Updated on Mar 7, 2008
 * @version 1.1.5
 * @author jason m horwitz | sekati.com
 * Copyright (C) 2007  jason m horwitz, Sekat LLC. All Rights Reserved.
 * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php
 */
header('Content-type: text/html');
header('Cache-Control: no-cache, must-revalidate');
header('Pragma: no-cache');
header('Expires: -1');
error_reporting(E_ALL ^ E_NOTICE);

$nl = "\n";
$appName = 'Sekati Unit Test Runner | jason m horwitz | sekati.com';
$header = '<!-- saved from url=(0013)about:internet -->'.$nl;
$header .= '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />'.$nl;
$header .= '<script language="javascript" src="../deploy/js/swfIN.js" type="text/javascript"></script>'.$nl;
$header .= '<script language="javascript" src="../deploy/js/sekati.js" type="text/javascript"></script>'.$nl;
$header .= '<script language="javascript" src="../deploy/js/swfmouse.js" type="text/javascript"></script>'.$nl;
$header .= '<link rel="stylesheet" type="text/css" href="../deploy/css/style.css" />'.$nl;
$header .= "<title>".$appName.'</title></head><body onload="sekati.external.init();">'.$nl;
$header .= '<br/>&nbsp; <a href="?" target="_self"><strong>Test Runner &raquo;</strong></a><hr/><br/>'.$nl;
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
	$str = "<ol>";
	if ($dir = @opendir($path)) {
		while (false !== ($item = readdir($dir))) {  
			if (eregi(".html", $item)) {
				$str .= "<li><a href=\"?html=$item\"><strong>$item</strong></a></li>";
			} else if (eregi(".swf", $item)) {
				$str .= "<li><a href=\"?swf=$item\">$item</a></li>";
			}
		}
		closedir($dir);
	}
	return $str."</ol>";
}

/**
 * Generate a swfIN template
 * @param string $swf - the swf to embed.
 * @return string swfin template.
 */
function template ($swf) {
	global $nl;
	$str = '<div id="flash_update"><h1>Flash Player Upgrade Required</h1><br/><a href="adobe.com/go/flashplayer" target="_blank">&raquo; Download Flash plugin to view this site</a>&nbsp; &nbsp; &nbsp; &nbsp;<a href="javascript:location.reload(true)">&raquo; Enter Site</a></div>'.$nl;
	$str .= '<script type="text/javascript">'.$nl;
	$str .= '	var s = new swfIN("'.$swf.'", "unitTest", "950", "650");'.$nl;
	$str .= '	s.detectShowDiv( [9,0,28], "flash_update" );'.$nl;
	$str .= '	s.useExpressInstall("../deploy/js/xi.swf", 300, 300);'.$nl;
	$str .= '	s.addParam("bgcolor", "#292929");'.$nl;
	$str .= '	s.addParam("menu", "true");'.$nl;
	$str .= '	s.addParam("quality", "high");'.$nl;
	$str .= '	s.addParam("scale", "noScale");'.$nl;
	$str .= '	s.addParam("allowScriptAccess", "always");'.$nl;
	$str .= '	s.addParam("swLiveConnect", "true");'.$nl;
	$str .= '	s.addParam("allowFullScreen", "true");'.$nl;
	$str .= '	s.write();'.$nl;
	$str .= '	var mousewheel = new SWFMouse( s );'.$nl;
	$str .= '</script>'.$nl;
	return $str;
}

if($swf) {
	//die($header.template($swf).$footer);
	$swfURL = split(".swf", $swf);	
	die($header.template($swfURL[0].'.swf').$footer);
}
if($html) die ($header."Loading Test: $html ...<meta HTTP-EQUIV='Refresh' CONTENT='1;URL=$html'>.$footer");
echo ($header.indexTests().$footer);
?>
