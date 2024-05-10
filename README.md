# pymacro

## This is a simple macro processor.

    usage: pymac.py [-h] [-v] [-d DEB] [-s SKIP] [-i] [-n] infile [outfile]

 Will expand macros into outfile or stdout

A macro is defined with a '\$\$' enclosed sting.

    $$macro_name$$

The macro body is defined after that, terminated by a '@@' enclosed string.

    @$macro_name@@

 The empty terminator '@@ @@' can be used as a convenience;

The macro is expanded by a '%%' enclosed string.

     %%macro_name%%

Here is a complete example macro with expansion:

    $$mac$$ Hello World@@mac@@
    %%mac%%.

Will print the infamous message string.

## Command arguments:

    positional arguments:
      infile
      outfile

    options:
      -h, --help            show this help message and exit
      -v, --verbose         Show operational details. -vv more for output
      -d DEB, --deb DEB     Debug level (0=none 10=Noisy)
      -s SKIP, --skip SKIP  Skip number of initial lines
      -i, --showinput       Show input lines from file
      -n, --norecurse       Do not go recursive. Flat expansion.

Verbose prints file name as it is processed, double verbose injects the macro name
into the target as it is expanded. For troubleshooting only.

Skip lines will ignore the number of leading lines, for instance the #!/usr/bin ..
may be skipped with this option.

## Include search path:

 * Path of the source file,
 * Current directory
 * User's macro path. (~/pymacros).

## Macro Comments:

The strings '$#' '#$' '//#' at the beginning of the line act  as comments.
Those lines are ignored and not prpagated to the output.

The defined macros then referenced by name and a leading / trailing '%%' sign.

### Examples:

     $$hello$$ This is a macro. @@hello@@
     The above macro will be substituted below:
     %%hello%%

All other text is propagated verbatim.

 The special macro / command \$\$include\$\$ will read a macro file into the current
context.

Warnings are issued :

 * if a macro is not defined,
 * the macro had duplicate definition,
 * the macro is not terminated with the same name (except the empty terminator)
 * include file cannot be found.

## Misc:

All the command prefixes / suffixed can be escaped with a backslash to
loose their special meaning.

The indentation of the macro is preserved. The indentation in the target
file is determined by the indentation of the expansion, added to the
indentation of the macro definition.. In short, it will do the
right thing for python code.

  Recursive expansion. Up to six level of recursion is expanded. Make sure that there
are no self referencing macros like:

       $$recurse$$ This macro will $$recurse$$ into itself

  The recursive macro will print many copies (6) into the output. It is not planned to
catch recursion any time soon.


This is a quick hack, please do not expect much here. However this utility is a
life saver for coding.

## Example usage:

  The utility will allow you to refer to code tie a simple macro. For instance the
following code in an include file pulled in to the current context:

    $$include$$ main.inc @@include@@
    $$progname$$ prog="Program Name"
    @@progname@@
    $$code$$# Adding Code:
    aa = 0
    @@code@@
    %%xprologue%%
    %%xmain%%

Will create the following code: (from main.inc):

    !/usr/bin/env python
    import os, sys, string, argparse
    '''
     Header
    '''
    # Globals
    # Start of program:
    if __name__ == '__main__':
        global args
        args = argparser.parse_args()
        if args.debug > 5:
            print (args)
        if len(sys.argv) < 2:
            print("use:  prog="Program Name" infile")
            sys.exit(0)
        if args.outfile:
            if args.infile == args.outfile:
                print("Cannot use the same file as in / out")
                sys.exit(1)
        # Adding Code:
        aa = 0

 See the examples in tests, (mac_1.txt ... mac_N.txt) for more info.

 Peter Glen

// EOF
