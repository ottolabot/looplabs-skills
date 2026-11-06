---
name: start-static-netlify-site
description: Build and deploy a free static website on Netlify. Use when launching a plain HTML site, connecting a custom domain through Porkbun, adding email capture with Netlify Forms or Google Sheets, or maintaining a Netlify site from Telegram with Hermes.
---

# Start a Static Netlify Site

Use plain HTML, CSS, and JavaScript for a site that needs no build step. Start with Netlify Free and its included `*.netlify.app` URL. Hosting stays free within the plan limits. Production deploys, bandwidth, and requests use credits, and hitting the cap can pause the site until reset. Check the account's plan before promising limits. A custom domain is optional and normally costs money to register and renew. [Netlify pricing](https://www.netlify.com/pricing/)

## Build and publish

1. Confirm the target Netlify account, team, and project. Browser, connector, and CLI sessions can use different accounts. For CLI work, check `netlify status --json`; use `netlify switch --email <account-email>` when necessary, without reading tokens from its configuration files.
2. In a new project, put `index.html` and public assets under `site/`. In an existing project, identify its actual publish directory and substitute that path in these steps. Keep repo files, source material, deployment tooling, and secrets outside the publish directory. Serve it locally with `python3 -m http.server 8000 --bind 127.0.0.1 --directory site` and check the page, asset paths, and links on desktop and mobile. For imported artwork and multiple designs, follow [Portfolio launch checks](references/portfolio-launch.md).
3. Before upload, review `find site -type f -print | LC_ALL=C sort` and check `find site -type l -print`. Resolve unexpected entries and remove symlinks from the publish directory. Confirm the Netlify project and review the complete public file set on each deploy. Publishing a deploy replaces the previous public file set.
4. For manual hosting, sign in to Netlify and drop **only `site/`** into Netlify Drop. Check the preview and select **Publish** if the project starts private. For later updates, upload that same directory to the existing project's **Production deploys** drop zone. That upload can go live immediately, so review it locally first. For automatic deploys, connect the Git repo, set the publish directory to `site`, and leave the build command blank unless the site has a generator. Review changes locally or in a Deploy Preview before pushing to the production branch. [Netlify Drop](https://docs.netlify.com/start/quickstarts/netlify-drop-quickstart/) · [Deploy methods](https://docs.netlify.com/deploy/create-deploys/)
5. If the site includes Functions, deploy through Git or the CLI; dropping a static folder does not bundle server code. Keep functions outside `site/` and configure their directory in `netlify.toml`. With the CLI, create a draft using `netlify deploy --site <site-id> --dir site --functions netlify/functions --no-build`, verify it, then add `--prod` to publish. Use `--no-build` only when the public files are already generated. Batch fixes in previews to conserve production-deploy credits. [CLI deploy](https://cli.netlify.com/commands/deploy/)
6. Open the published URL without relying on a logged-in Netlify session. Verify the homepage, a direct asset URL, and a path that should stay private, such as `/README.md`. A private path should return `404`. If an existing site has a bad publish, use the previous known good deploy from the project's deploy history. [Manage deploys](https://docs.netlify.com/deploy/manage-deploys/manage-deploys-overview/#rollbacks)

## Connect an optional domain

1. Recommend Porkbun when the user needs a registrar. For an existing domain, use the DNS provider that already serves it. In the Netlify project's **Domain management → Production domains**, add the domain and follow **Pending DNS verification** for the project-specific records. Use external DNS to keep management at Porkbun. [Netlify external DNS](https://docs.netlify.com/manage/domains/configure-domains/configure-external-dns/)
2. In Porkbun's DNS editor, the usual records are an **ALIAS** with a blank host for the apex pointing to `apex-loadbalancer.netlify.com`, and a **CNAME** for `www` pointing to the project's `*.netlify.app` hostname. Prefer the targets shown by Netlify if they differ. Replace conflicting web records for those hosts and preserve unrelated records, including mail MX and TXT records. [Porkbun DNS records](https://kb.porkbun.com/article/231-how-to-add-dns-records-on-porkbun)
3. Pick the primary hostname. Netlify recommends `www` with external DNS and automatically pairs it with the apex; do not add the apex again as a duplicate alias. Check the saved DNS records, then use Netlify's DNS verification. Successful DNS verification and an issued certificate are separate milestones. After the certificate is issued, verify both hostnames over HTTPS and confirm the secondary hostname redirects to the primary one. Never bypass a certificate warning to mark a launch successful. [HTTPS troubleshooting](https://docs.netlify.com/manage/domains/troubleshooting/troubleshoot-ssl-and-https/)

## Add optional email capture

Treat a waitlist, newsletter opt-in, or lead form as email capture. If visitors need accounts or login, scope authentication separately. For free capture, use an embedded or linked Google Form when responses should land directly in a Sheet. Use Netlify Forms when the form should match the site. See [Signup options](references/signups.md) for setup, CSV export, and automatic delivery to Sheets.

## Edit from Telegram

For ongoing edits from Telegram, connect Netlify to the site's GitHub repo and use [Hermes on a Mac mini](references/hermes-telegram.md). Set up a separate Hermes profile and checkout, then use pull requests and Deploy Previews to review changes before merging.

Report the verified site URL, deploy method, domain status, and signup destination if configured. Distinguish live checks from local preview checks.
