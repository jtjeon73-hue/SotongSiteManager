import { expect, test } from '@playwright/test';

const BASE = 'https://sotongsitemanager.web.app';
const routes = ['/', '/sites', '/categories', '/learning', '/search', '/about'];

async function waitForFlutter(page: import('@playwright/test').Page) {
  await page.waitForFunction(() => {
    const loading = document.getElementById('loading');
    const flutterView = document.querySelector('flutter-view, flt-glass-pane, canvas');
    return !loading && !!flutterView;
  }, undefined, { timeout: 90_000 });
  await page.waitForTimeout(1200);
}

async function hasHorizontalOverflow(page: import('@playwright/test').Page) {
  return page.evaluate(() => document.documentElement.scrollWidth > document.documentElement.clientWidth + 1);
}

test.describe('production hosting verification', () => {
  for (const route of routes) {
    test(`direct access ${route}`, async ({ page }) => {
      const errors: string[] = [];
      page.on('pageerror', (err) => errors.push(String(err)));
      page.on('console', (msg) => {
        if (msg.type() === 'error') errors.push(msg.text());
      });

      const response = await page.goto(`${BASE}${route}`, { waitUntil: 'domcontentloaded' });
      expect(response?.status()).toBeLessThan(400);
      await waitForFlutter(page);
      await expect(page).toHaveTitle(/소통사이트매니저/);
      expect(await hasHorizontalOverflow(page)).toBeFalsy();

      const critical = errors.filter(
        (e) =>
          !e.includes('GoogleFonts') &&
          !e.includes('fonts.gstatic.com') &&
          !e.includes('Failed to load font'),
      );
      expect(critical).toEqual([]);
    });

    test(`refresh ${route}`, async ({ page }) => {
      await page.goto(`${BASE}${route}`, { waitUntil: 'domcontentloaded' });
      await waitForFlutter(page);
      await page.reload({ waitUntil: 'domcontentloaded' });
      await waitForFlutter(page);
      expect(page.url()).toContain(route === '/' ? 'sotongsitemanager.web.app' : route);
      await expect(page.locator('flutter-view, flt-glass-pane, canvas').first()).toBeVisible();
    });
  }

  test('favicon manifest and metadata', async ({ request, page }) => {
    const favicon = await request.get(`${BASE}/favicon.png`);
    const manifest = await request.get(`${BASE}/manifest.json`);
    const apple = await request.get(`${BASE}/apple-touch-icon.png`);
    expect(favicon.ok()).toBeTruthy();
    expect(manifest.ok()).toBeTruthy();
    expect(apple.ok()).toBeTruthy();

    const manifestJson = await manifest.json();
    expect(manifestJson.name).toContain('소통사이트매니저');

    await page.goto(BASE);
    await waitForFlutter(page);
    await expect(page).toHaveTitle(/소통사이트매니저/);
  });

  test('external specialist site URLs in bundle', async ({ request }) => {
    const js = await (await request.get(`${BASE}/main.dart.js`)).text();
    for (const host of [
      'sotongware-ai-story.web.app',
      'sotong-elec.web.app',
      'sotong-car.web.app',
      'sotong-finance.web.app',
      'sotong-language.web.app',
    ]) {
      expect(js).toContain(host);
    }
  });

  for (const width of [360, 390, 412, 768, 1280]) {
    test(`responsive ${width}px home no overflow`, async ({ page }) => {
      await page.setViewportSize({ width, height: 900 });
      await page.goto(BASE);
      await waitForFlutter(page);
      expect(await hasHorizontalOverflow(page)).toBeFalsy();
    });
  }
});
