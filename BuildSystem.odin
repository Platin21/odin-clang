package clang

/*==-- clang-c/BuildSystem.h - Utilities for use by build systems -*- C -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This header provides various utilities for use by build systems.           *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
foreign import libclang "libclang"
import "core:c"

/**
 * Object encapsulating information about a module.map file.
 */
CXModuleMapDescriptor :: distinct rawptr;

/**
 * Object encapsulating information about overlaying virtual
 * file/directories over the real file system.
 */
CXVirtualFileOverlay :: distinct rawptr; 

/**
 * \defgroup BUILD_SYSTEM Build system utilities
 * @{
 */
@(default_calling_convention="c")
foreign libclang { 

/**
 * Return the timestamp for use with Clang's
 * \c -fbuild-session-timestamp= option.
 */
 clang_getBuildSessionTimestamp :: proc() -> u64 ---;

/**
 * Create a \c CXVirtualFileOverlay object.
 * Must be disposed with \c clang_VirtualFileOverlay_dispose().
 *
 * \param options is reserved, always pass 0.
 */

clang_VirtualFileOverlay_create :: proc(options: c.uint) -> CXVirtualFileOverlay ---; 

/**
 * Map an absolute virtual file path to an absolute real one.
 * The virtual path must be canonicalized (not contain "."/"..").
 * \returns 0 for success, non-zero to indicate an error.
 */
clang_VirtualFileOverlay_addFileMapping :: proc(overlay: CXVirtualFileOverlay,
                                        virtualPath: cstring,
                                        realPath: cstring) -> CXErrorCode ---; 

/**
 * Set the case sensitivity for the \c CXVirtualFileOverlay object.
 * The \c CXVirtualFileOverlay object is case-sensitive by default, this
 * option can be used to override the default.
 * \returns 0 for success, non-zero to indicate an error.
 */
clang_VirtualFileOverlay_setCaseSensitivity :: proc(overlay: CXVirtualFileOverlay,
                                            caseSensitive: c.int) -> CXErrorCode ---;

/**
 * Write out the \c CXVirtualFileOverlay object to a char buffer.
 *
 * \param options is reserved, always pass 0.
 * \param out_buffer_ptr pointer to receive the buffer pointer, which should be
 * disposed using \c clang_free().
 * \param out_buffer_size pointer to receive the buffer size.
 * \returns 0 for success, non-zero to indicate an error.
 */
clang_VirtualFileOverlay_writeToBuffer :: proc(overlay: CXVirtualFileOverlay, 
									   options: c.uint,
                                       out_buffer_ptr: ^cstring,
                                       out_buffer_size: ^c.uint) -> CXErrorCode ---;

/**
 * free memory allocated by libclang, such as the buffer returned by
 * \c CXVirtualFileOverlay() or \c clang_ModuleMapDescriptor_writeToBuffer().
 *
 * \param buffer memory pointer to free.
 */
clang_free :: proc(buffer: rawptr) ---;

/**
 * Dispose a \c CXVirtualFileOverlay object.
 */
clang_VirtualFileOverlay_dispose :: proc(overlay: CXVirtualFileOverlay) ---;

/**
 * Create a \c CXModuleMapDescriptor object.
 * Must be disposed with \c clang_ModuleMapDescriptor_dispose().
 *
 * \param options is reserved, always pass 0.
 */
 
clang_ModuleMapDescriptor_create :: proc (options: c.uint) -> CXModuleMapDescriptor;

/**
 * Sets the framework module name that the module.map describes.
 * \returns 0 for success, non-zero to indicate an error.
 */
clang_ModuleMapDescriptor_setFrameworkModuleName :: proc (desc: CXModuleMapDescriptor,
                                                 name: cstring) -> CXErrorCode ---;

/**
 * Sets the umbrella header name that the module.map describes.
 * \returns 0 for success, non-zero to indicate an error.
 */
clang_ModuleMapDescriptor_setUmbrellaHeader :: proc(desc: CXModuleMapDescriptor, name: cstring) -> CXErrorCode ---;

/**
 * Write out the \c CXModuleMapDescriptor object to a char buffer.
 *
 * \param options is reserved, always pass 0.
 * \param out_buffer_ptr pointer to receive the buffer pointer, which should be
 * disposed using \c clang_free().
 * \param out_buffer_size pointer to receive the buffer size.
 * \returns 0 for success, non-zero to indicate an error.
 */
clang_ModuleMapDescriptor_writeToBuffer :: proc(desc: CXModuleMapDescriptor, options: c.uint,
                                       out_buffer_ptr: ^cstring,
                                       out_buffer_size: ^c.uint) -> CXErrorCode ---;

/**
 * Dispose a \c CXModuleMapDescriptor object.
 */
clang_ModuleMapDescriptor_dispose :: proc(desc: CXModuleMapDescriptor) ---;


}