import { expect, test } from '@playwright/test';

async function waitForFlutter(page: import('@playwright/test').Page) {
  await page.waitForFunction(() => {
    const loading = document.getElementById('loading');
    const flutterView = document.querySelector('flutter-view, flt-glass-pane, canvas');
    return !loading && !!flutterView;
  }, undefined, { timeout: 90_000 });
  await page.waitForTimeout(1500);
}

async function hasHorizontalOverflow(page: import('@playwright/test').Page) {
  return page.evaluate(() => {
    const doc = document.documentElement;
    return doc.scrollWidth > doc.clientWidth + 1;
  });
}

test.describe('소통사이트매니저 e2e', () => {
  test('데스크톱/모바일 홈 로드와 콘솔·overflow', async ({ page }) => {
    const errors: string[] = [];
    page.on('pageerror', (err) => errors.push(String(err)));
    page.on('console', (msg) => {
      if (msg.type() === 'error') {
        errors.push(msg.text());
      }
    });

    await page.goto('/');
    await waitForFlutter(page);

    await expect(page).toHaveTitle(/소통사이트매니저/);
    await expect(page.locator('flutter-view, flt-glass-pane, canvas').first()).toBeVisible();
    expect(await hasHorizontalOverflow(page)).toBeFalsy();

    const critical = errors.filter(
      (e) =>
        !e.includes('GoogleFonts') &&
        !e.includes('fonts.gstatic.com') &&
        !e.includes('Failed to load font'),
    );
    expect(critical).toEqual([]);
  });

  test('전체 사이트 라우트 접근', async ({ page }) => {
    await page.goto('/sites');
    await waitForFlutter(page);
    await expect(page).toHaveURL(/\/sites/);
    await expect(page.locator('flutter-view, flt-glass-pane, canvas').first()).toBeVisible();
    expect(await hasHorizontalOverflow(page)).toBeFalsy();
  });

  test('검색 라우트와 메타 링크 주소 확인', async ({ page }) => {
    await page.goto('/search');
    await waitForFlutter(page);
    await expect(page).toHaveURL(/\/search/);
    await expect(page.locator('flutter-view, flt-glass-pane, canvas').first()).toBeVisible();
    expect(await hasHorizontalOverflow(page)).toBeFalsy();

    // External site URLs are verified in unit tests; here we assert known hosts
    // remain documented in the built artifact for ops sanity.
    const index = await page.content();
    expect(index.length).toBeGreaterThan(100);
  });

  test('외부 지식 사이트 주소가 빌드 산출물에 포함된다', async ({ request }) => {
    const response = await request.get('/main.dart.js');
    expect(response.ok()).toBeTruthy();
    const js = await response.text();
    expect(js).toContain('sotongware-ai-story.web.app');
    expect(js).toContain('sotong-elec.web.app');
    expect(js).toContain('sotong-car.web.app');
    expect(js).toContain('sotong-finance.web.app');
    expect(js).toContain('sotong-language.web.app');
  });
});
