---
title: "NICK IRC Command"
ntitle: "NICK"
nsub: "Set and change nickname"
layout: command

command: NICK
command-groups:
    - welcome
numerics:
    - "431"
    - "432"
    - "433"
    - "436"

format: |
    NICK <nickname>

examples:
    - desc: Successful connection registration
      content: |
        C  ->  NICK dan
        C  ->  USER d 0 * :Dan!
        S <-   :irc.example.com 001 dan :Welcome to the ExampleNet Internet Relay Chat Network dan
    
    - desc: Connection registration with nick-in-use
      content: |
        C  ->  NICK ben
        C  ->  USER b 0 * :Benno!
        S <-   :irc.example.com 433 * ben :Nickname is already in use.
        C  ->  NICK ben-
        S <-   :irc.example.com 001 ben- :Welcome to the ExampleNet Internet Relay Chat Network ben-
    
    - desc: Invalid nickname
      content: |
        C  ->  nick 345gman!
        S <-   :irc.example.com 432 george 345gman! :Erroneous Nickname
    
    - desc: Series of nickname changes seen by another user on the network
      content: |
        S <-   :ben-!~b@localhost NICK :dan
        S <-   :dan!~b@localhost NICK :danny
        S <-   :danny!~b@localhost NICK :george
    
    - desc: Silently truncated nickname during registration
      content: |
        C  ->  nick dan-is-my-name-dont-wear-it-out-at-all
        C  ->  user d 0 * :Danny
        S <-   :irc.example.com 001 dan-is-my-name-dont-wear-it-ou :Welcome to the ExampleNet Internet Relay Chat Network
    
    - desc: Silently truncated nickname after registration
      content: |
        C  ->  NICK my-name-is-george-it-is-a-really-cool-name
        S <-   :george!~b@localhost NICK :my-name-is-george-it-is-a-real

supported-by-default: true

contributors:
    - doaks
---
The `NICK` command lets a user set and change their nickname. When the command is sent from a user to a server, it's a nickname change request (which the server can accept or deny). When the `NICK` message is sent from the server, it indicates a change that has taken place.

-----

{% include command-format-header.html %}

- `<nickname>`: The nickname to change to.

If `<nickname>` is longer than the server allows nicknames to be, it is silently truncated (the user should find and set the new nickname from the reply)

This command can be used at two times – during initial connection registration to set the client's initial nickname, and after registration to change their nick. When used during registration, the server will silently accept the user's request (or reply with an appropriate error numeric). If used after registration, the server will return a `NICK` message or appropriate error numerics.

If the desired nickname is already in use, the server returns an `ERR_NICKNAMEINUSE` numeric and rejects the change. If the desired nickname is invalid (e.g. contains invalid characters), the server returns an `ERR_ERRONEUSNICKNAME` numeric and rejects the change. If the client does not send the `<nickname>` parameter, the server returns the `ERR_NONICKNAMEGIVEN` numeric.

The `NICK` message is also sent by servers to note the change of another user's nickname – in which case the format remains the same but the message's `<prefix>` contains the original details of the user. The examples illustrate this in more detail. Similarly, when a nickname change is performed, servers notify all clients that are in the same channels with an appropriate `NICK` message as described.
