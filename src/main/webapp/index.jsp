<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Ceylon Web Runner</title>
    
    <link rel='stylesheet' media='screen, projection' type='text/css' href='main.css'/>
    <link rel='stylesheet' type='text/css'
         href='http://fonts.googleapis.com/css?family=Source+Sans+Pro|PT+Sans|PT+Sans:700|Inconsolata|Inconsolata:700'/>
    <!--[if lt IE 8]>
        <link href='http://ceylon-lang.org/stylesheets/ie.css' media='screen, projection' rel='stylesheet' type='text/css' />
    <![endif]-->
    <style type="text/css">
        .cantseeme {
            <% if (request.getParameter("showcode") == null) { %>
            display: none;
            <% } %>
        }
        .invis {
            display: none;
        }
        #output, #edit_ceylon {
            border: 1px solid black;
            width:  620px;
            height: 220px;
            padding-left: 4px;
            overflow: auto;
            background: white;
            white-space: pre-wrap;
            font-family: Inconsolata, Monaco, Courier, monospace;
            font-size: 85%;
            min-width: 290px;
            max-width: 900px;
            min-height: 58px;
            max-height:800px;
        }
        .jsc_msg {
            color: gray;
            font-size: small;
        }
        .jsc_error {
            color: red;
        }
        input.bubble-button {
            border-style:none;
        }
		.spinner {
		  display: inline-block;
		  opacity: 0;
		  width: 0;
		
		  -webkit-transition: opacity 0.25s, width 0.25s;
		  -moz-transition: opacity 0.25s, width 0.25s;
		  -o-transition: opacity 0.25s, width 0.25s;
		  transition: opacity 0.25s, width 0.25s;
		}
		.has-spinner.active {
		  cursor:progress;
		}
		.has-spinner.active .spinner {
		  opacity: 1;
		  width: auto; /* This doesn't work, just fix for unkown width elements */
		}
    </style>
    <script type="text/javascript" src="scripts/codemirror.js" charset="utf-8"></script>
    <script type="text/javascript" src="scripts/autocomplete.js" charset="utf-8"></script>
    <script type="text/javascript" src="scripts/mode/ceylon/ceylon.js" charset="utf-8"></script>
    <script type="text/javascript" src="scripts/active-line.js" charset="utf-8"></script>
    <script type="text/javascript" src="scripts/closebrackets.js" charset="utf-8"></script>
    <!--script type="text/javascript" src="scripts/match-highlighter.js" charset="utf-8"></script-->
    <script type="text/javascript" src="scripts/matchbrackets.js" charset="utf-8"></script>
    <link rel="stylesheet" href="scripts/codemirror.css" />
    <script type="text/javascript" src="scripts/require-jquery.js" data-main="scripts/repl.js"></script>
    <link rel='stylesheet' type='text/css' href='autocomplete.css'/>
    <link rel='stylesheet' type='text/css' href='scripts/jquery-ui-1.9.2.custom.css'/>
    <link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css">

</head>
<body class="bp">


<div class="header-bar"><div id="header">
  <a id="header-logo" href="."><h1 id="ceylon">Ceylon</h1></a>
  <div id="header-tagline">
    <p id="say_more_more_clearly">Say more, more clearly</p>
  </div>
</div></div>

<div id="primary-content">

<div id="core-page" style="min-width:290px;max-width:900px;min-height:570px">

    <h1 id="hdr_title">Ceylon Web Runner</h1>
    <form>
        <span>Autocompletion: <code>Ctrl-.</code>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Documentation: <code>Ctrl-D</code></span>
        <textarea id="edit_ceylon"></textarea>
        <div style="text-align:center; padding-top:5px; padding-bottom:5px;">
        <button class="bubble-button has-spinner" id="run_ceylon" name="run_ceylon" onClick="run()"><span class="spinner"><i class="icon-spin icon-refresh"> </i></span>Run</button>
        <button class="bubble-button invis" id="stop_ceylon" name="stop_ceylon" onClick="stop()">Stop</button>
        <button class="bubble-button" onClick="clearOutput()">Clear Output</button>
        <button class="bubble-button" id="share_src" name="share_src" onClick="shareSource()">Share Code</button>
        <input type="text" id="shareurl" name="shareurl" value="" size="45" disabled="true">
        </div>
    </form>
    <pre id="result" class="cantseeme">
    </pre>    
    <div id="output">
    </div>
    
    <div>The <a href="http://github.com/ceylon/ceylon-web-ide-backend">Ceylon Web Runner</a>
    is powered by <a href="http://github.com/ceylon/ceylon-js">Ceylon JS</a> and 
    <a href="http://openshift.redhat.com">OpenShift</a>.</div>

