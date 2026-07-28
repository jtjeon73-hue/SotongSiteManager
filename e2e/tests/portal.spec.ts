import { expect, test } from '@playwright/test';

async function waitForFlutter(page: import('@playwright/test').Page) {
  await page.waitForFunction(() => {
    const loading = document.getElementById('loading');
    const flutterView = document.querySelector('flutter-view, flt-glass-pane, canvas');
    return !loading && !!flutterView;
  }, undefined, { timeout: 90_000 });
  await page.waitForTimeout(1200);
}

async function hasHorizontalOverflow(page: import('@playwright/test').Page) {
  return page.evaluate(() => {
    const doc = document.documentElement;
    return doc.scrollWidth > doc.clientWidth + 1;
  });
}

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
  '/categories',
  '/learning',
  '/find',
  '/search',
  '/about',
];

test.describe('소통사이트매니저 stage3 e2e', () => {
  test('홈 로드와 콘솔·overflow', async ({ page }) => {
    const errors: string[] = [];
    page.on('pageerror', (err) => errors.push(String(err)));
    page.on('console', (msg) => {
      if (msg.type() === 'error') errors.push(msg.text());
    });
    await page.goto('/');
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

  for (const route of routes) {
    test(`직접 접근 ${route}`, async ({ page }) => {
      const response = await page.goto(route, { waitUntil: 'domcontentloaded' });
      expect(response?.status()).toBeLessThan(400);
      await waitForFlutter(page);
      expect(await hasHorizontalOverflow(page)).toBeFalsy();
    });
  }

  test('전문관·검색·찾기 라우트', async ({ page }) => {
    await page.goto('/sites/health');
    await waitForFlutter(page);
    await expect(page).toHaveURL(/\/sites\/health/);

    await page.goto('/find');
    await waitForFlutter(page);
    await expect(page).toHaveURL(/\/find/);

    await page.goto('/search');
    await waitForFlutter(page);
    await expect(page).toHaveURL(/\/search/);
  });

  test('뒤로 가기와 새로고침', async ({ page }) => {
    await page.goto('/sites');
    await waitForFlutter(page);
    await page.goto('/sites/plc');
    await waitForFlutter(page);
    await page.goBack();
    await waitForFlutter(page);
    await expect(page).toHaveURL(/\/sites/);
    await page.reload({ waitUntil: 'domcontentloaded' });
    await waitForFlutter(page);
    expect(await hasHorizontalOverflow(page)).toBeFalsy();
  });

  test('외부 링크 주소가 빌드에 포함된다', async ({ request }) => {
    const js = await (await request.get('/main.dart.js')).text();
    for (const host of [
      'sotongware-ai-story.web.app',
      'sotong-elec.web.app',
      'sotong-car.web.app',
      'sotong-finance.web.app',
      'sotong-language.web.app',
      'sotong-health-site.web.app',
      'sotongware-plc.web.app',
      'sotong-smart-farm.web.app',
      'sotong-dev.web.app',
      'sotong-web-app-dev.web.app',
      'sotong-country-ai.web.app',
    ]) {
      expect(js).toContain(host);
    }
  });

  test('robots와 sitemap', async ({ request }) => {
    const robots = await request.get('/robots.txt');
    const sitemap = await request.get('/sitemap.xml');
    expect(robots.ok()).toBeTruthy();
    expect(sitemap.ok()).toBeTruthy();
    expect(await robots.text()).toContain('sitemap.xml');
    const xml = await sitemap.text();
    expect(xml).toContain('/sites/electric');
    expect(xml).toContain('/sites/health');
    expect(xml).toContain('/sites/web-app-dev');
    expect(xml).toContain('/sites/country-ai');
  });

  test('모바일 overflow', async ({ page }) => {
    await page.setViewportSize({ width: 360, height: 800 });
    await page.goto('/');
    await waitForFlutter(page);
    expect(await hasHorizontalOverflow(page)).toBeFalsy();
    await page.goto('/sites/country-ai');
    await waitForFlutter(page);
    expect(await hasHorizontalOverflow(page)).toBeFalsy();
  });
});
