#ifndef LV_CONF_H
#define LV_CONF_H

/*********************
 *  COLOR SETTINGS
 *********************/

/* LVGL 9.x requires explicit native color format.
 * For a 1‑bit monochrome OLED, this is correct.
 */
#define LV_COLOR_FORMAT_NATIVE LV_COLOR_FORMAT_1BIT

/* Enable monochrome drawing pipeline */
#define LV_DRAW_SW_MONOCHROME 1


/*********************
 *  MEMORY SETTINGS
 *********************/

/* 32 KB is enough for monochrome + FreeType */
#define LV_MEM_SIZE (32U * 1024U)


/*********************
 *  TICK SETTINGS
 *********************/

#define LV_TICK_CUSTOM 1
#define LV_TICK_CUSTOM_INCLUDE "esp_timer.h"
#define LV_TICK_CUSTOM_SYS_TIME_EXPR (esp_timer_get_time() / 1000)


/*********************
 *  FEATURE SETTINGS
 *********************/

/* FreeType support */
#define LV_USE_FREETYPE 1
#define LV_FREETYPE_CACHE_SIZE (64 * 1024)

/* Disable GPU (ESP32‑C3 has none) */
#define LV_USE_GPU 0
#define LV_USE_DRAW_SW_ASM 0
#define LV_USE_DRAW_SW_SIMD 0

/* Disable logging */
#define LV_USE_LOG 0


/*********************
 *  DEMOS / EXAMPLES
 *********************/

#define LV_USE_DEMO_WIDGETS 0
#define LV_USE_DEMO_KEYPAD_AND_ENCODER 0
#define LV_USE_DEMO_BENCHMARK 0
#define LV_USE_DEMO_STRESS 0

#endif /* LV_CONF_H */