</div>

<div id="sidebar">
<div class="point-light-top"/>
<div class="sidebar-block">
    <h3 id="news">Try out a sample:</h3>
    <ol>
    <li class="news_entry"><a href="#" onClick="return editCode('hello_world')">Hello World</a></li>
    <li class="news_entry"><a href="#" onClick="return editCode('basics')">Basics</a></li>
    <li class="news_entry"><a href="#" onClick="return editCode('null_and_union')">Null values and union types</a></li>
    <li class="news_entry"><a href="#" onClick="return editCode('conditions')">Conditions and assertions</a></li>
    <li class="news_entry"><a href="#" onClick="return editCode('classes_and_functions')">Classes and functions 1</a></li>
    <li class="news_entry"><a href="#" onClick="return editCode('interfaces')">Interfaces and mixin inheritance</a></li>
    <li class="news_entry"><a href="#" onClick="return editCode('classes_and_functions2')">Classes and functions 2</a></li>
    <li class="news_entry"><a href="#" onClick="return editCode('collections')">Collections and sequence comprehensions</a></li>
    <li class="news_entry"><a href="#" onClick="return editCode('named_arguments')">Named argument syntax</a></li>
    <li class="news_entry"><a href="#" onClick="return editCode('generics')">Type parameters</a></li>
    <li class="news_entry"><a href="#" onClick="return editCode('switch1')">Enumerations and the switch statement</a></li>
    <li class="news_entry"><a href="#" onClick="return editCode('interop')">Interoperability</a></li>
    <li class="news_entry"><a href="#" onClick="return editCode('request')">Interoperability 2</a></li>
    <li class="news_entry"><a href="#" onClick="return editCode('dynints')">Dynamic interfaces</a></li>
    <li class="news_entry"><a href="#" onClick="return editCode('operators')">Operator polymorphism</a></li>
    <li class="news_entry"><a href="#" onClick="return editCode('metamodel')">Type-safe Metamodel</a></li>
    <li class="news_entry"><a href="#" onClick="return editCode('game_of_life')">Game of Life</a></li>
    </ol>
</div>
<div class="point-light-end"/>
    <div style="text-align:center;padding-top:50px;">
    <a href="https://twitter.com/ceylonlang" class="twitter-follow-button" data-show-count="false" data-size="large">Follow @ceylonlang</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
    </div>
    <div>
    <Google+ Badge -+->
    <link href="https://plus.google.com/102481741611133754149" rel="publisher" />
    <script type="text/javascript">
        window.___gcfg = {lang: 'en'};
        (function() 
        {var po = document.createElement("script");
        po.type = "text/javascript"; po.async = true;po.src = "https://apis.google.com/js/plusone.js";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(po, s);
        })();
    </script>
    <g:plus href="https://plus.google.com/102481741611133754149" width="300" height="131" theme="light"></g:plus>
    </div>

</div>

</div>

</div>

<div class='footer-bar'>
    <div id='footer'>
        <div id='footer-core'>
            <div id='copyright'>
                <p id='copyright_copy_2010_2011_red...'>Copyright &copy; 2010-2011, Red Hat, Inc. or third-party contributors -
                Ceylon is a trademark of Red Hat, Inc. - <a href='http://www.redhat.com/legal/legal_statement.html'>terms of Use</a> - 
                <a href='http://www.redhat.com/legal/privacy_statement.html'>Privacy policy</a></p>
            </div>
        </div>
    </div>
</div>

</body>
</html>
