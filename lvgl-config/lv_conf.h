#ifndef LV_CONF_H
#define LV_CONF_H

/* If we are in Assembly mode (like when compiling .S files),
   skip everything to prevent "unrecognized opcode" errors */
#ifdef __ASSEMBLY__
#else

#include <stdint.h>

/*********************
 * COLOR SETTINGS
 *********************/
#define LV_COLOR_DEPTH 1
#define LV_COLOR_FORMAT_NATIVE LV_COLOR_FORMAT_I1
#define LV_DRAW_SW_MONOCHROME 1

/*********************
 * TICK & OS SETTINGS
 *********************/
#define LV_USE_OS LV_OS_NONE
#define LV_TICK_CUSTOM 1
#define LV_TICK_CUSTOM_INCLUDE "esp_timer.h"
#define LV_TICK_CUSTOM_SYS_TIME_EXPR (uint32_t)(esp_timer_get_time() / 1000)

/*********************
 * ARCHITECTURE FIXES
 *********************/
/* Force LVGL to use standard C drawing instead of ARM assembly */
#define LV_ARCH_NONE 1
#define LV_USE_DRAW_SW 1
#define LV_USE_DRAW_SW_ASM 0
#define LV_USE_DRAW_SW_SIMD 0

/*********************
 * FEATURE SETTINGS
 *********************/
#define LV_USE_FREETYPE 1
#if LV_USE_FREETYPE
    #define LV_FREETYPE_CACHE_SIZE (16 * 1024)
    #define LV_FREETYPE_USE_SBIT 1
#endif
#define LV_FONT_MONTSERRAT_14 1

/*********************
 * DEBUG & MEMORY
 *********************/
#define LV_MEM_SIZE (32U * 1024U)
#define LV_USE_ASSERT_NULL 0
#define LV_USE_ASSERT_MEM_INTEGRITY 0
#define LV_USE_LOG 0
#define LV_USE_USER_DATA 1

#endif /* __ASSEMBLY__ */
#endif /* LV_CONF_H */
