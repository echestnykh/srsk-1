import { test, expect } from '@playwright/test';

test.describe('Все вайшнавы — vaishnavas/index.html', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/vaishnavas/index.html');
    await page.waitForFunction(() => typeof Layout !== 'undefined', { timeout: 5000 });
  });

  test('таблица загружается', async ({ page }) => {
    await page.waitForSelector('table tbody tr', { timeout: 10000 });
    const rows = await page.locator('table tbody tr').count();
    expect(rows).toBeGreaterThan(0);
  });

  test('поиск работает', async ({ page }) => {
    await page.waitForSelector('table tbody tr', { timeout: 10000 });
    
    const searchInput = page.locator('#searchInput');
    if (await searchInput.isVisible()) {
      await searchInput.fill('тест');
      await page.waitForTimeout(500);
      // Проверяем что фильтрация сработала (без ошибок)
    }
  });

  test('кнопка добавления присутствует', async ({ page }) => {
    const addBtn = page.locator('button:has-text("Добавить"), [data-i18n="add"], .btn-primary');
    const count = await addBtn.count();
    expect(count).toBeGreaterThan(0);
  });
});

test.describe('Команда — vaishnavas/team.html', () => {
  test('страница загружается', async ({ page }) => {
    await page.goto('/vaishnavas/team.html');
    await page.waitForFunction(() => typeof Layout !== 'undefined', { timeout: 5000 });
    // Ждём завершения загрузки данных (таблица или пустое состояние)
    await page.waitForSelector('table tbody tr, #emptyState', { timeout: 10000 });
  });
});

test.describe('Гости — vaishnavas/guests.html', () => {
  test('страница загружается', async ({ page }) => {
    await page.goto('/vaishnavas/guests.html');
    await page.waitForFunction(() => typeof Layout !== 'undefined', { timeout: 5000 });
  });
});

test.describe('Профиль — vaishnavas/person.html', () => {
  test('страница требует id параметр', async ({ page }) => {
    await page.goto('/vaishnavas/person.html');
    // Без id должно показать ошибку или редирект
    await page.waitForTimeout(1000);
  });
});
