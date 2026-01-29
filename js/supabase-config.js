// Supabase Configuration
// Используем централизованный CONFIG из config.js

// Initialize Supabase client
const supabase = window.supabase.createClient(CONFIG.SUPABASE_URL, CONFIG.SUPABASE_ANON_KEY);

// Helper function to get current language
function getCurrentLang() {
    return localStorage.getItem('srsk_lang') || 'ru';
}

// Helper function to get localized name
function getLocalizedName(item, lang = getCurrentLang()) {
    return item[`name_${lang}`] || item.name_ru;
}

// Export for use in other scripts
window.db = supabase;
window.getCurrentLang = getCurrentLang;
window.getLocalizedName = getLocalizedName;
