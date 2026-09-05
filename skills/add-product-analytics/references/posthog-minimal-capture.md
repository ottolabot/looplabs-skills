# Minimal PostHog capture

Use this mode when a browser needs a small set of explicit page-view and interaction events, and the measurement contract requires a stricter property boundary or smaller client than the full JavaScript SDK provides.

Use the official browser or mobile SDK instead when the product needs PostHog sessions, identity merging, replay, feature flags, surveys, experiments, automatic campaign attribution, mobile lifecycle handling, or offline queues. A direct capture adapter is deliberately not a partial reimplementation of those features.

## Browser request contract

Send JSON to the deployment region's client ingestion host at `/i/v0/e/`:

```js
const ROUTE_PATHS = new Map([
  ["home", "/"],
  ["sign_in", "/sign-in"]
])
const CTA_PLACEMENTS = new Set(["header", "hero"])

const sendCapture = ({ host, projectToken, distinctId, event, properties, path }) => {
  fetch(new URL("/i/v0/e/", host), {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    credentials: "omit",
    referrerPolicy: "no-referrer",
    keepalive: true,
    body: JSON.stringify({
      api_key: projectToken,
      distinct_id: distinctId,
      event,
      properties: {
        ...properties,
        $geoip_disable: true,
        $pathname: path,
        $process_person_profile: false
      }
    })
  }).catch(() => {})
}

export const capturePageview = ({ host, projectToken, distinctId, route }) => {
  const path = ROUTE_PATHS.get(route)
  if (!path) return

  sendCapture({ host, projectToken, distinctId, event: "$pageview", properties: { route }, path })
}

export const captureJoinClick = ({ host, projectToken, distinctId, route, placement }) => {
  const path = ROUTE_PATHS.get(route)
  if (!path || !CTA_PLACEMENTS.has(placement)) return

  sendCapture({ host, projectToken, distinctId, event: "join_cta_clicked", properties: { placement }, path })
}
```

Replace the example route and placement allowlists with the application's measurement contract. Keep event names, property shapes, value validation, and normalized paths inside the adapter so callers cannot expand the outbound schema accidentally.

Keep the surrounding adapter equally narrow:

- Generate a stable anonymous UUID and persist it only as long as the measurement plan needs. Fall back to memory when storage is unavailable.
- Respect the application's consent and opt-out state; honor Do Not Track when that is part of the product policy.
- Supply `path` from an allowlisted normalized route map. Never derive it from the full URL when query strings or record identifiers must stay out.
- Render the project token and host only on pages approved for analytics. Leave private, administration, token, and sensitive workflow pages uninstrumented.
- Add only the selected region's ingestion origin to the content security policy.
- Treat delivery as best effort. Analytics failures must not break navigation or the product action being measured.

`credentials: "omit"` prevents cookies and HTTP authentication from accompanying the cross-origin request. It does **not** suppress the browser's HTTP `Referer` header; `referrerPolicy: "no-referrer"` is a separate requirement when referrers are outside the contract.

`$process_person_profile: false` makes the event personless. `$geoip_disable: true` prevents PostHog's GeoIP enrichment. The write-only project token is designed to be exposed in client applications; personal API keys and server credentials are not.

## Backend outcomes

Use the official server SDK for registrations, purchases, enrollments, publications, and other authoritative state transitions. Create one reusable client, capture only after the database transaction commits, fail open, and flush or shut down the client during process termination according to the SDK's lifecycle guidance.

Choose identity deliberately:

- Use the same stable opaque ID as the client only when user-level funnel or retention analysis is required.
- Use a fresh personless ID with `$process_person_profile: false` when aggregate conversion counts are sufficient.
- Do not use email addresses or other mutable personal fields as distinct IDs.

Direct browser capture does not add `$session_id`. Do not invent a UUID merely to make session reports appear: use the browser SDK's session ID when the outcome belongs to that session, or generate a standards-compliant UUIDv7 only when PostHog's documented custom-session requirements are met.

## Verification

Leave a small contract test that asserts the exact endpoint, request options, event names, and complete property-key allowlist. Include an assertion for `referrerPolicy: "no-referrer"` when referrers are excluded.

Then verify the rendered application end to end:

1. Load a route with a harmless query marker and confirm the emitted path is normalized.
2. Navigate once and click one allowlisted CTA; confirm one page view per route and one click event.
3. Inspect the provider's live event details, not only the event count. Confirm there is no full URL, query, referrer, person profile, or unintended enrichment.
4. Verify excluded routes render no analytics configuration.
5. Test backend conversion hooks with focused application tests. Do not inject a fake production conversion unless it carries an explicit synthetic-test marker that normal reports exclude.
6. After deployment, repeat the page-view and CTA check on the production hostname and confirm the health endpoint and release pipeline remain green.

## Primary references

- [PostHog event capture API](https://github.com/PostHog/posthog.com/blob/master/contents/docs/integrate/send-events/_snippets/send-events-api.mdx)
- [Anonymous backend and API capture](https://github.com/PostHog/posthog.com/blob/master/contents/docs/product-analytics/_snippets/how-to-capture-anonymous-backend-and-api.mdx)
- [PostHog sessions and custom session IDs](https://github.com/PostHog/posthog.com/blob/master/contents/docs/data/sessions.mdx)
- [PostHog Ruby SDK](https://posthog.com/docs/libraries/ruby)
- [PostHog JavaScript SDK](https://posthog.com/docs/libraries/js)
