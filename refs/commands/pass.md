---
title: "PASS IRC Command"
ntitle: "PASS"
nsub: "Send a connection password"
layout: command

command: PASS
command-groups:
    - welcome
numerics:
    - "461"
    - "462"

format: |
    PASS <password>

examples:
    - desc: No password supplied
      content: |
        C  ->  nick chris
        C  ->  user c 0 * :Chrisa!
        S <-   :irc.example.com 464 chris :Password Incorrect
        S <-   ERROR :Closing Link: localhost (Bad Password)
        <connection gets terminated by the server>
    
    - desc: Incorrect password supplied
      content: |
        C  ->  PASS opensesame
        C  ->  NICK chris
        C  ->  user c 0 * :Chrisa!
        S <-   :irc.example.com 464 chris :Password Incorrect
        S <-   ERROR :Closing Link: localhost (Bad Password)
        <connection gets terminated by the server>
    
    - desc: Correct password supplied
      content: |
        C  ->  PASS letmein
        C  ->  NICK chris
        C  ->  USER c 0 * :Chrisa!
        S <-   :irc.example.com 001 chris :Welcome to the ExampleNet Internet Relay Chat Network chris

supported-by-default: true

contributors:
    - doaks
---
The `PASS` command lets a user provide a connection password to the server. If a connection password is required by the server and not provided (or is incorrect), the user will not be able to successfully connect. This command cannot be used after connection registration has completed.

-----

{% include command-format-header.html %}

- `<password>`: The password which the server evaluates.

This `<password>` is a **connection password**, and does not relate to user accounts or other user-specific authentication mechanisms (see the [`AUTHENTICATE` command](authenticate) for user authentication).

If required by the server, this must be sent before any attempt to register the connection is made. In other words, the client sends this before sending the `NICK`/`USER` combination. It is possible to send multiple PASS commands before registering, but only the last one sent is used for verification.

For standard IRC servers, the password must match the one in the server's configuration. Other services (such as bouncers) may require other formats for the password which gets evaluated at runtime.

If a client tries to sent the `PASS` command after connection registration has been completed, the `ERR_ALREADYREGISTRED` reply is sent and the command is ignored.
