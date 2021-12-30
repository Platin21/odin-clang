package clang;

foreign import libclang "libclang"
import "core:c"

/*===-- CXErrorCode.odin - C-Index Error Codes  -------------------------*-===*\
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This file provides the CXErrorCode enumerators.                            *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/



/**
 * Error codes returned by libclang routines.
 *
 * Zero (\c CXError_Success) is the only error code indicating success.  Other
 * error codes, including not yet assigned non-zero values, indicate errors.
 */
CXErrorCode :: enum c.int {
  /**
   * No error.
   */
  Success = 0,

  /**
   * A generic error code, no further details are available.
   *
   * Errors of this kind can get their own specific error codes in future
   * libclang versions.
   */
  Failure = 1,

  /**
   * libclang crashed while performing the requested operation.
   */
  Crashed = 2,

  /**
   * The function detected that the arguments violate the function
   * contract.
   */
  InvalidArguments = 3,

  /**
   * An AST deserialization error has occurred.
   */
  ASTReadError = 4,
};
