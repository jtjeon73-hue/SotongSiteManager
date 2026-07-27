import { expect, test } from '@playwright/test';

const BASE = 'https://sotongsitemanager.web.app';
const routes = [
  '/',
  '/sites',
  '/sites/ai-story',
  '/sites/electric',
  '/sites/car',
  '/sites/finance',
  '/sites/language',
  '/categories',
  '/learning',
  '/find',
  '/search',
  '/about',
];

async function waitForFlutter(page: import('@playwright/test').Page) {
  await page.waitForFunction(() => {
    const loading = document.getElementById('loading');
    const flutterView = document.querySelector('flutter-view, flt-glass-pane, canvas');
    return !loading && !!flutterView;
  }, undefined, { timeout: 90_000 });
  await page.waitForTimeout(1000);
}

async function hasHorizontalOverflow(page: import('@playwright/test').Page) {
  return page.evaluate(
    () => document.documentElement.scrollWidth > document.documentElement.clientWidth + 1,
  );
}

test.describe('production stage2', () => {
  for (const route of routes) {
    test(`direct ${route}`, async ({ page }) => {
      const response = await page.goto(`${BASE}${route}`, {
        waitUntil: 'domcontentloaded',
      });
      expect(response?.status()).toBeLessThan(400);
      await waitForFlutter(page);
      expect(await hasHorizontalOverflow(page)).toBeFalsy();
    });

    test(`refresh ${route}`, async ({ page }) => {
      await page.goto(`${BASE}${route}`, { waitUntil: 'domcontentloaded' });
      await waitForFlutter(page);
      await page.reload({ waitUntil: 'domcontentloaded' });
      await waitForFlutter(page);
      await expect(page.locator('flutter-view, flt-glass-pane, canvas').first()).toBeVisible();
    });
  }

  test('seo assets and external hosts', async ({ request }) => {
    expect((await request.get(`${BASE}/robots.txt`)).ok()).toBeTruthy();
    expect((await request.get(`${BASE}/sitemap.xml`)).ok()).toBeTruthy();
    const js = await (await request.get(`${BASE}/main.dart.js`)).text();
    expect(js).toContain('sotong-elec.web.app');
    expect(js).toContain('/find');
  });
});
