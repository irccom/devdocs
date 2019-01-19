---
title: "TOPIC IRC Command"
ntitle: "TOPIC"
nsub: "Sets or views a channel's topic"
layout: command

command: TOPIC
command-groups:
    - channels
numerics:
    - "331"
    - "332"
    - "333"
    - "403"
    - "442"
    - "461"
    - "482"

format: |
    TOPIC <channel> [<topic>]

examples:
    - desc: Setting a topic
      content: |
        C  ->  TOPIC #v3 :This is a cool channel!!
        S <-   :dan!d@Clk-830D7DDC TOPIC #v3 :This is a cool channel!!

    - desc: Unsetting a topic
      content: |
        C  ->  TOPIC #v3 :
        S <-   :dan!d@Clk-830D7DDC TOPIC #v3 :

    - desc: Viewing a set topic
      content: |
        C  ->  topic #v4
        S <-   :irc.example.com 332 dan #v4 :Coolest topic
        S <-   :irc.example.com 333 dan #v4 dan 1547858123

    - desc: Viewing no topic
      content: |
        C  ->  topic #v4
        S <-   :irc.example.com 331 dan #v4 :No topic is set.

    - desc: Setting a topic with no privileges (while [protected topic](../modes/c/protected-topic) is set)
      content: |
        C  ->  TOPIC #v5 :New topic!
        S <-   :irc.example.com 482 dan #v5 :You're not channel operator

    - desc: Setting a topic while not on the channel
      content: |
        C  ->  TOPIC #v6 :New topic!
        S <-   :irc.example.com 442 dan #v6 :You're not on that channel

supported-by-default: true

contributors:
    - doaks
---
The `TOPIC` command lets a chanop set a channel's topic, and lets anyone view the topic.

-----

{% include command-format-header.html %}

- `<channel>`: Channel to modify/view.
- `<topic>`: If given, the new topic to set on the channel.

A `TOPIC` message sent from the server indicates that the topic has been changed. In this case, the `<prefix>` is the user that's changed the topic. If a chanop's `TOPIC` command is successful, they receive one of these messages. In addition, all other clients in the channel also receive a `TOPIC` message. For example, if `dan` and `alice` are on `#v4`, and `dan` sets a new topic (or unsets the topic), both of them will receive a `TOPIC` message indicating that the topic's been changed. The examples illustrate this in action.

If `<topic>` is given, the command is a request to change the topic. If `<topic>` is given and is an empty string, the server unsets the current topic. If `<topic>` is not given, the server returns a topic burst with the current topic information.

A topic burst consists of:

- If the topic **is** set, an `RPL_TOPIC` numeric and possibly an `RPL_TOPICWHOTIME` numeric.
- If the topic **is not** set, an `RPL_NOTOPIC` numeric.

When the [protected topic](../modes/c/protected-topic) mode is set, changing the topic (setting or unsetting it) is restricted to channel operators, and sometimes alternate permission levels added to the server such as halfop.

If the channel does not exist, the server returns `ERR_NOSUCHCHANNEL`. If the user is not joined to the channel, the server returns `ERR_NOTONCHANNEL`. If the user changing the topic does not have appropriate permissions, the server returns `ERR_CHANOPRIVSNEEDED`.
