/********************************************************************************
 * Copyright (c) 2011-2017 Red Hat Inc. and/or its affiliates and others
 *
 * This program and the accompanying materials are made available under the 
 * terms of the Apache License, Version 2.0 which is available at
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * SPDX-License-Identifier: Apache-2.0 
 ********************************************************************************/
import ceylon.buffer.charset {
    utf8
}
import ceylon.json {
    parse,
    JsonObject=Object
}
import ceylon.language {
    process {
        env=environmentVariableValue
    }
}
import ceylon.http.common {
    contentType,
    Header
}
import ceylon.http.client {
    ClientRequest=Request
}
import ceylon.http.server {
    Request,
    Response
}
import ceylon.uri {
    parseUri=parse,
    Parameter,
    Uri
}

String clientId = 
        env("GITHUB_CLIENTID") 
        else "ef3727725eeee1d1bae2"; //for localhost:8080
String clientSecret =
        env("GITHUB_CLIENTSECRET") 
        else "2bbf6b4cc39dc9015c8de4c83e92cc6bab620151"; //for localhost:8080

Uri gitHubAuth 
        = parseUri("https://github.com/login/oauth/access_token");

Header cookie(String token, Integer maxAge) 
        => Header("Set-Cookie", 
            "githubauth=``token``; Path=/; Max-Age=``maxAge``;");

void authenticate(Request request, Response response) {
    if (exists code = request.parameter("code")) {
        value clientRequest 
                = ClientRequest {
            uri = gitHubAuth;
            Parameter("client_id", clientId),
            Parameter("client_secret", clientSecret),
            Parameter("code", code),
            Parameter("state", "xyz")
        };
        clientRequest.setHeader("Accept", "application/json");
        clientRequest.setHeader("Cache-Control", "no-cache");
        
        value json = clientRequest.execute().contents;
        assert (is JsonObject result = parse(json),
                is String token = result["access_token"]);
        response.addHeader(cookie(token, 30 * 24 * 60 * 60));
        response.addHeader(contentType("text/html", utf8));
        response.writeString(
            """<html>
                 <body>
                   <script>
                     if (document.domain.endsWith(".ceylon-lang.org")) {
                       document.domain = "ceylon-lang.org";
                     }
                     window.opener.location.reload();
                     window.close();
                   </script>
                 </body>
               </html>""");
    }
}
