// ==================== PORTAL-CONFIG.JS ====================
// Конфигурация Supabase для Guest Portal
// ВАЖНО: Этот файл должен быть подключен ПЕРВЫМ в HTML

(function() {
'use strict';

window.PORTAL_CONFIG = {
    SUPABASE_URL: 'https://llttmftapmwebidgevmg.supabase.co',
    SUPABASE_ANON_KEY: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxsdHRtZnRhcG13ZWJpZGdldm1nIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg4NzQ3MTksImV4cCI6MjA4NDQ1MDcxOX0.V0J4_5AFDxHH6GsD-eh4N7fTBMjexSxAkVp2LSfgHh0',

    // Цвета портала
    COLORS: {
        GREEN: '#147D30',
        ORANGE: '#FFBA47',
        BG: '#F5F3EF'
    },

    // Storage bucket для фото
    PHOTO_BUCKET: 'vaishnava-photos'
};

// Создаём ЕДИНСТВЕННЫЙ экземпляр Supabase клиента
if (typeof window.supabase !== 'undefined') {
    window.portalSupabase = window.supabase.createClient(
        window.PORTAL_CONFIG.SUPABASE_URL,
        window.PORTAL_CONFIG.SUPABASE_ANON_KEY
    );
}

})();
