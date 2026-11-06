# Email signup options

Collect only the fields needed. Start with email and copy that says what the person is signing up for. Restrict access to the response Sheet and keep signup data out of the public site and repo.

## Google Forms → Google Sheets

Use a Google account to create a form with a required email field. For a public signup without a Google login, use responder-entered email and turn off settings that require sign-in, such as limiting to one response. Publish with responder access for anyone with the link, if the account permits it. Link to the responder URL or use **More → Embed HTML** to place the form on the site. Give the iframe a descriptive title and provide a direct link as a fallback. [Publish and embed a Google Form](https://support.google.com/docs/answer/2839588)

Under **Responses**, choose a response destination and link a private Google Sheet. Submit from a signed-out browser and confirm that one row appears and that visitors can access only the form. [Link a response Sheet](https://support.google.com/docs/answer/2917686)

## Netlify Forms → dashboard or CSV

Enable form detection in the site's **Forms** panel and deploy or redeploy the HTML containing the form. Netlify detects the markup at deploy time. Keep the initial form and its named fields in the static HTML.

```html
<form name="waitlist" method="post" data-netlify="true" netlify-honeypot="website">
  <p hidden><label>Leave this field empty <input name="website" tabindex="-1" autocomplete="off"></label></p>
  <label>Email address <input name="email" type="email" autocomplete="email" required></label>
  <button type="submit">Join the waitlist</button>
</form>
```

Use the built-in confirmation or link the form's `action` to a published thank-you page. Test on the deployed site and check that the entry appears under verified submissions. Submissions are free and unlimited on credit-based plans. Check legacy plan limits separately. Start with the dashboard or export verified submissions as CSV and import the file into Sheets. [Form setup](https://docs.netlify.com/manage/forms/setup/) · [Spam filters](https://docs.netlify.com/manage/forms/spam-filters/) · [Submissions and CSV export](https://docs.netlify.com/manage/forms/submissions/) · [Forms billing](https://docs.netlify.com/manage/forms/usage-and-billing/)

## Netlify Forms → Google Sheets automatically

When the site needs its own HTML form and rows must appear automatically, use a Netlify HTTP POST notification for that form and a Google Apps Script web app. This requires a Google account that permits anonymous web app deployment, a private Sheet, and enough Apps Script quota. [Netlify notifications](https://docs.netlify.com/manage/forms/notifications/) · [Apps Script web apps](https://developers.google.com/apps-script/guides/web) · [Apps Script quotas](https://developers.google.com/apps-script/guides/services/quotas)

1. Deploy a `doPost(e)` handler to execute as the Sheet owner. Require a random shared token in a query parameter before writing. Store the expected value in Script Properties and put the tokenized `/exec` URL only in Netlify's webhook settings. Use a separate Sheet for signup data and treat the full URL as a secret.
2. Parse `e.postData.contents` as JSON, confirm the form, and map the verified submission ID, time, and email to columns. Check the actual notification payload with a test signup and validate the expected fields. Store the ID so repeat deliveries can be skipped, and use a script lock around the ID check and append. Write user input as literal text, for example with the Sheets API's `RAW` input mode. [Apps Script Lock Service](https://developers.google.com/apps-script/reference/lock/lock-service) · [Writing Sheets values](https://developers.google.com/workspace/sheets/api/guides/values)
3. Submit a test signup on the live site. Check both Netlify and the Sheet, confirm requests with an invalid token create no row, and confirm a repeated delivery leaves one row. Keep Netlify's verified submissions available for export if delivery fails. If anonymous web apps are unavailable, use the Google Form or CSV route, or connect a [Netlify form event function](https://docs.netlify.com/build/functions/trigger-on-events/) to the Sheets API using server-side credentials and check the applicable compute and API quotas.
