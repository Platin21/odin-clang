package clang

/*===-- clang-c/CXCompilationDatabase.h - Compilation database  ---*- C -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This header provides a public interface to use CompilationDatabase without *|
|* the full Clang C++ API.                                                    *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
foreign import libclang "libclang"
import "core:c"

/** \defgroup COMPILATIONDB CompilationDatabase functions
 * \ingroup CINDEX
 *
 * @{
 */

/**
 * A compilation database holds all information used to compile files in a
 * project. For each file in the database, it can be queried for the working
 * directory or the command line used for the compiler invocation.
 *
 * Must be freed by \c clang_CompilationDatabase_dispose
 */
CXCompilationDatabase :: distinct rawptr;

/**
 * Contains the results of a search in the compilation database
 *
 * When searching for the compile command for a file, the compilation db can
 * return several commands, as the file may have been compiled with
 * different options in different places of the project. This choice of compile
 * commands is wrapped in this opaque data structure. It must be freed by
 * \c clang_CompileCommands_dispose.
 */
CXCompileCommands :: distinct rawptr;

/**
 * Represents the command line invocation to compile a specific file.
 */
CXCompileCommand :: distinct rawptr;

/**
 * Error codes for Compilation Database
 */
CXCompilationDatabase_Error :: enum c.int {
  /*
   * No error occurred
   */
  CXCompilationDatabase_NoError = 0,

  /*
   * Database can not be loaded
   */
  CXCompilationDatabase_CanNotLoadDatabase = 1

};

@(default_calling_convention="c")
foreign libclang { 
/**
 * Creates a compilation database from the database found in directory
 * buildDir. For example, CMake can output a compile_commands.json which can
 * be used to build the database.
 *
 * It must be freed by \c clang_CompilationDatabase_dispose.
 */
clang_CompilationDatabase_fromDirectory :: proc(BuildDir: cstring, ErrorCode: ^CXCompilationDatabase_Error) -> CXCompilationDatabase ---;

/**
 * Free the given compilation database
 */
clang_CompilationDatabase_dispose :: proc(db: CXCompilationDatabase) ---;

/**
 * Find the compile commands used for a file. The compile commands
 * must be freed by \c clang_CompileCommands_dispose.
 */
clang_CompilationDatabase_getCompileCommands :: proc(db: CXCompilationDatabase,
                                                     CompleteFileName: cstring) -> CXCompileCommands ---;

/**
 * Get all the compile commands in the given compilation database.
 */
clang_CompilationDatabase_getAllCompileCommands :: proc (db: CXCompilationDatabase) -> CXCompileCommands ---;

/**
 * Free the given CompileCommands
 */
clang_CompileCommands_dispose :: (cmd: CXCompileCommands) ---;

/**
 * Get the number of CompileCommand we have for a file
 */
clang_CompileCommands_getSize :: proc(cmd: CXCompileCommands) -> c.uint ---;

/**
 * Get the I'th CompileCommand for a file
 *
 * Note : 0 <= i < clang_CompileCommands_getSize(CXCompileCommands)
 */
clang_CompileCommands_getCommand :: proc(cmd: CXCompileCommands, I: c.uint) -> CXCompileCommand ---;

/**
 * Get the working directory where the CompileCommand was executed from
 */
clang_CompileCommand_getDirectory :: proc(cmd: CXCompileCommand) -> CXString ---;

/**
 * Get the filename associated with the CompileCommand.
 */
clang_CompileCommand_getFilename :: proc(cmd: CXCompileCommand) -> CXString ---;

/**
 * Get the number of arguments in the compiler invocation.
 *
 */
clang_CompileCommand_getNumArgs :: proc(cmd: CXCompileCommand) -> c.uint ---;

/**
 * Get the I'th argument value in the compiler invocations
 *
 * Invariant :
 *  - argument 0 is the compiler executable
 */ 
clang_CompileCommand_getArg :: proc(cmd: CXCompileCommand, I: c.uint) -> CXString ---;

/**
 * Get the number of source mappings for the compiler invocation.
 */
clang_CompileCommand_getNumMappedSources :: proc(cmd: CXCompileCommand) -> c.uint ---;

/**
 * Get the I'th mapped source path for the compiler invocation.
 */ 
clang_CompileCommand_getMappedSourcePath :: proc(cmd: CXCompileCommand, I: c.uint) -> CXString ---;

/**
 * Get the I'th mapped source content for the compiler invocation.
 */
clang_CompileCommand_getMappedSourceContent :: proc(cmd: CXCompileCommand, I: c.uint) -> CXString ---;

/**
 * @}
 */
}