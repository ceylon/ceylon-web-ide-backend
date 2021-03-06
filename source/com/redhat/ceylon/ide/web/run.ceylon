/********************************************************************************
 * Copyright (c) 2011-2017 Red Hat Inc. and/or its affiliates and others
 *
 * This program and the accompanying materials are made available under the 
 * terms of the Apache License, Version 2.0 which is available at
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * SPDX-License-Identifier: Apache-2.0 
 ********************************************************************************/
import ceylon.io {
    SocketAddress
}
import ceylon.buffer.charset {
    utf8
}
import ceylon.language {
    process {
        env=environmentVariableValue,
        arg=namedArgumentValue
    }
}
import ceylon.http.common {
    post,
    get,
    contentType,
    contentLength,
    Header
}
import ceylon.http.server {
    newServer,
    Endpoint,
    startsWith,
    AsynchronousEndpoint,
    isRoot
}
import ceylon.http.server.endpoints {
    serveStaticFile,
    RepositoryEndpoint
}
import ceylon.time {
    now
}
import ceylon.file {
    File
}

String ipVar = "OPENSHIFT_CEYLON_IP";
String portVar = "OPENSHIFT_CEYLON_HTTP_PORT";
String dirVar = "OPENSHIFT_REPO_DIR";

shared void run()
        => newServer {
    Endpoint {
        startsWith("/translate");
        acceptMethod = { post };
        service = translate;
    },
    Endpoint {
        startsWith("/assist");
        acceptMethod = { post };
        service = autocomplete;
    },
    Endpoint {
        startsWith("/hoverdoc");
        acceptMethod = { post };
        service = hover;
    },
    Endpoint {
        startsWith("/githubauth");
        acceptMethod = { get };
        service = authenticate;
    },
    Endpoint {
        startsWith("/time");
        acceptMethod = { get, post };
        (request, response) {
            value datetime = now().dateTime().string;
            response.addHeader(contentType("text/plain", utf8));
            response.addHeader(contentLength(datetime.size.string));
            response.writeString(datetime);
        };
    },
    Endpoint {
        startsWith("/index.html").or(isRoot());
        acceptMethod = { get };
        (request, response) {
            response.addHeader(contentType("text/html", utf8));
            assert (exists resource 
                    = `module`.resourceByPath("index.html"));
            value embedded 
                    = request.parameter("embedded") exists;
            value html 
                    = resource.textContent()
                    .replaceFirst("\`\`embedded\`\`", 
                                  embedded.string)
                    .replaceFirst("\`\`clientId\`\`", 
                                  clientId);
            response.writeString(html);
        };
    },
    RepositoryEndpoint("/modules"),
    AsynchronousEndpoint {
        startsWith("/");
        acceptMethod = { get };
        serveStaticFile {
            externalPath 
                    = (env(dirVar) else "") 
                    + "web-content";
            headers(File file) => { 
                Header("Cache-Control", 
                    "max-age=0, must-revalidate") 
            };
        };
    }
}.start {
    SocketAddress {
        address = env(ipVar) else arg("address") 
                else "0.0.0.0";
        port = if (exists arg = env(portVar) else arg("port"), 
                   exists port = parseInteger(arg)) 
                then port 
                else 8080;
    };
};
