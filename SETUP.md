# HSRO FY27 Goals Dashboard — Setup Guide

This guide walks you through the complete setup: Supabase (free database), GitHub Pages (free hosting), and password configuration.

---

## What you'll have when finished

- **Public dashboard** at `https://your-username.github.io/hsro-dashboard/`
- **Password-protected update portal** at `.../admin.html`
- **Live data** — when anyone on the team submits an update, the dashboard reflects it within 60 seconds
- **Shared team password** you can change anytime

Estimated setup time: **15–20 minutes**.

---

## Step 1 — Create a Supabase project (free)

1. Go to [supabase.com](https://supabase.com) and sign up for a free account.
2. Click **New project**.
3. Fill in:
   - **Project name:** `hsro-dashboard` (or anything you like)
   - **Database password:** choose a strong password and save it somewhere safe
   - **Region:** pick the closest US region
4. Click **Create new project** and wait about 1–2 minutes for it to initialize.

---

## Step 2 — Run the database schema

1. In your Supabase project, click **SQL Editor** in the left sidebar.
2. Click **New query**.
3. Open the file `supabase-schema.sql` from this folder, copy all the contents, and paste them into the editor.
4. Click **Run** (or press Ctrl/Cmd + Enter).
5. You should see "Success. No rows returned." — the table is created.

---

## Step 3 — Get your Supabase credentials

1. In your Supabase project, click **Project Settings** (gear icon) in the sidebar.
2. Click **API** under Configuration.
3. Copy two values:
   - **Project URL** — looks like `https://abcdefghijkl.supabase.co`
   - **anon / public** key — a long string starting with `eyJ...`

Keep these handy for the next step.

---

## Step 4 — Update the HTML files

Open **both** `index.html` and `admin.html` in a text editor. Near the top of each file you will find:

```javascript
const SUPABASE_URL      = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
```

Replace `YOUR_SUPABASE_URL` with your Project URL and `YOUR_SUPABASE_ANON_KEY` with your anon key.

**Do this in both files.**

---

## Step 5 — Set up GitHub and publish to GitHub Pages

### Create a GitHub repository

1. Go to [github.com](https://github.com) and sign in (or create a free account).
2. Click the **+** icon → **New repository**.
3. Name it `hsro-dashboard` (or any name you prefer).
4. Set visibility to **Public** (required for free GitHub Pages) — or **Private** if you have GitHub Pro/Teams.
5. Click **Create repository**.

### Upload your files

1. On the new repository page, click **uploading an existing file**.
2. Drag and drop (or select) all four files:
   - `index.html`
   - `admin.html`
   - `supabase-schema.sql`
   - `SETUP.md`
3. Scroll down, add a commit message like "Initial dashboard upload", and click **Commit changes**.

### Enable GitHub Pages

1. In your repository, click **Settings** (top navigation bar).
2. In the left sidebar under **Code and automation**, click **Pages**.
3. Under **Source**, select **Deploy from a branch**.
4. Under **Branch**, choose `main` and `/ (root)`, then click **Save**.
5. Wait 1–2 minutes. Refresh the page. A green banner will appear with your site URL:
   `https://your-username.github.io/hsro-dashboard/`

---

## Step 6 — Verify it works

1. Open your dashboard URL in a browser. You should see all 13 goals with "Not Started" status.
2. Open `…/admin.html`. Enter the default password: **HSRO2027!**
3. Log a test update on any goal and click Save.
4. Return to the dashboard and click on that goal card — your update should appear.

---

## Changing the password

The admin portal uses a SHA-256 hash of the password (a one-way fingerprint — not reversible).

To set a new password:

1. Go to [https://emn178.github.io/online-tools/sha256.html](https://emn178.github.io/online-tools/sha256.html)
2. Type your new password in the **Input** box (leave encoding as UTF-8).
3. Copy the hash from the **Output** box.
4. Open `admin.html` and find this line near the top:
   ```javascript
   const PASSWORD_HASH = 'abab999561d01dd4edc25ae253d8c7f5cd99261fcf41b05653c7f12af55c25fb';
   ```
5. Replace the hash value with the one you copied.
6. Save the file and re-upload it to GitHub (or commit the change).
7. Share the new plain-text password with your team — never commit it to GitHub.

> **Note:** The default password `HSRO2027!` is shown in this file, so change it before going live.

---

## Sharing with the team

Once live, share:
- **Dashboard link:** `https://your-username.github.io/hsro-dashboard/` (bookmark this)
- **Admin portal:** `https://your-username.github.io/hsro-dashboard/admin.html`
- **Password:** whatever you set in Step 6 above

Anyone with the password can log updates from any device — phone, tablet, or desktop.

---

## Making the repository private (recommended)

If you want to keep the source code (including the password hash) private:

- GitHub Pages requires a public repo on the free plan.
- With **GitHub Pro** ($4/mo) or **GitHub Teams**, you can use a private repo with Pages.
- Alternatively, deploy to **Netlify** (also free) which supports private repos: drag-and-drop your folder at [netlify.com](https://netlify.com) and it deploys instantly.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Dashboard shows "Not connected" | Check that SUPABASE_URL and SUPABASE_ANON_KEY are updated in both HTML files and re-uploaded |
| Updates don't appear on dashboard | Wait up to 60 seconds for auto-refresh, or reload the page |
| Password not working | Check that you updated PASSWORD_HASH in admin.html and re-uploaded |
| GitHub Pages shows 404 | Make sure the branch is set to `main` and root `/` in Pages settings |
| Supabase insert error | Confirm the SQL schema was run successfully in Supabase SQL Editor |

---

## File summary

| File | Purpose |
|---|---|
| `index.html` | Public goals dashboard |
| `admin.html` | Password-protected update portal |
| `supabase-schema.sql` | Run once in Supabase to create the database table |
| `SETUP.md` | This guide |
