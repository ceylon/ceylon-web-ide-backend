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
        #primary-content {
            margin: 0px;
            top: 0px;
            width: 100%;
            height: 100%;
        }
        #primary-content #core-page {
            margin: 0px;
            width: 99%;
            height: 100%;
        }
        .invis {
            display: none;
        }
        .cantseeme {
            <% if (request.getParameter("showcode") == null) { %>
            display: none;
            <% } %>
        }
        #output, #edit_ceylon {
            border: 1px solid black;
            width: 620px;
            height: 220px;
            padding-left: 4px;
            overflow: auto;
            background: white;
            white-space: pre-wrap;
            font-family: Inconsolata, Monaco, Courier, monospace;
            font-size: 85%;
        }
        .jsc_msg {
            color: gray;
            font-size: small;
        }
        .jsc_error {
            color: red;
        }
        input {
            border-style:none;
        }
    </style>
    <script type="text/javascript" src="scripts/spin.js" charset="utf-8"></script>
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
    <script type="text/javascript">
        $(function() {
            if(document.domain != "localhost") {
                document.domain = 'ceylon-lang.org';
            }
        });
    </script>
</head>
<body class="bp">


<div id="primary-content">

<div id="core-page">

    <form>
        <p style="padding:0px;margin:0px;font-size:12px;width:620px">
        <span>Autocompletion: <code>Ctrl-.</code>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Documentation: <code>Ctrl-D</code></span>
        <span style="float:right;"><a href="http://try.ceylon-lang.org" onclick="parent.location='http://try.ceylon-lang.org'">Try Ceylon Web Runner</a></span></p>
        <textarea id="edit_ceylon"></textarea>
        <div style="text-align:center; padding-top:5px; padding-bottom:5px;">
        <input type="button" class="bubble-button" id="run_ceylon" name="run_ceylon" value="Run" onClick="run()">
        <input type="button" class="bubble-button invis" id="stop_ceylon" name="stop_ceylon" value="Stop" onClick="stop()">
        <input type="button" class="bubble-button" value="Clear Output" onClick="clearOutput()">
        <input type="button" class="bubble-button invis" id="share_src" name="share_src" value="Share Code" onClick="shareSource()">
        <input type="text" id="shareurl" name="shareurl" value="" size="45" disabled="true">
        </div>
    </form>
    <hr class="cantseeme">
    <pre id="result" class="cantseeme">
    </pre>
    <div id="output">
    </div>

</div>


</div>

</body>
</html>
