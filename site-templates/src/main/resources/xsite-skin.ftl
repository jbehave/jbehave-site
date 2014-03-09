<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>${title}</title>

<style type="text/css" media="all">
@import url( "./style/jbehave.css" );
</style>

<script type="text/javascript" src="./js/mootools-1.2/mootools-core.js"></script>
<script type="text/javascript" src="./js/mootools-1.2/mootools-fx.js"></script>
<script type="text/javascript" src="./js/mootools-1.2/menu-fx.js"></script>
<style media="screen" type="text/css">
div.MGroupContent {
	display: none
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
</head>

<body class="composite">
<div id="banner"><img src="images/jbehave-logo.png" alt="jbehave" />
<div class="clear"></div>
</div>

<div id="Menu"><#list sitemap.sections as section>
<div class="MGroup MEntry"><a>${section.name}</a>
<div id="MGroupContent${section_index}" class="MGroupContent"
	style="display: block;"><#list section.entries as entry> <#if
entry=page>
<div class="MFile MEntry" id="MSelected">${entry.title}</div>
<#else>
<div class="MFile MEntry"><a href="${entry.href}">${entry.title}</a>
</div>
</#if> </#list></div>
</div>
</#list>
</div>

<div id="bodyColumn">
<div id="contentBox">
<div class="section">${body} <br />
<br />
</div>
</div>
</div>
<div class="clear"></div>
<div id="footer">
<div class="left">Version ${publishedVersion} published on ${publishedDate?string("dd/MM/yyyy")}</div>
<div class="right">&#169; 2003-2014</div>
<div class="clear"></div>
</div>

</body>
<!--  SyntaxHighlighter resources:  should be included at end of body -->
<link rel="stylesheet" type="text/css" href="./style/sh-3.0.83/shCore.css"/>
<link rel="stylesheet" type="text/css" href="./style/sh-3.0.83/shThemeRDark.css"/>
<script language="javascript" src="./js/sh-3.0.83/shCore.js"></script>
<script language="javascript" src="./js/sh-3.0.83/shBrushBash.js"></script>
<script language="javascript" src="./js/sh-3.0.83/shBrushCss.js"></script>
<script language="javascript" src="./js/sh-3.0.83/shBrushDiff.js"></script>
<script language="javascript" src="./js/sh-3.0.83/shBrushGroovy.js"></script>
<script language="javascript" src="./js/sh-3.0.83/shBrushJava.js"></script>
<script language="javascript" src="./js/sh-3.0.83/shBrushJScript.js"></script>
<script language="javascript" src="./js/sh-3.0.83/shBrushPlain.js"></script>
<script language="javascript" src="./js/sh-3.0.83/shBrushPython.js"></script>
<script language="javascript" src="./js/sh-3.0.83/shBrushRuby.js"></script>
<script language="javascript" src="./js/sh-3.0.83/shBrushScala.js"></script>
<script language="javascript" src="./js/sh-3.0.83/shBrushXml.js"></script>
<script language="javascript" src="./js/shBrushBdd.js"></script>
<script type="text/javascript">
    SyntaxHighlighter.defaults['gutter'] = false;
    SyntaxHighlighter.defaults['toolbar'] = false;    
    SyntaxHighlighter.all();
</script>
</html>
