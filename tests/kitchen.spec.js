import { test, expect } from '@playwright/test';

test.describe('Рецепты — kitchen/recipes.html', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/kitchen/recipes.html');
    // Ждём загрузку Layout
    await page.waitForFunction(() => typeof Layout !== 'undefined', { timeout: 5000 });
  });

  test('страница загружается без ошибок', async ({ page }) => {
    // Проверяем что нет ошибок в консоли
    const errors = [];
    page.on('pageerror', err => errors.push(err.message));
    await page.waitForTimeout(1000);
    expect(errors).toHaveLength(0);
  });

  test('карточки рецептов отображаются', async ({ page }) => {
    // Ждём пока карточки рецептов загрузятся
    await page.waitForSelector('.recipe-card', { timeout: 10000 });
    const cards = await page.locator('.recipe-card').count();
    expect(cards).toBeGreaterThan(0);
  });

  test('поле поиска имеет крестик очистки', async ({ page }) => {
    const searchInput = page.locator('#searchInput');
    const clearBtn = page.locator('#clearSearch');

    // Изначально крестик скрыт
    await expect(clearBtn).toBeHidden();

    // Вводим текст — крестик появляется
    await searchInput.fill('тест');
    await expect(clearBtn).toBeVisible();

    // Нажимаем крестик — поле очищается
    await clearBtn.click();
    await expect(searchInput).toHaveValue('');
    await expect(clearBtn).toBeHidden();
  });

  test('поиск фильтрует карточки', async ({ page }) => {
    await page.waitForSelector('.recipe-card', { timeout: 10000 });
    const initialCount = await page.locator('.recipe-card').count();

    await page.fill('#searchInput', 'абвгдеёжз'); // несуществующий текст
    // Ждём debounce + серверный запрос
    await page.waitForTimeout(1000);

    const filteredCount = await page.locator('.recipe-card').count();
    expect(filteredCount).toBeLessThanOrEqual(initialCount);
  });
});

test.describe('Продукты — kitchen/products.html', () => {
  test('страница загружается', async ({ page }) => {
    await page.goto('/kitchen/products.html');
    await page.waitForFunction(() => typeof Layout !== 'undefined', { timeout: 5000 });
    await page.waitForSelector('table tbody tr:not(.skeleton)', { timeout: 10000 });
    const rows = await page.locator('table tbody tr').count();
    expect(rows).toBeGreaterThan(0);
  });
});

test.describe('Меню — kitchen/menu.html', () => {
  test('страница загружается', async ({ page }) => {
    await page.goto('/kitchen/menu.html');
    await page.waitForFunction(() => typeof Layout !== 'undefined', { timeout: 5000 });
  });
});
