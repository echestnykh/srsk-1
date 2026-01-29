// ==================== UTILS.JS ====================
// Общие утилиты: pluralize, debounce, escapeHtml

(function() {
'use strict';

/**
 * Склонение слов для разных языков
 * @param {number} n - число
 * @param {Object} forms - формы слова { ru: ['рецепт', 'рецепта', 'рецептов'], en: ['recipe', 'recipes'], hi: 'व्यंजन' }
 * @param {string} lang - язык (ru, en, hi)
 * @returns {string} - "5 рецептов"
 */
function pluralize(n, forms, lang) {
    const langForms = forms[lang] || forms.ru;

    // Хинди: не склоняется
    if (typeof langForms === 'string') {
        return `${n} ${langForms}`;
    }

    // Английский: singular/plural
    if (lang === 'en' || langForms.length === 2) {
        return `${n} ${n === 1 ? langForms[0] : langForms[1]}`;
    }

    // Русский: one/few/many
    const mod10 = n % 10;
    const mod100 = n % 100;

    if (mod10 === 1 && mod100 !== 11) {
        return `${n} ${langForms[0]}`;
    }
    if (mod10 >= 2 && mod10 <= 4 && (mod100 < 10 || mod100 >= 20)) {
        return `${n} ${langForms[1]}`;
    }
    return `${n} ${langForms[2]}`;
}

/** Debounce функция для оптимизации частых вызовов */
function debounce(fn, delay = 300) {
    let timer;
    return (...args) => {
        clearTimeout(timer);
        timer = setTimeout(() => fn(...args), delay);
    };
}

/** Экранирование HTML для защиты от XSS */
function escapeHtml(str) {
    if (str == null) return '';
    return String(str)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#039;');
}

/** Валидация цвета в формате HEX (#RRGGBB) для защиты от CSS injection */
function isValidColor(color) {
    if (!color) return false;
    return /^#[0-9A-Fa-f]{6}$/.test(color);
}

window.Utils = { pluralize, debounce, escapeHtml, isValidColor };

})();
