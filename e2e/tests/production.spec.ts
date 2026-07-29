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
  '/sites/health',
  '/sites/plc',
  '/sites/smart-farm',
  '/sites/development',
  '/sites/web-app-dev',
  '/sites/country-ai',
  '/sites/save-live',
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

test.describe('production stage3', () => {
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
    const sitemap = await request.get(`${BASE}/sitemap.xml`);
    expect(sitemap.ok()).toBeTruthy();
    expect(await sitemap.text()).toContain('/sites/web-app-dev');
    expect(await sitemap.text()).toContain('/sites/save-live');
    const js = await (await request.get(`${BASE}/main.dart.js`)).text();
    expect(js).toContain('sotong-elec.web.app');
    expect(js).toContain('sotong-health-site.web.app');
    expect(js).toContain('sotong-web-app-dev.web.app');
    expect(js).toContain('sotong-country-ai.web.app');
    expect(js).toContain('sotong-save-live.web.app');
    expect(js).toContain('/find');
  });
});
