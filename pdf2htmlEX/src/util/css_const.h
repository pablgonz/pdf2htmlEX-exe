/* vim: set filetype=cpp : */
/*
 * css_const.h
 *
 * Copyright (C) 2013 Lu Wang <coolwanglu@gmail.com>
 */

#ifndef CSS_CONST_H__
#define CSS_CONST_H__


/*
 * should be consistent with base.css and pdf2htmlEX.js
 */

namespace pdf2htmlEX {
namespace CSS {

// work around strings
const char * const WEBKIT_ONLY         = "@media screen and (-webkit-min-device-pixel-ratio:0)";
const char * const PRINT_ONLY          = "@media print";

// usually the class name is XXX_CN or XXX_CN<hex id>
// sometimes we need a special one, e.g. transparent color, where the id is -1
const char * const INVALID_ID          = "_";

const char * const LINE_CN             = "t";
const char * const TRANSFORM_MATRIX_CN = "m";
const char * const CLIP_CN             = "c";

// page_decoration is for shadow etc
// page_frame cannot have margin or border-width, pdf2htmlEX.js will use it to determine the coordinates
// page_content holds everything inside the page, could be hidden to speed up rendering
// page_data holds data for pdf2htmlEX.js
const char * const PAGE_DECORATION_CN  = "";
const char * const PAGE_FRAME_CN       = "pf";
const char * const PAGE_CONTENT_BOX_CN = "pc";
const char * const PAGE_DATA_CN        = "pi";

const char * const BACKGROUND_IMAGE_CN = "bi";
const char * const FULL_BACKGROUND_IMAGE_CN = "bf";

const char * const FONT_FAMILY_CN      = "ff";
const char * const FONT_SIZE_CN        = "fs";
const char * const FILL_COLOR_CN       = "fc";
const char * const STROKE_COLOR_CN     = "sc";
const char * const LETTER_SPACE_CN     = "ls";
const char * const WORD_SPACE_CN       = "ws";
const char * const VERTICAL_ALIGN_CN   = "v";
const char * const WHITESPACE_CN       = "_";
const char * const LEFT_CN             = "x";
const char * const HEIGHT_CN           = "h";
const char * const WIDTH_CN            = "w";
const char * const BOTTOM_CN           = "y";

const char * const CSS_DRAW_CN         = "d";
const char * const LINK_CN             = "l";

const char * const INPUT_TEXT_CN       = "it";
const char * const INPUT_RADIO_CN      = "ir";
const char * const RADIO_CHECKED_CN    = "checked";

}
}


#endif //CSS_CONST_H__
