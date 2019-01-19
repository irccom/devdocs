---
title: "JOIN IRC Command"
ntitle: "JOIN"
nsub: "Joins a channel"
layout: command

command: JOIN
command-groups:
    - channels
numerics:
    - "332"
    - "333"
    - "353"
    - "403"
    - "405"
    - "461"
    - "471"
    - "473"
    - "474"
    - "475"

format: |
    JOIN <channel>{,<channel>} [<key>{,<key>}]
    JOIN 0

examples:
    - desc: "`dan` joining a new channel"
      content: |
        C  ->  JOIN #test
        S <-   :dan!~d@0::1 JOIN #test
        S <-   :irc.example.com MODE #test +nt
        S <-   :irc.example.com 353 dan = #test :@dan
        S <-   :irc.example.com 366 dan #test :End of /NAMES list.

    - desc: "`alice` joining an existing channel"
      content: |
        C  ->  JOIN #test
        S <-   :alice!~a@localhost JOIN #test
        S <-   :irc.example.com 332 alice #test :This is my cool channel! https://irc.com
        S <-   :irc.example.com 333 alice #test dan!~d@localhost 1547691506
        S <-   :irc.example.com 353 alice @ #test :alice @dan
        S <-   :irc.example.com 366 alice #test :End of /NAMES list.

    - desc: "`patty` seeing `alice` join a channel"
      content: |
        C  ->  JOIN #irctoast
        S <-   :patty!p@localhost JOIN :#irctoast
        S <-   :irc.example.com 353 patty = #irctoast :@patty
        S <-   :irc.example.com 366 patty #irctoast :End of /NAMES list.
        ... some time passes ...
        S <-   :alice!a@localhost JOIN :#irctoast

    - desc: Failing to join a channel that has a key set
      content: |
        C  ->  join #test
        S <-   :irc.example.com 475 adrian #test :Cannot join channel (+k) - bad key

    - desc: "`adrian` joining a channel that has a key set"
      content: |
        C  ->  JOIN #test mysecret
        S <-   :adrian!~a@localhost JOIN #test
        S <-   :irc.example.com 353 adrian @ #test :adrian @dan
        S <-   :irc.example.com 366 adrian #test :End of /NAMES list.
    
    - desc: Joining multiple channels, `#toast` having a key and `#ircv3` having no key
      content: |
        C  ->  join #toast,#ircv3 mysecret
        S <-   :alice!~a@localhost JOIN #toast
        S <-   :irc.example.com 353 alice = #toast :alice @dan
        S <-   :irc.example.com 366 alice #toast :End of /NAMES list.
        S <-   :alice!~a@localhost JOIN #ircv3
        S <-   :irc.example.com 353 alice = #ircv3 :alice @dan
        S <-   :irc.example.com 366 alice #ircv3 :End of /NAMES list.

    - desc: Failing to join a channel that has a limit set
      content: |
        C  ->  JOIN #test
        S <-   :irc.example.com 471 alice #test :Cannot join channel (+l)

    - desc: Failing to join a channel that has a ban set
      content: |
        C  ->  join #toast
        S <-   :irc.example.com 474 alice #test :Cannot join channel (+b)

    - desc: Failing to join a channel that has invite-only set
      content: |
        C  ->  JOIN #test
        S <-   :irc.example.com 473 alice #test :Cannot join channel (+i)

    - desc: "`JOIN 0` succeeding"
      content: |
        C  ->  join 0
        S <-   :dan!d@Clk-830D7DDC PART #supercoolfriends :Left all channels
        S <-   :dan!d@Clk-830D7DDC PART #ircv3 :Left all channels
        S <-   :dan!d@Clk-830D7DDC PART #test :Left all channels

    - desc: "`JOIN 0` failing"
      content: |
        C  ->  join 0
        S <-   :irc.example.com 476 dan 0 :Invalid channel name

    - desc: Joining too many channels
      content: |
        C  ->  JOIN #ircv3
        S <-   :irc.example.com 405 alice #ircv3 :You have joined too many channels

supported-by-default: true

contributors:
    - doaks
---
The `JOIN` command indicates that the client wants to join one or more channels. It acts as a request, the server then checks whether or not the user can join those channels, and responds appropriately.

-----

{% include command-format-header.html %}

- `<channel>`: Name of the channel(s) to join, separated by commas.
- `<key>`: Optional key (password) for each joined channel, matching the list of given channels.

Servers process the parameters of this command together. For example, the first `<channel>` uses the first `<key>`, the second uses the second key, and so on.

A `JOIN` message may also be sent from the server to indicate that someone has joined a channel. In this case, the `<prefix>` indicates the user that's joined. If a user's `JOIN` command is successful, they receive one of these messages. In addition, all other clients also receive a `JOIN` message. For example, if `dan` and `alice` are on the channel `#toast`, and `barry` joins `#toast`, then `dan` and `alice` will receive a `JOIN` message indicating that `barry` has joined the channel.

Whether or not the join request succeeds depends on the channel modes currently set. The [key](../modes/c/key), [client limit](../modes/c/limit), [ban/exemption](../modes/c/ban), [invite-only/exemption](../modes/c/invite-only), and other channel modes can prevent clients from joining a given channel.

If a user's `JOIN` command is successful, the server:

- Sends them a `JOIN` message described above.
- May send a [`MODE`](mode) message with the current channel's modes.
- Sends them `RPL_TOPIC` and `RPL_TOPICTIME` numerics if the channel has a topic set (if the topic is not set, the user is sent no numerics).
- Sends them one or more `RPL_NAMREPLY` numerics (which also contain the name of the user that's joining).

The examples illustrate some full channel join bursts.

While a user is joined to a channel, they receive all status messages related to that channel including new `JOIN`, [`PART`](part), [`KICK`](kick), and [`MODE`](mode) messages. They also receive all [`PRIVMSG`](privmsg) and [`NOTICE`](notice) messages sent to the channel, and see when any other users on the channel [`QUIT`](quit) the network. These status messages let the client keep track of who's in the channel, the topic, and the current channel modes.

If a user's join request isn't successful, they receive certain failure numerics. One of the `ERR_CHANNELISFULL` [<sup>(limit)</sup>](../modes/c/limit), `ERR_BADCHANNELKEY` [<sup>(key)</sup>](../modes/c/key), `ERR_INVITEONLYCHAN` [<sup>(invite-only)</sup>](../modes/c/invite-only), or `ERR_BANNEDFROMCHAN` [<sup>(ban)</sup>](../modes/c/ban) numerics is returned if the related channel modes prevent the user from joining.

Servers may also limit how many channels a user can be in at one time (defined by the [`CHANLIMIT`](../isupport/chanlimit) parameter). If the user can't join the channel because the server simply won't let them join any more, the server sends them a `ERR_TOOMANYCHANNELS` numeric.

The `JOIN 0` command means "leave all channels" in some server software. If the server supports `JOIN 0`, then a client sending this is treated as though they have [`PART`](part)ed all channels. Some servers disallow this form since it can be abused to trick others into leaving all their channels.
