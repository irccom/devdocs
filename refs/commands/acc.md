---
^title: "ACC IRC Command"
ntitle: "ACC"
nsub: "Register and validate new user accounts"
index-desc: "The *IRC `ACC` command* lets users register and validate new accounts"
layout: command
experimental: true

command: ACC
related-commands:
    - AUTHENTICATE
command-groups:
    - account

examples: |
    ACC REGISTER dan mailto:dan@example.com passphrase :testpassphrase123
    ACC VERIFY dan 3qw4tq4te4gf34

supported-by:
    oragono: true
---
The `ACC` command allows users to register and validate new user accounts. It's defined [here](https://github.com/ircv3/ircv3-specifications/pull/276).

<pre class="code">
ACC REGISTER &lt;accountname&gt; [callback_ns:]&lt;callback&gt; [cred_type] :&lt;credential&gt;
ACC VERIFY &lt;accountname&gt; :&lt;info&gt;
</pre>

The `REGISTER` subcommand registers a new account, with `<accountname>` being the name of the account (or `*` to use the current nick as the account name). The `callback` parameter describes how (and whether to) validate the registration in some out-of-band way, and the `credential` parameters describe how the user will authenticate to the account in future.

The `VERIFY` subcommand passes the out-of-band verification information back to the server to complete an account registration. The `<accountname>` parameter is the name of the account, and `<info>` is the freeform verification string originally sent out by the server.

Not all registrations must be verified after using the `REGISTER` command. As described in the specification above, omitting the callback mechanism (sending `*` in place of it) will skip validation if the server allows unverified account registration.
