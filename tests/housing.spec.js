import { test, expect } from '@playwright/test';

test.describe('Таймлайн — placement/timeline.html', () => {
  test('страница загружается', async ({ page }) => {
    await page.goto('/placement/timeline.html');
    await page.waitForFunction(() => typeof Layout !== 'undefined', { timeout: 5000 });
  });
});

test.describe('Бронирования — placement/bookings.html', () => {
  test('страница загружается', async ({ page }) => {
    await page.goto('/placement/bookings.html');
    await page.waitForFunction(() => typeof Layout !== 'undefined', { timeout: 5000 });
  });
});

test.describe('Шахматка — reception/floor-plan.html', () => {
  test('страница загружается', async ({ page }) => {
    await page.goto('/reception/floor-plan.html');
    await page.waitForFunction(() => typeof Layout !== 'undefined', { timeout: 5000 });
  });
});

test.describe('Комнаты — reception/rooms.html', () => {
  test('карточки комнат загружаются', async ({ page }) => {
    await page.goto('/reception/rooms.html');
    await page.waitForFunction(() => typeof Layout !== 'undefined', { timeout: 5000 });
    await page.waitForSelector('#roomsList > div', { timeout: 10000 });
    const cards = await page.locator('#roomsList > div').count();
    expect(cards).toBeGreaterThan(0);
  });
});

test.describe('Здания — reception/buildings.html', () => {
  test('страница загружается', async ({ page }) => {
    await page.goto('/reception/buildings.html');
    await page.waitForFunction(() => typeof Layout !== 'undefined', { timeout: 5000 });
  });
});
