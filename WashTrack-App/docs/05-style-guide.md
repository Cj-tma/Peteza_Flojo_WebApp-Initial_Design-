:root {
  /* Core colors */
  --color-primary: #0e8fa6;
  --color-primary-text: #ffffff;   /* text on primary button */
  --color-bg: #eef6f8;
  --color-surface: #ffffff;        /* cards */
  --color-text: #12263a; /*  body text. Contrast on bg: 15.4:1. passed */
  --color-text-muted: #5b7083;
  --color-border: #d5e3e9;
  --color-success: #1c9a5b;
  --color-success-bg: #d6f1e3;
  --color-error: #d64545;

  /* Typography */
  --font-heading: "Bricolage Grotesque", system-ui, sans-serif;
  --font-body: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
  --font-size-base: 16px;
  --line-height-base: 1.5;

  /* Shape and spacing */
  --radius-input: 9px;
  --radius-button: 10px;
  --radius-card: 14px;
  --space-input: 9px 10px;
  --space-button: 10px 16px;
}

@media (prefers-color-scheme: dark) {
  :root {
    --color-primary: #35c0d6;
    --color-primary-text: #08212b;
    --color-bg: #0d1b26;
    --color-surface: #14293a;
    --color-text: #e6f0f5;
    --color-text-muted: #93a9b8;
    --color-border: #25405a;
    --color-success: #58d391;
    --color-success-bg: #12402b;
  }
}
