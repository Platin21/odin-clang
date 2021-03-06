package clang

foreign import libclang "libclang"
import "core:c"

/*===-- CXString.odin - C Index strings -----------------------------------===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This odin file provides the interface to C Index strings.                  *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/



/**
 * \defgroup CINDEX_STRING String manipulation routines
 * \ingroup CINDEX
 *
 * @{
 */

/**
 * A character string.
 *
 * The \c CXString type is used to return strings from the interface when
 * the ownership of that string might differ from one call to the next.
 * Use \c clang_getCString() to retrieve the string data and, once finished
 * with the string data, call \c clang_disposeString() to free the string.
 */
 CXString :: struct {
  data: rawptr,
  private_flags: c.uint,
};

CXStringSet :: []CXString

@(default_calling_convention="c",  link_prefix="clang_")
foreign libclang {

/**
 * Retrieve the character data associated with the given string.
 */
getCString :: proc(str: CXString) -> cstring ---;

/**
 * Free the given string.
 */
disposeString :: proc(str: CXString) ---;

/**
 * Free the given string set.
 */
disposeStringSet :: proc(set: ^CXStringSet) ---;

/**
 * @}
 */

 }