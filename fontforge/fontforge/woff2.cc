/* Copyright (C) 2018 by Jeremy Tan */
/*
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.

 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.

 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <woff2/decode.h>
#include <woff2/encode.h>

extern "C" {
size_t woff2_max_woff2_compressed_size(const uint8_t *data, size_t length)
{
    try {
        return woff2::MaxWOFF2CompressedSize(data, length);
    } catch (const std::exception &) {
        return 0;
    }
}

size_t woff2_compute_woff2_final_size(const uint8_t *data, size_t length)
{
    try {
        return woff2::ComputeWOFF2FinalSize(data, length);
    } catch (const std::exception &) {
        return 0;
    }
}

int woff2_convert_ttf_to_woff2(const uint8_t *data, size_t length, uint8_t *result, size_t *result_length)
{
    try {
        return woff2::ConvertTTFToWOFF2(data, length, result, result_length);
    } catch (const std::exception &) {
        return false;
    }
}

int woff2_convert_woff2_to_ttf(const uint8_t *data, size_t length, uint8_t *result, size_t *result_length)
{
    try {
        woff2::WOFF2MemoryOut output(result, *result_length);
        bool ret = woff2::ConvertWOFF2ToTTF(data, length, &output);
        if (ret) {
            *result_length = output.Size();
        } else {
            *result_length = 0;
        }
        return ret;
    } catch (const std::exception &) {
        return false;
    }
}
}
