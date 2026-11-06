# Edit a Netlify site from Telegram with Hermes

Use a Mac mini that stays awake and online, a GitHub repo connected to Netlify, and a dedicated Hermes profile for this site. GitHub pull requests give you a review point and a Netlify Deploy Preview before production. [Netlify Deploy Previews](https://docs.netlify.com/deploy/deploy-types/deploy-previews/)

1. Install Hermes and clone the site into a checkout reserved for the bot. Use GitHub credentials scoped to that repo with permission to push branches and open pull requests. Keep production Netlify credentials with the site owner. [Install Hermes](https://hermes-agent.nousresearch.com/docs/)
2. From the site checkout, create a fresh profile, configure its model, and set its starting directory. Skip importing another agent's setup. Run every subsequent command with `-p site-editor` so it targets this profile. [Hermes profiles](https://hermes-agent.nousresearch.com/docs/user-guide/profiles/) · [Hermes CLI](https://hermes-agent.nousresearch.com/docs/reference/cli-commands/)

   ```sh
   hermes profile create site-editor
   hermes -p site-editor setup model
   hermes -p site-editor config set terminal.cwd "$PWD"
   ```

3. Create a dedicated Telegram bot with `@BotFather` and disable group joins with `/setjoingroups`. Run `hermes -p site-editor gateway setup`, select Telegram, and give the wizard the bot token and only your numeric Telegram user ID. [BotFather settings](https://core.telegram.org/bots/features#edit-settings) · [Hermes Telegram setup](https://hermes-agent.nousresearch.com/docs/user-guide/messaging/telegram)
4. Install the gateway as a macOS LaunchAgent. It runs in the background and restarts when its macOS user logs in. If the Mac already uses a shared Hermes gateway for all profiles, check how it serves the new profile before installing another service. [Managing profile gateways](https://hermes-agent.nousresearch.com/docs/user-guide/multi-profile-gateways)

   ```sh
   hermes -p site-editor gateway install
   hermes -p site-editor gateway start
   hermes -p site-editor gateway status
   ```

5. Send a small first task in a Telegram DM. For example, “Fix the typo in the footer on a new branch. Open a pull request and send me the PR and Netlify preview links. Leave merging to me.” Check that the PR targets the correct repo, the preview shows the change, and production changes only after you merge. Require pull requests on the production branch where your GitHub plan supports it.

A profile separates Hermes configuration, chats, memory, and bot credentials. `terminal.cwd` sets the starting folder. With the local backend, the agent can still access files and CLI credentials available to the macOS user. Use a dedicated standard macOS user with only the bot's checkout and credentials when you need a filesystem and credential boundary. [Profiles and sandboxing](https://hermes-agent.nousresearch.com/docs/user-guide/profiles/#profiles-vs-workspaces-vs-sandboxing)
